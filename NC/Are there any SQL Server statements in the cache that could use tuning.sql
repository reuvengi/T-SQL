SELECT top 10 text as "SQL Statement",
   last_execution_time as "Last Execution Time",
   (total_logical_reads+total_physical_reads+total_logical_writes)/execution_count as [Average IO],
   (total_worker_time/execution_count)/1000000.0 as [Average CPU Time (sec)],
   (total_elapsed_time/execution_count)/1000000.0 as [Average Elapsed Time (sec)],
   execution_count as "Execution Count",
   qp.query_plan as "Query Plan"
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle) st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
order by total_elapsed_time/execution_count desc
