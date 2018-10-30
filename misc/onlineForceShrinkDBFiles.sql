--------------------------------------------------------------------------------------------
--
-- Description:
--  Shrink the databases online
-- Revision history:
-- v1.0, 2018-10-16 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
use tempdb
go
CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS;
GO
DBCC FREEPROCCACHE;
GO
DBCC FREESYSTEMCACHE ('ALL');
GO
DBCC FREESESSIONCACHE;
GO
DBCC SHRINKDATABASE(tempdb, 10);
GO
DBCC SHRINKFILE (N'tempdev', 1484);
GO
DBCC SHRINKFILE (N'temp2', 1484);
GO
DBCC SHRINKFILE (N'temp3', 1484);
GO
DBCC SHRINKFILE (N'temp4', 1484);
GO
DBCC SHRINKFILE (N'temp5', 1484);
GO
DBCC SHRINKFILE (N'temp6', 1484);
GO
DBCC SHRINKFILE (N'temp7', 1484);
GO
DBCC SHRINKFILE (N'temp8', 1484);
GO
SELECT name, size
FROM sys.master_files
WHERE database_id = DB_ID(N'tempdb');
GO