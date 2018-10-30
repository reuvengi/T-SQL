--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	Checking last logon on the SQL server
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
select [name], (select create_date from sys.databases where name='tempdb') as Restart_Time 
from sys.databases where database_id > 4 AND [name] NOT IN (select DB_NAME(database_id) from sys.dm_db_index_usage_stats 
where coalesce(last_user_seek, last_user_scan, last_user_lookup,'1/1/1970') > (select login_time from sysprocesses where spid = 1))
