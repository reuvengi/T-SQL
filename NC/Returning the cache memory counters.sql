SELECT type ,
name ,
single_pages_kb ,
multi_pages_kb ,
single_pages_in_use_kb ,
multi_pages_in_use_kb ,
entries_count ,
entries_in_use_count
FROM sys.dm_os_memory_cache_counters
ORDER BY type,name;