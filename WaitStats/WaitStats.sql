--------------------------------------------------------------------------------------------
--
-- Description:
--  Wait stats
-- Revision history:
-- v1.0,  Initial version                       Christian Soelje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------

SELECT * FROM sys.dm_os_wait_stats WHERE wait_type LIKE 'LCK%' AND wait_time_ms > 0

SELECT resource_type, request_mode, request_type, request_lifetime FROM sys.dm_tran_locks WHERE request_lifetime > 0
