CREATE EVENT SESSION [iss_extended] ON SERVER 
ADD EVENT sqlos.wait_info(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[query_hash]<>(0))),
ADD EVENT SQLSatellite.connection_accept(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[query_hash]<>(0))),
ADD EVENT sqlserver.perfobject_logicaldisk(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)),
ADD EVENT sqlserver.perfobject_process(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)),
ADD EVENT sqlserver.perfobject_processor(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)),
ADD EVENT sqlserver.perfobject_system(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)),
ADD EVENT sqlserver.sp_statement_completed(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[query_hash]<>(0))),
ADD EVENT sqlserver.sql_statement_completed(
    ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.sql_text,sqlserver.username)
    WHERE ([sqlserver].[query_hash]<>(0)))
ADD TARGET package0.event_file(SET filename=N'f:\Xevent\iss_extended',max_file_size=(51200))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


