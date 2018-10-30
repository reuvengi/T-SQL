--------------------------------------------------------------------------------------------
--
-- Description:
--
-- Revision history:
-- v1.0, 2018-10-18 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
-- Listing users server permissions
SELECT * FROM fn_my_permissions(NULL, 'SERVER');  
GO  

-- Listing users database,Table,View,Stored Proc and function permissions
USE [DATABASE];
SELECT *
FROM fn_my_permissions (NULL, 'DATABASE');  
GO
SELECT *
FROM fn_my_permissions(NULL, 'OBJECT')
ORDER BY subentity_name, permission_name ;   
GO   

SELECT usr.name AS UserName,
CASE WHEN perm.state <> 'W' THEN perm.state_desc ELSE 'GRANT' END AS PerType,
perm.permission_name,USER_NAME(obj.schema_id) AS SchemaName, obj.name AS ObjectName,
CASE obj.Type 
WHEN 'U' THEN 'Table'
WHEN 'V' THEN 'View'
WHEN 'P' THEN 'Stored Proc'
WHEN 'FN' THEN 'Function'
ELSE obj.Type END AS ObjectType,
CASE WHEN cl.column_id IS NULL THEN '--' ELSE cl.name END AS ColName,
CASE WHEN perm.state = 'W' THEN 'X' ELSE '--' END AS IsGrantOption
FROM sys.database_permissions AS perm
INNER JOIN
sys.objects AS obj
ON perm.major_id = obj.[object_id]
INNER JOIN
sys.database_principals AS usr
ON perm.grantee_principal_id = usr.principal_id
LEFT JOIN
sys.columns AS cl
ON cl.column_id = perm.minor_id AND cl.[object_id] = perm.major_id
WHERE obj.Type <> 'S' 
ORDER BY usr.name, perm.state_desc ASC, perm.permission_name ASC