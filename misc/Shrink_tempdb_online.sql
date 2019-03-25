--------------------------------------------------------------------------------------------
--
-- Description:
--  Shrink the databases online
--
-- Revision history:
-- v1.0, 2018-10-16 Initial version Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
use [<databasename>]
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
DBCC SHRINKDATABASE('<databasename>', 10);
GO
DBCC SHRINKFILE (N'<dblogicalname>', 1484);
GO
DBCC SHRINKFILE (N'<dblogicalname>2', 1484);
GO
DBCC SHRINKFILE (N'<dblogicalname>3', 1484);
GO
DBCC SHRINKFILE (N'<dblogicalname>4', 1484);
GO
DBCC SHRINKFILE (N'<dblogicalname>5', 1484);
GO
DBCC SHRINKFILE (N'<dblogicalname>6', 1484);
GO
DBCC SHRINKFILE (N'<dblogicalname>7', 1484);
GO
DBCC SHRINKFILE (N'<dblogicalname>8', 1484);
GO
SELECT name, size
FROM sys.master_files
WHERE database_id = DB_ID(N'<databasename>');
GO