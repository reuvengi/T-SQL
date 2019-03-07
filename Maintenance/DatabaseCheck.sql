--------------------------------------------------------------------------------------------
--
-- Description:
--  Checks the database consistency
-- 
-- Revision history:
-- v1.0, 2019-03-07 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
-- Check the current database.
DBCC CHECKDB;
GO

-- Check the current database with PHYSICAL_ONLY
DBCC CHECKDB WITH PHYSICAL_ONLY;
GO