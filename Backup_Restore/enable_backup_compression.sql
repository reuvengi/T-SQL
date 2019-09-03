--------------------------------------------------------------------------------------------
--
-- Description:
--  Enable backup compression for a SQL Server instance
--
-- Revision history:
-- v1.0, 2019-07-11 Initial version        Christian Solje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
EXEC sys.sp_configure N'backup compression default', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO