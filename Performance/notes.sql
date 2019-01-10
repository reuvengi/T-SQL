
-- Dynamic management views
SELECT * FROM sys.dm_exec_sessions AS es
CROSS APPLY sys.dm_exec_input_buffer(es.session_id, NULL) AS ib
WHERE es.session_id > 50

-- Longest running query
SELECT TOP 10
t.TEXT QueryName,
s.execution_count AS ExecutionCount,
s.max_elapsed_time AS MaxElapsedTime,
ISNULL(s.total_elapsed_time / 1000 / NULLIF(s.execution_count, 0), 0) AS AvgElapsedTime,
s.creation_time AS LogCreatedOn,
ISNULL(s.execution_count / 1000 / NULLIF(DATEDIFF(s, s.creation_time, GETDATE()), 0), 0) AS FrequencyPerSec
,query_plan
FROM sys.dm_exec_query_stats s
CROSS APPLY sys.dm_exec_query_plan( s.plan_handle ) u
CROSS APPLY sys.dm_exec_sql_text( s.plan_handle ) t
ORDER BY MaxElapsedTime DESC

-- Isolate top waits for server instance since last restart or statistics clear
WITH Waits AS
(SELECT wait_type, wait_time_ms / 1000. AS wait_time_s,
100. * wait_time_ms / SUM(wait_time_ms) OVER() AS pct,
ROW_NUMBER() OVER(ORDER BY wait_time_ms DESC) AS rn
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN ('CLR_SEMAPHORE','LAZYWRITER_SLEEP','RESOURCE_QUEUE','SLEEP_TASK'
,'SLEEP_SYSTEMTASK','SQLTRACE_BUFFER_FLUSH','WAITFOR', 'LOGMGR_QUEUE','CHECKPOINT_QUEUE'
,'REQUEST_FOR_DEADLOCK_SEARCH','XE_TIMER_EVENT','BROKER_TO_FLUSH','BROKER_TASK_STOP','CLR_MANUAL_EVENT'
,'CLR_AUTO_EVENT','DISPATCHER_QUEUE_SEMAPHORE', 'FT_IFTS_SCHEDULER_IDLE_WAIT'
,'XE_DISPATCHER_WAIT', 'XE_DISPATCHER_JOIN', 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP'))
SELECT W1.wait_type,
CAST(W1.wait_time_s AS DECIMAL(12, 2)) AS wait_time_s,
CAST(W1.pct AS DECIMAL(12, 2)) AS pct,
CAST(SUM(W2.pct) AS DECIMAL(12, 2)) AS running_pct
FROM Waits AS W1
INNER JOIN Waits AS W2
ON W2.rn <= W1.rn
GROUP BY W1.rn, W1.wait_type, W1.wait_time_s, W1.pct
HAVING SUM(W2.pct) - W1.pct < 99 OPTION (RECOMPILE); -- percentage threshold
GO

/************************************************************ 
Step 1: Get the plan for the slow query
************************************************************/

SELECT
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1, 
        ((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(st.text) ELSE qs.statement_end_offset END 
            - qs.statement_start_offset)/2) + 1) AS [query_text],
    qs.execution_count,
    qs.total_worker_time,
    qs.total_logical_reads,
    qs.total_elapsed_time,
    qp.query_plan
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text (plan_handle) as st
CROSS APPLY sys.dm_exec_query_plan (plan_handle) AS qp
WHERE st.text like '%si.LastEditedWhen >= @CutoffDate;%'
    OPTION (RECOMPILE);
GO
/************************************************************ 
Step 2: Save that plan!
************************************************************/

/************************************************************ 
Step 3: Inspect the parameters
************************************************************/

/************************************************************ 
Step 4: Were row estimates close?
The easiest way to guess at this is to get an actual plan -- if it's OK
to rerun the query
************************************************************/

/************************************************************ 
Step 5: Is the query actually slow?
************************************************************/
SET STATISTICS IO, TIME ON;
GO
The Query that is slow
SET STATISTICS IO, TIME ON;
GO

/************************************************************ 
Step 6: Inspect your statistics (if needed)
************************************************************/
/* If using SQL Server 2008 or prior, a query that works with those versions is at
https://www.littlekendra.com/2016/12/06/when-did-sql-server-last-update-that-statistic-how-much-has-been-modified-since-and-what-columns-are-in-the-stat/
*/
SELECT 
    stat.auto_created,
    stat.name as stats_name,
    STUFF((SELECT ', ' + cols.name
        FROM sys.stats_columns AS statcols
        JOIN sys.columns AS cols ON
            statcols.column_id=cols.column_id
            AND statcols.object_id=cols.object_id
        WHERE statcols.stats_id = stat.stats_id and
            statcols.object_id=stat.object_id
        ORDER BY statcols.stats_column_id
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)'), 1, 2, '')  as stat_cols,
    stat.filter_definition,
    stat.is_temporary,
    stat.no_recompute,
    sp.last_updated,
    sp.modification_counter,
    sp.rows,
    sp.rows_sampled
FROM sys.stats as stat
CROSS APPLY sys.dm_db_stats_properties (stat.object_id, stat.stats_id) AS sp
JOIN sys.objects as so on 
    stat.object_id=so.object_id
JOIN sys.schemas as sc on
    so.schema_id=sc.schema_id
WHERE 
    sc.name= 'Sales'
    and so.name='Invoices'
ORDER BY 1, 2;
GO