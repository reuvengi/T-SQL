/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4446)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2016
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [iss_mondb]
GO

/****** Object:  StoredProcedure [dbo].[ExtractXEFiles]    Script Date: 8/29/2017 10:58:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ExtractXEFiles]
AS
BEGIN 

TRUNCATE TABLE [extract].ds_query_details;

WITH sql_statement_completed as 
(
	SELECT 
	top 100000
		object_name,
		CONVERT(xml,event_data) as event_data
	FROM sys.fn_xe_file_target_read_file('f:\xevent\iss_udvidet*.xel', null, null, null) 
	WHERE object_name IN ('sql_statement_completed','sp_completed')
)
INSERT INTO [extract].ds_query_details
SELECT 
	ts    = event_data.value(N'(event/@timestamp)[1]', N'datetime'),
	[duration] = event_data.value(N'(event/data[@name="duration"]/value)[1]', N'int'),
	[cpu_time] = event_data.value(N'(event/data[@name="cpu_time"]/value)[1]', N'int'),
	[physical_reads] = event_data.value(N'(event/data[@name="physical_reads"]/value)[1]', N'int'),
	[logical_reads] = event_data.value(N'(event/data[@name="logical_reads"]/value)[1]', N'int'),
	[writes] = event_data.value(N'(event/data[@name="writes"]/value)[1]', N'int'),
	[row_count] = event_data.value(N'(event/data[@name="row_count"]/value)[1]', N'int'),
	[last_row_count] = event_data.value(N'(event/data[@name="row_count"]/value)[1]', N'int'),
	[line_number] = event_data.value(N'(event/data[@name="line_number"]/value)[1]', N'int'),
	[offset] = event_data.value(N'(event/data[@name="offset"]/value)[1]', N'int'),
	[offset_end] = event_data.value(N'(event/data[@name="offset_end"]/value)[1]', N'int'),
	[sql] = event_data.value(N'(event/action[@name="sql_text"]/value)[1]', N'nvarchar(max)'),
	[username] = event_data.value(N'(event/action[@name="username"]/value)[1]', N'nvarchar(250)'),
	[query_plan_hash] = event_data.value(N'(event/action[@name="query_plan_hash"]/value)[1]', N'decimal(20,0)'),
	[query_hash] = event_data.value(N'(event/action[@name="query_hash"]/value)[1]', N'decimal(20,0)'),
	[database_name] = event_data.value(N'(event/action[@name="database_name"]/value)[1]', N'nvarchar(250)'),
	[client_app_name] = event_data.value(N'(event/action[@name="client_app_name"]/value)[1]', N'nvarchar(250)')
FROM sql_statement_completed;

TRUNCATE TABLE [extract].ds_wait_details;

WITH wait_info as 
(
SELECT 
top 100000
	object_name,
	CONVERT(xml,event_data) as event_data
FROM sys.fn_xe_file_target_read_file('f:\xevent\iss_udvidet*.xel', 'f:\xevent\*.xem', null, null) 
WHERE object_name IN ('wait_info')
)
INSERT INTO [extract].ds_wait_details
SELECT 
	ts    = event_data.value(N'(event/@timestamp)[1]', N'datetime'),
	[wait_type] = event_data.value(N'(event/data[@name="wait_type"]/value)[1]', N'int'),
	[wait_type_text] = event_data.value(N'(event/data[@name="wait_type"]/text)[1]', N'varchar(50)'),
	[opcode] = event_data.value(N'(event/data[@name="opcode"]/value)[1]', N'int'),
	[opcode_text] = event_data.value(N'(event/data[@name="opcode"]/text)[1]', N'varchar(50)'),
	[duration] = event_data.value(N'(event/data[@name="duration"]/value)[1]', N'int'),
	[signal_duration] = event_data.value(N'(event/data[@name="signal_duration"]/value)[1]', N'int'),
	[wait_ressource] = event_data.value(N'(event/data[@name="wait_ressource"]/value)[1]', N'binary(8)'),
	[username] = event_data.value(N'(event/action[@name="username"]/value)[1]', N'nvarchar(250)'),
	[sql] = event_data.value(N'(event/action[@name="sql_text"]/value)[1]', N'nvarchar(max)'),
	[query_plan_hash] = event_data.value(N'(event/action[@name="query_plan_hash"]/value)[1]', N'decimal(20,0)'),
	[query_hash] = event_data.value(N'(event/action[@name="query_hash"]/value)[1]', N'decimal(20,0)'),
	[database_name] = event_data.value(N'(event/action[@name="database_name"]/value)[1]', N'nvarchar(250)'),
	[client_app_name] = event_data.value(N'(event/action[@name="client_app_name"]/value)[1]', N'nvarchar(250)')
FROM wait_info;

END
GO


