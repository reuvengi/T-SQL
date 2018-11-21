--SQL Server has included additional information in the execution plan to 
--warn you about a potential problem with the query. This can be anything from tempdb 
--spills to bad cardinality estimates to missing indexes.

SELECT  st.text,
        qp.query_plan
FROM    (
    SELECT  TOP 100 *
    FROM    sys.dm_exec_query_stats
    ORDER BY total_worker_time DESC
) AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
WHERE qp.query_plan.value('declare namespace p="http://schemas.microsoft.com/sqlserver/2004/07/showplan";count(//p:Warnings)', 'int') > 0