--------------------------------------------------------------------------------------------
--
-- Description:
--  Getting the total size of all the databases on the sql server
--
-- Revision history:
-- v1.0, 2020-05-19 Initial version        Christian Solje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
SELECT SUM(size)
FROM sys.database_files
WHERE type = 0;