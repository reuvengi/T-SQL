ALTER DATABASE [Prod_ETL]
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

CHECKPOINT;

BACKUP DATABASE [Prod_ETL] TO  DISK = N'U:\Program Files\Microsoft SQL Server\MSSQL13.INSIGHT3TEST\MSSQL\Prod_ETL\Prod_ETL_FULL.bak' WITH NOFORMAT, INIT,  NAME = N'Prod_ETL-Full Database Prod_ETL', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10, CHECKSUM
GO
USE master ;  
ALTER DATABASE [Prod_ETL] SET RECOVERY FULL ;
USE [Prod_ETL]
GO
BACKUP LOG [Prod_ETL] TO  DISK = N'U:\Program Files\Microsoft SQL Server\MSSQL13.INSIGHT3TEST\MSSQL\Prod_ETL\Prod_ETL_Trans.trn' WITH NOFORMAT, INIT,  NAME = N'Prod_ETL-Trans Database Prod_ETL', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10, CHECKSUM
GO

USE master ;  
ALTER DATABASE [Prod_ETL] SET RECOVERY SIMPLE ;
USE [Prod_ETL]
GO

-- shrink the log file to 1024MB
DBCC SHRINKFILE (N'Prod_ETL_log',1024);

-- Getting the File sizes
SELECT name, size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS AvailableSpaceInMB
FROM sys.database_files;

SELECT * FROM sys.databases
SELECT Name, user_access_desc, state_desc, recovery_model_desc, log_reuse_wait_desc FROM sys.databases

SELECT Name,
   physical_Name,
   database_id,
   FILE_ID,
   type_desc,
   state_desc,
   SIZE * 8 / 1024 AS SizeMB
FROM   sys.master_files
WHERE database_id > 4

SELECT Name, log_reuse_wait_desc FROM sys.databases
EXECUTE sys.sp_cdc_help_change_data_capture;  
GO  
DBCC OPENTRAN;
GO


--Getting log files info
DBCC LOGINFO (N'Prod_ETL');
GO


DBCC SQLPERF(LOGSPACE);  
GO  

--- define the initial size to 2048 or 8192MB as well.. CHANGE it as per your needs!
ALTER DATABASE [Prod_ETL]
MODIFY FILE (NAME=N'Prod_ETL_log',SIZE = 2048MB,MAXSIZE=8192,FILEGROWTH=1024MB);
Go

ALTER DATABASE [Prod_ETL]
SET MULTI_USER;
GO

-- find session id
select session_id,sqltext.text
 from sys.dm_exec_requests 
 cross apply
sys.dm_exec_sql_text(sql_handle)sqltext


KILL 55
KILL 84
KILL 85
KILL 88
KILL 89
KILL 90
KILL 91
KILL 92
KILL 110