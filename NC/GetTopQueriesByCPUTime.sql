SELECT TOP 5
qs.total_worker_time/(qs.execution_count*60000000) as [Avg CPU Time in mins],
qs.execution_count,
qs.min_worker_time/60000000 as [Min CPU Time in mins],
--qs.total_worker_time/qs.execution_count,
SUBSTRING(qt.text,qs.statement_start_offset/2,
(case when qs.statement_end_offset = -1
then len(convert(nvarchar(max), qt.text)) * 2
else qs.statement_end_offset end -qs.statement_start_offset)/2)
as query_text,
 dbname=db_name(qt.dbid),
object_name(qt.objectid) as [Object name]
FROM sys.dm_exec_query_stats qs
cross apply sys.dm_exec_sql_text(qs.sql_handle) as qt
ORDER BY
[Avg CPU Time in mins] DESC