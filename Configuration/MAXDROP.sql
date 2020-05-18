-------------------------------------------------------------------------------------------------------------
--
-- Description:
--  Setting the Max Degree of Paralism on a MSSQL Server
--
-- Revision history:
-- v1.0, 2020-05-18 Initial version			Christian Soelje (csolje@gmail.com) @dbamist
--
-------------------------------------------------------------------------------------------------------------
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
EXEC sp_configure 'max degree of parallelism', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO