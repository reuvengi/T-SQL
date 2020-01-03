--------------------------------------------------------------------------------------------
--
-- Description:
--  Changing tempdb's location
--
-- Revision history:
-- v1.0, 2019-10-25 Initial version        Christian Solje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
-- Getting the name and location of the tempdb
SELECT name, physical_name AS CurrentLocation, state_desc  
FROM sys.master_files  
WHERE database_id = DB_ID(N'tempdb');
GO

USE master;  
GO  
ALTER DATABASE tempdb   
MODIFY FILE (NAME = tempdev, FILENAME = 'E:\SQLData\tempdb.mdf');  
GO  
ALTER DATABASE tempdb   
MODIFY FILE (NAME = templog, FILENAME = 'F:\SQLLog\templog.ldf');  
GO  