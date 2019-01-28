--------------------------------------------------------------------------------------------
--
-- Description:
--  Create monitoring on the queries running over 30 minutes
-- Revision history:
-- v1.0, 2019-01-23 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------

CREATE EVENT SESSION [Long_running_queries] ON SERVER 
ADD EVENT sqlserver.rpc_completed(
    ACTION(sqlos.task_time,sqlserver.client_connection_id,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.query_plan_hash,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text)
    WHERE ((([package0].[greater_than_equal_uint64]([sqlserver].[database_id],(4))) AND ([package0].[equal_boolean]([sqlserver].[is_system],(0)))) AND ([package0].[greater_than_uint64]([sqlos].[task_execution_time],(1800000))))),
ADD EVENT sqlserver.sql_batch_completed(
    ACTION(sqlos.task_time,sqlserver.client_connection_id,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.query_plan_hash,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.sql_text)
    WHERE ((([package0].[greater_than_equal_uint64]([sqlserver].[database_id],(4))) AND ([package0].[equal_boolean]([sqlserver].[is_system],(0)))) AND ([package0].[greater_than_uint64]([sqlos].[task_execution_time],(1800000))))) 
ADD TARGET package0.event_file(SET filename=N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Log\Long_running_queries.xel')
WITH (STARTUP_STATE=OFF)
GO
