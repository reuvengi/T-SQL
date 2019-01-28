--------------------------------------------------------------------------------------------
--
-- Description:
--  Queries that are using a specific index based on Query Store
-- Revision history:
-- v1.0, 2019-01-23 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
SELECT SUM(qsrs.count_executions), TRY_CONVERT(XML, qsp.query_plan) AS query_plan_xml
FROM [sys].[query_store_plan] qsp
INNER JOIN [sys].[query_store_runtime_stats] qsrs ON qsp.plan_id = qsrs.plan_id
--CROSS APPLY (SELECT TRY_CONVERT(XML, qsp.query_plan) AS query_plan_xml) AS qpx
where  qsp.query_plan like '%Table="[[]Aktivitet]" Index="[[]IX_Sag_Id]"%'
GROUP BY  qsp.query_plan
order by SUM(qsrs.count_executions) desc