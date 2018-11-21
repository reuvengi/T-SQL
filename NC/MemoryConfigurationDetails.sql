--Determine if this is a 32- or 64-bit SQL Server edition
DECLARE @ServerAddressing AS TINYINT
SELECT @serverAddressing = CASE WHEN CHARINDEX('64',
CAST(SERVERPROPERTY('Edition')
AS VARCHAR(100))) > 0
THEN 64
ELSE 32
END ;
SELECT cpu_count / hyperthread_ratio AS SocketCount ,
physical_memory_in_bytes / 1024 / 1024 AS physical_memory_mb ,
virtual_memory_in_bytes / 1024 / 1024 AS sql_max_virtual_memory_mb ,
-- same with other bpool columns as they are page oriented.
-- Multiplying by 8 takes it to 8K, then / 1024 to convert to mb
bpool_committed * 8 / 1024 AS buffer_pool_committed_mb ,
--64 bit OS does not have limitations with addressing as 32 did
CASE WHEN @serverAddressing = 32
THEN CASE WHEN virtual_memory_in_bytes / 1024 /
( 2048 * 1024 ) < 1
THEN 'off'
ELSE 'on'
END
ELSE 'N/A on 64 bit'
END AS [/3GB switch]
FROM sys.dm_os_sys_info