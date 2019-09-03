--------------------------------------------------------------------------------------------
--
-- Description:
--  Lists all the sysadmins on the SQL Server Instances
--
-- Revision history:
-- v1.0, 2019-09-03 Initial version        Christian Solje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
SELECT name, type_desc, is_disabled FROM master.sys.server_principals WHERE IS_SRVROLEMEMBER('sysadmin',name) = 1 ORDER BY name