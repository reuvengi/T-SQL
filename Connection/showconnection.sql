--------------------------------------------------------------------------------------------
--
-- Description:
--  Shows all connection on the SQL Server with authentication scheme
-- Revision history:
-- v1.0, 2019-01-15 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
SELECT
    s.session_id,
    c.connect_time,
    s.login_time,
    s.login_name,
    c.protocol_type,
    c.auth_scheme,
    s.HOST_NAME,
    s.program_name
FROM sys.dm_exec_sessions s
JOIN sys.dm_exec_connections c
ON s.session_id = c.session_id
ORDER BY auth_scheme DESC