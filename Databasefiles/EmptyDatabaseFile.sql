--------------------------------------------------------------------------------------------
--
-- Description:
--  Empty database file by migrating data to other files in the same filegroup
--
-- Revision history:
-- v1.0, 2019-01-15 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE [Databasename]
GO
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
DBCC SHRINKFILE ('DBLogicalName', EMPTYFILE);