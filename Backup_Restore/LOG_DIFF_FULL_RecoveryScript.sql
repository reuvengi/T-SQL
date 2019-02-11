--------------------------------------------------------------------------------------------
--
-- Description:
--  simple script to generate a restore script that includes the last FULL backup, then the last Differential backup
--  plus each transaction log since the last Differential backup
--
-- Revision history:
-- v1.0, 2019-02-06 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
/* Now lets run a simple script to generate a restore script
that includes the last FULL backup, then the last Differential backup
plus each transaction log since the last Differential backup, 
this can be a life saver */
--BEGIN SCRIPT
DECLARE @databaseName sysname
DECLARE @backupStartDate datetime
DECLARE @backup_set_id_start INT
DECLARE @backup_set_id_FULL INT
DECLARE @backup_set_id_end INT

-- set database to be used
SET @databaseName = 'BackupSample' 

SELECT @backup_set_id_FULL = MAX(backup_set_id) 
	FROM  msdb.dbo.backupset 
	WHERE database_name = @databaseName AND type = 'D'

SELECT @backup_set_id_start = MAX(backup_set_id) 
	FROM  msdb.dbo.backupset 
	WHERE database_name = @databaseName AND type = 'I'

SELECT @backup_set_id_end = MIN(backup_set_id) 
	FROM  msdb.dbo.backupset 
	WHERE database_name = @databaseName AND type = 'D'
	AND backup_set_id > @backup_set_id_start

IF @backup_set_id_end IS NULL SET @backup_set_id_end = 999999999

SELECT backup_set_id, 'RESTORE DATABASE ' + @databaseName + ' FROM DISK = ''' 
               + mf.physical_device_name + ''' WITH NORECOVERY'
	FROM msdb.dbo.backupset b,
         msdb.dbo.backupmediafamily mf
	WHERE b.media_set_id = mf.media_set_id
			AND b.database_name = @databaseName
			AND b.backup_set_id = @backup_set_id_FULL
UNION
SELECT backup_set_id, 'RESTORE DATABASE ' + @databaseName + ' FROM DISK = ''' 
            + mf.physical_device_name + ''' WITH NORECOVERY'
	FROM    msdb.dbo.backupset b,
			msdb.dbo.backupmediafamily mf
	WHERE   b.media_set_id = mf.media_set_id
			AND b.database_name = @databaseName
			AND b.backup_set_id = @backup_set_id_start
UNION
SELECT backup_set_id, 'RESTORE LOG ' + @databaseName + ' FROM DISK = ''' 
         + mf.physical_device_name + ''' WITH NORECOVERY'
	FROM	msdb.dbo.backupset b,
			msdb.dbo.backupmediafamily mf
	WHERE b.media_set_id = mf.media_set_id
			AND b.database_name = @databaseName
			AND b.backup_set_id >= @backup_set_id_start AND b.backup_set_id < @backup_set_id_end
			AND b.type = 'L'
UNION
SELECT 999999999 AS backup_set_id, 'RESTORE DATABASE ' + @databaseName + ' WITH RECOVERY'
ORDER BY backup_set_id;

--END SCRIPT
USE [master];
GO
