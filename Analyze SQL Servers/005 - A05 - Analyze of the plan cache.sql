/*============================================================================
	File:		005 - A05 - Analyze of the plan cache.sql

	Summary:	This script analyzes the current situation in the plan cache
				of the connected SQL Server instance

	Date:		May 2014

	SQL Server Version: 2008 / 2012 / 2014 / 2016
------------------------------------------------------------------------------
	Written by Uwe Ricken, db Berater GmbH

	This script is intended only as a supplement to demos and lectures
	given by Uwe Ricken.  
  
	THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
	ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
	TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
	PARTICULAR PURPOSE.
============================================================================*/
SET NOCOUNT ON
GO

SELECT	TOP (20)
		DEST.text						AS SQL_Batch,
		SUBSTRING
		(
			DEST.text,
			DEQS.statement_start_offset / 2,
			CASE WHEN DEQS.statement_end_offset = -1
				 THEN DATALENGTH(DEST.text)
				 ELSE (DEQS.statement_end_offset - DEQS.statement_start_offset) / 2
			END
		)								AS	SQL_Command,
		DEQP.query_plan,
		DEQS.*,
		last_logical_reads,
		last_logical_reads / 128.0		logical_reads_MB
FROM	sys.dm_exec_query_stats AS DEQS
		CROSS APPLY sys.dm_exec_sql_text(DEQS.sql_handle) AS DEST
		CROSS APPLY sys.dm_exec_query_plan(DEQS.plan_handle) DEQP
ORDER BY
		DEQS.last_logical_reads DESC;
GO


/* Get the amount of allocated RAM by objtype in the plan cache */
SELECT	cacheobjtype,
		objtype,
		SUM(size_in_bytes / 1024.0)				AS	size_in_kb,
		SUM(size_in_bytes / POWER(1024.0, 2))	AS	size_in_MB
FROM	sys.dm_exec_cached_plans AS DECP
GROUP BY
		cacheobjtype,
		objtype
ORDER BY
		cacheobjtype,
		objtype;

/* What queries are defined as ADHOC queries */
SELECT	refcounts,
		usecounts,
		size_in_bytes,
		DEST.Text,
		DEQP.query_plan
FROM	sys.dm_exec_cached_plans AS DECP
		CROSS APPLY sys.dm_exec_sql_text(DECP.plan_handle) AS DEST
		CROSS APPLY sys.dm_exec_query_plan(DECP.plan_handle) AS DEQP
WHERE	objtype = 'Adhoc' AND
		(
			DEST.text NOT LIKE '%SQL doctor%' AND
			DEST.text NOT LIKE 'FETCH API%' AND
			DEST.text NOT LIKE '%SQL diagnostic manager%'
		)
ORDER BY
		size_in_bytes DESC;

/* Information about the IO of the queries */
SELECT	DEST.text,
		SUBSTRING
		(
			DEST.Text,
			DEQS.statement_start_offset / 2,
			CASE WHEN DEQS.statement_end_offset = -1
				 THEN LEN(DEST.text)
				 ELSE (DEQS.statement_end_offset - DEQS.statement_start_offset) / 2
			END
		)		AS	statement,
		DEQS.execution_count,
		DEQS.last_execution_time,
		DEQS.last_logical_reads,
		DEQS.last_logical_writes,
		DEQS.last_rows
FROM	sys.dm_exec_query_stats DEQS
		CROSS APPLY sys.dm_exec_sql_text(DEQS.sql_handle) AS DEST
ORDER BY
		DEQS.execution_count DESC,
		DEQS.last_logical_reads DESC;
GO