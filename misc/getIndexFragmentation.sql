--------------------------------------------------------------------------------------------
--
-- Description:
--
-- Revision history:
-- v1.0, 2018-10-17 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE [DatabaseName];  
GO
-- Find the average fragmentation percentage of all indexes  
-- in the HumanResources.Employee table.   
SELECT a.index_id, name, avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(N'AdvisDb'), 
      OBJECT_ID(N'dbo.Besked'), NULL, NULL, NULL) AS a
    JOIN sys.indexes AS b
    ON a.object_id = b.object_id AND a.index_id = b.index_id;   
GO  