-- Who is running what at this instant
SELECT dest.text AS [Command text] ,
des.login_time ,
des.[host_name] ,
des.[program_name] ,
der.session_id ,
dec.client_net_address ,
der.status ,
der.command ,
DB_NAME(der.database_id) AS DatabaseName
FROM sys.dm_exec_requests der
INNER JOIN sys.dm_exec_connections dec
ON der.session_id = dec.session_id
INNER JOIN sys.dm_exec_sessions des
ON des.session_id = der.session_id
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS dest
WHERE des.is_user_process = 1