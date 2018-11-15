--------------------------------------------------------------------------------------------
--
-- Description:
--  Reads the sqlaudit file 
-- Revision history:
-- v1.0, 2018-11-15 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------

SELECT event_time
	,session_server_principal_name AS Changed_by
	,target_server_principal_name AS LoginName
	,server_instance_name
	,statement
FROM sys.fn_get_audit_file('s:\Backup01\*.sqlaudit', DEFAULT, DEFAULT)
WHERE action_id = 'G'
	OR action_id = 'APRL';