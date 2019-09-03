--------------------------------------------------------------------------------------------
--
-- Description:
--  Lists all the sysadmins on the SQL Server Instances
--
-- Revision history:
-- v1.0, 2019-09-03 Initial version        Christian Solje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
SELECT 'Name' = sp.NAME
    ,sp.is_disabled AS [Is_disabled]
FROM sys.server_role_members rm
    ,sys.server_principals sp
WHERE rm.role_principal_id = SUSER_ID('Sysadmin')
    AND rm.member_principal_id = sp.principal_id