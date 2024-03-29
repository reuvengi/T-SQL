USE [DBADB]
GO
/****** Object:  StoredProcedure [dbo].[GenerateRestoreScript]    Script Date: 10-04-2015 14:41:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GenerateRestoreScript] 
AS
SET NOCOUNT ON-- required because we're going to print T-SQL for the restores in the messages 'tab' of SSMS

DECLARE @lastFullBackup INT, @lastFullBackupPath VARCHAR(4000), @lastFullBackupPathSub VARCHAR(2000)
DECLARE @lastDifferentialBackup INT, @lastDifferentialBackupPath VARCHAR(4000), @lastDifferentialBackupPathSub VARCHAR(2000)
DECLARE @i INT, @logBackupPath VARCHAR(4000), @logBackupPathSub VARCHAR(2000), @tailLogName VARCHAR(2000), @tailLogCreated BIT = 0
DECLARE @databases CURSOR
DECLARE @files CURSOR
DECLARE @DBName VARCHAR(1000)
DECLARE @DBNameFS VARCHAR(1000)
DECLARE @DefaultBackupDirectory nvarchar(4000) = NULL
DECLARE @InstanceDirectory nvarchar(4000) = NULL
DECLARE @OutputFile nvarchar(4000) = NULL

-- find default backup directory for server
EXECUTE [master].dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', N'BackupDirectory', @DefaultBackupDirectory OUTPUT
SET @InstanceDirectory = @DefaultBackupDirectory + '\' + REPLACE(CAST(SERVERPROPERTY('servername') AS nvarchar),'\','$')

-- find databases
SET @databases = CURSOR FOR
  SELECT [name] AS DatabaseName, 
         REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([name],'\',''),'/',''),':',''),'*',''),'?',''),'"',''),'<',''),'>',''),'|',''),' ','') AS DatabaseNameFS
  FROM sys.databases
  WHERE name != 'tempdb'

OPEN @databases
FETCH NEXT FROM @databases INTO @DBName, @DBNameFS
WHILE @@FETCH_STATUS = 0
BEGIN
PRINT '-----------------------------------------------------'
PRINT ''

-- remove temp object that might exist
IF OBJECT_ID('tempdb..#MSDBBackupHistory') IS NOT NULL
    DROP TABLE #MSDBBackupHistory

IF OBJECT_ID('tempdb..#MSDBBackupHistoryFiles') IS NOT NULL
    DROP TABLE #MSDBBackupHistoryFiles

-- master table
CREATE TABLE #MSDBBackupHistory (
    id INT IDENTITY(1,1),
	media_set_id INT,
    backup_start_date DATETIME,
    backup_type CHAR(1))

-- detail table
CREATE TABLE #MSDBBackupHistoryFiles (
    bh_id INT,
    media_set_id INT,
    family_sequence_number TINYINT,
    physical_device_name VARCHAR(1000))

INSERT INTO #MSDBBackupHistory (media_set_id, backup_start_date, backup_type)
    SELECT BS.media_set_id, BS.backup_start_date, BS.type
    FROM msdb..backupset BS 
    WHERE BS.database_name = @DBName
    ORDER BY BS.backup_start_date 

INSERT INTO #MSDBBackupHistoryFiles (bh_id, media_set_id, family_sequence_number, physical_device_name)
    SELECT BH.id, BH.media_set_id, BMF.family_sequence_number, RTRIM(BMF.physical_device_name)
    FROM #MSDBBackupHistory BH JOIN msdb..backupmediafamily BMF ON BMF.media_set_id=BH.media_set_id

-- Tail log backup (if exists)
SET @tailLogCreated = 0
SET @i = (SELECT MAX(id) FROM #MSDBBackupHistory WHERE backup_type='L')
IF (@i>0) 
BEGIN
  -- Find latest log backup path
  SET @tailLogCreated = 1
  SET @logBackupPath = (SELECT TOP 1 physical_device_name FROM #MSDBBackupHistoryFiles WHERE bh_id=@i)
  -- Remove filename
  SET @logBackupPath = LEFT(@logBackupPath, LEN(@logBackupPath)-CHARINDEX('\', REVERSE(@logBackupPath)))
  -- Add taillog filename
  SET @tailLogName = @logBackupPath + '\' + REPLACE(CAST(SERVERPROPERTY('servername') AS nvarchar),'\','$') + '_' + @DBName + '_TAILLOG_' + CONVERT(varchar(8),getdate(),112) + '_' + REPLACE(CONVERT(varchar(8),getdate(),108),':','') + '_TAILLOG.trn'
  PRINT '-- Perform a tail log backup if possible'
  PRINT '-- BACKUP LOG ' + @DBName + ' TO DISK = N''' + @tailLogName + ''' WITH INIT, NO_TRUNCATE'
  PRINT '-- GO'
  PRINT ''
END

-- get the last Full backup info
SET @lastFullBackup = (SELECT MAX(id) FROM #MSDBBackupHistory WHERE backup_type='D')

-- find backup files - can be multiple
SET @files = CURSOR FOR
  SELECT   physical_device_name
  FROM     #MSDBBackupHistoryFiles
  WHERE    bh_id = @lastFullBackup
  ORDER BY family_sequence_number ASC

-- build filename string
SET @lastFullBackupPath = ''
OPEN @files
FETCH NEXT FROM @files INTO @lastFullBackupPathSub
WHILE @@FETCH_STATUS = 0
BEGIN
  IF NOT (@lastFullBackupPath = '')
  BEGIN
    SET @lastFullBackupPath = @lastFullBackupPath + CHAR(13) + CHAR(10) + ', '
  END
  SET @lastFullBackupPath = @lastFullBackupPath + 'DISK = ''' + @lastFullBackupPathSub + ''''
  FETCH NEXT FROM @files INTO @lastFullBackupPathSub
END
CLOSE @files
DEALLOCATE @files

-- Restore the Full backup
PRINT 'RESTORE DATABASE ' + @DBName
PRINT 'FROM '
PRINT @lastFullBackupPath
IF (@DBName = 'master' OR @DBName = 'msdb')
BEGIN
  PRINT 'WITH RECOVERY' 
END
ELSE IF (@DBName = 'model')
BEGIN
  PRINT 'WITH REPLACE'
END
ELSE
BEGIN
  PRINT 'WITH NORECOVERY'
END
PRINT 'GO'
PRINT ''

-- get the last Differential backup (it must be done after the last Full backup)
SET @lastDifferentialBackup = (SELECT MAX(id) FROM #MSDBBackupHistory WHERE backup_type='I' AND id > @lastFullBackup)

-- find backup files - can be multiple
SET @files = CURSOR FOR
  SELECT   physical_device_name
  FROM     #MSDBBackupHistoryFiles
  WHERE    bh_id = @lastDifferentialBackup
  ORDER BY family_sequence_number ASC

-- build filename string
SET @lastDifferentialBackupPath = ''
OPEN @files
FETCH NEXT FROM @files INTO @lastDifferentialBackupPathSub
WHILE @@FETCH_STATUS = 0
BEGIN
  IF NOT (@lastDifferentialBackupPath = '')
  BEGIN
    SET @lastDifferentialBackupPath = @lastDifferentialBackupPath + CHAR(13) + CHAR(10) + ', '
  END
  SET @lastDifferentialBackupPath = @lastDifferentialBackupPath + 'DISK = ''' + @lastDifferentialBackupPathSub + ''''
  FETCH NEXT FROM @files INTO @lastDifferentialBackupPathSub
END
CLOSE @files
DEALLOCATE @files

-- when there's a differential backup after the last full backup create the restore T-SQL commands
IF (@lastDifferentialBackup IS NOT NULL)
BEGIN
    -- Restore last diff. backup
    PRINT 'RESTORE DATABASE ' + @DBName
    PRINT 'FROM '
	PRINT  @lastDifferentialBackupPath
    PRINT 'WITH NORECOVERY'
    PRINT 'GO'
    PRINT '' -- new line for readability
END

-- construct the required TRANSACTION LOGs restores
IF (@lastDifferentialBackup IS NULL) -- no diff backup made?
    SET @i = @lastFullBackup + 1    -- search for log dumps after the last full
ELSE SET @i = @lastDifferentialBackup + 1 -- search for log dumps after the last diff

-- script T-SQL restore commands from the log backup history
WHILE (@i <= (SELECT MAX(id) FROM #MSDBBackupHistory))
BEGIN
	-- find backup files - can be multiple
	SET @files = CURSOR FOR
	  SELECT   physical_device_name
	  FROM     #MSDBBackupHistoryFiles
	  WHERE    bh_id = @i
	  ORDER BY family_sequence_number ASC
	
	-- build filename string
	SET @logBackupPath = ''
	OPEN @files
	FETCH NEXT FROM @files INTO @logBackupPathSub
	WHILE @@FETCH_STATUS = 0
	BEGIN
	  IF NOT (@logBackupPath = '')
	  BEGIN
		SET @logBackupPath = @logBackupPath + CHAR(13) + CHAR(10) + ', '
	  END
	  SET @logBackupPath = @logBackupPath + 'DISK = ''' + @logBackupPathSub + ''''
	  FETCH NEXT FROM @files INTO @logBackupPathSub
	END
	CLOSE @files
	DEALLOCATE @files

    PRINT 'RESTORE LOG ' + @DBName
    PRINT 'FROM ' 
	PRINT @logBackupPath
	PRINT 'WITH NORECOVERY'   
    PRINT 'GO'
    PRINT '' -- new line for readability

    SET @i = @i + 1 -- try to find the next log entry
END

IF (@tailLogCreated = 1)
BEGIN
  PRINT '-- Restore tail log if taken at the beginning'
  PRINT '-- RESTORE LOG ' + @DBName + ' FROM DISK = N''' + @tailLogName + ''' WITH NORECOVERY'
  PRINT '-- GO'
  PRINT ''
END

IF NOT (@DBName = 'master' OR @DBName = 'model' OR @DBName = 'msdb')
BEGIN
  PRINT '-- Open database for users'
  PRINT '-- RESTORE DATABASE ' + @DBName + ' WITH RECOVERY'
  PRINT '-- GO'
  PRINT ''
END

-- remove temp objects that exist
IF OBJECT_ID('tempdb..#MSDBBackupHistory') IS NOT NULL
    DROP TABLE #MSDBBackupHistory

IF OBJECT_ID('tempdb..#MSDBBackupHistoryFiles') IS NOT NULL
    DROP TABLE #MSDBBackupHistoryFiles

FETCH NEXT FROM @databases INTO @DBName, @DBNameFS

END
CLOSE @databases
DEALLOCATE @databases

