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

/****** Object:  StoredProcedure [dbo].[FillPrototype]    Script Date: 8/29/2017 11:02:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[FillPrototype] as

INSERT INTO dw.sql_user
SELECT DISTINCT w.username 
FROM extract.ds_wait_details w 
LEFT JOIN dw.sql_user u ON w.username=u.username
WHERE u.username IS NULL

INSERT INTO dw.sql_user
SELECT DISTINCT w.username 
FROM extract.ds_query_details w 
LEFT JOIN dw.sql_user u ON w.username=u.username
WHERE u.username IS NULL

INSERT INTO dw.wait_type
SELECT DISTINCT w.wait_type, wait_type_text 
FROM extract.ds_wait_details w 
LEFT JOIN dw.wait_type u ON w.wait_type=u.wait_type_code
WHERE u.wait_type_code IS NULL

INSERT INTO dw.query (query_hash)
SELECT DISTINCT w.query_hash
FROM extract.ds_wait_details w 
LEFT JOIN dw.query u ON w.query_hash=u.query_hash
WHERE u.query_hash IS NULL

INSERT INTO dw.query (query_hash)
SELECT DISTINCT w.query_hash
FROM extract.ds_query_details w 
LEFT JOIN dw.query u ON w.query_hash=u.query_hash
WHERE u.query_hash IS NULL

INSERT INTO dw.client_app (client_app_name)
SELECT DISTINCT w.client_app_name
FROM extract.ds_wait_details w 
LEFT JOIN dw.client_app u ON w.client_app_name=u.client_app_name
WHERE u.client_app_name IS NULL

INSERT INTO dw.client_app (client_app_name)
SELECT DISTINCT w.client_app_name
FROM extract.ds_query_details w 
LEFT JOIN dw.client_app u ON w.client_app_name=u.client_app_name
WHERE u.client_app_name IS NULL


insert into dw.waits 
select 
	ISNULL(query_id,-1),
	1 as instance_id,
	ISNULL(sql_user_id,-1),
	ISNULL(client_app_id,-1),
	ISNULL(wait_type_id,-1),
	-1,
	ts,
	duration,
	signal_duration,
	sql,
	query_plan_hash
FROM extract.ds_wait_details w
LEFT JOIN dw.query q ON w.query_hash=q.query_hash
LEFT JOIN dw.sql_user u ON w.username=u.username
LEFT JOIN dw.wait_type wt ON w.wait_type=wt.wait_type_code
LEFT JOIN dw.client_app a ON w.client_app_name=a.client_app_name


insert into [dw].[queries] 
select 
	ISNULL(query_id,-1),
	1 as instance_id,
	ISNULL(sql_user_id,-1),
	ISNULL(client_app_id,-1),
	ts,
	duration,
	cpu_time,
	physical_reads,
	logical_reads,
	writes,
	row_count,
	last_row_count,
	line_number,
	offset,
	offset_end,
	sql,
	query_plan_hash
FROM extract.ds_query_details w
LEFT JOIN dw.query q ON w.query_hash=q.query_hash
LEFT JOIN dw.sql_user u ON w.username=u.username
LEFT JOIN dw.client_app a ON w.client_app_name=a.client_app_name

INSERT INTO [dw].[instance_perfomance_details]
           ([instance_id]
           ,[time_stamp]
           ,[connections]
           ,[memory_available_mb]
           ,[memory_pages_sec]
           ,[memory_grants_pending]
           ,[batch_requests_sec]
           ,[sql_compilations_sec]
           ,[recompilations_sec]
           ,[processor_time_0_pct]
           ,[processor_time_1_pct]
           ,[processor_time_2_pct]
           ,[processor_time_3_pct]
           ,[processor_time_4_pct]
           ,[processor_time_5_pct]
           ,[processor_time_6_pct]
           ,[processor_time_7_pct]
           ,[processor_time_8_pct]
           ,[processor_time_9_pct]
           ,[processor_time_10_pct]
           ,[processor_time_11_pct]
           ,[processor_time_12_pct]
           ,[processor_time_13_pct]
           ,[processor_time_14_pct]
           ,[processor_time_15_pct]
           ,[processor_time_16_pct]
           ,[processor_time_17_pct]
           ,[processor_time_18_pct]
           ,[processor_time_19_pct]
           ,[processor_time_20_pct]
           ,[processor_time_21_pct]
           ,[processor_time_22_pct]
           ,[processor_time_23_pct]
           ,[processor_time_24_pct]
           ,[processor_time_25_pct]
           ,[processor_time_26_pct]
           ,[processor_time_27_pct]
           ,[processor_time_28_pct]
           ,[processor_time_29_pct]
           ,[processor_time_30_pct]
           ,[processor_time_31_pct]
           ,[physical_disk_pct_disk_time_0_pct]
           ,[physical_disk_pct_disk_time_1_pct]
           ,[physical_disk_pct_disk_time_2_pct]
           ,[physical_disk_pct_disk_time_3_pct]
           ,[physical_disk_pct_disk_time_4_pct]
           ,[physical_disk_pct_disk_time_5_pct]
           ,[physical_disk_pct_disk_time_6_pct]
           ,[physical_disk_pct_disk_time_7_pct]
           ,[physical_disk_pct_disk_time_8_pct]
           ,[physical_disk_pct_disk_time_9_pct]
           ,[physical_disk_pct_disk_time_10_pct]
           ,[physical_disk_pct_disk_time_11_pct]
           ,[physical_disk_pct_disk_time_12_pct]
           ,[physical_disk_pct_disk_time_13_pct]
           ,[physical_disk_avg_disk_read_sec_0]
           ,[physical_disk_avg_disk_read_sec_1]
           ,[physical_disk_avg_disk_read_sec_2]
           ,[physical_disk_avg_disk_read_sec_3]
           ,[physical_disk_avg_disk_read_sec_4]
           ,[physical_disk_avg_disk_read_sec_5]
           ,[physical_disk_avg_disk_read_sec_6]
           ,[physical_disk_avg_disk_read_sec_7]
           ,[physical_disk_avg_disk_read_sec_8]
           ,[physical_disk_avg_disk_read_sec_9]
           ,[physical_disk_avg_disk_read_sec_10]
           ,[physical_disk_avg_disk_read_sec_11]
           ,[physical_disk_avg_disk_read_sec_12]
           ,[physical_disk_avg_disk_read_sec_13]
           ,[physical_disk_avg_disk_write_sec_0]
           ,[physical_disk_avg_disk_write_sec_1]
           ,[physical_disk_avg_disk_write_sec_2]
           ,[physical_disk_avg_disk_write_sec_3]
           ,[physical_disk_avg_disk_write_sec_4]
           ,[physical_disk_avg_disk_write_sec_5]
           ,[physical_disk_avg_disk_write_sec_6]
           ,[physical_disk_avg_disk_write_sec_7]
           ,[physical_disk_avg_disk_write_sec_8]
           ,[physical_disk_avg_disk_write_sec_9]
           ,[physical_disk_avg_disk_write_sec_10]
           ,[physical_disk_avg_disk_write_sec_11]
           ,[physical_disk_avg_disk_write_sec_12]
           ,[physical_disk_avg_disk_write_sec_13]
           ,[physical_disk_disk_reads_sec_0]
           ,[physical_disk_disk_reads_sec_1]
           ,[physical_disk_disk_reads_sec_2]
           ,[physical_disk_disk_reads_sec_3]
           ,[physical_disk_disk_reads_sec_4]
           ,[physical_disk_disk_reads_sec_5]
           ,[physical_disk_disk_reads_sec_6]
           ,[physical_disk_disk_reads_sec_7]
           ,[physical_disk_disk_reads_sec_8]
           ,[physical_disk_disk_reads_sec_9]
           ,[physical_disk_disk_reads_sec_10]
           ,[physical_disk_disk_reads_sec_11]
           ,[physical_disk_disk_reads_sec_12]
           ,[physical_disk_disk_reads_sec_13]
           ,[physical_disk_disk_writes_sec_0]
           ,[physical_disk_disk_writes_sec_1]
           ,[physical_disk_disk_writes_sec_2]
           ,[physical_disk_disk_writes_sec_3]
           ,[physical_disk_disk_writes_sec_4]
           ,[physical_disk_disk_writes_sec_5]
           ,[physical_disk_disk_writes_sec_6]
           ,[physical_disk_disk_writes_sec_7]
           ,[physical_disk_disk_writes_sec_8]
           ,[physical_disk_disk_writes_sec_9]
           ,[physical_disk_disk_writes_sec_10]
           ,[physical_disk_disk_writes_sec_11]
           ,[physical_disk_disk_writes_sec_12]
           ,[physical_disk_disk_writes_sec_13]
           ,[processor_queue_length])
SELECT 
	-1 as instance_id,
	CAST(ts as datetime2),
	cast(case when [General Statistics User Connections]='' THEN NULL ELSE [General Statistics User Connections] END as int),
	cast(case when [Memory Available MBytes]='' THEN NULL ELSE [Memory Available MBytes] END as decimal(20,10)),
	CAST(case when [Memory Pages sec]='' THEN NULL ELSE [Memory Pages sec] END as decimal(20,15)),
	cast(case when [Memory Manager Memory Grants Pending]='' THEN NULL ELSE [Memory Manager Memory Grants Pending] END as int),
	CAST(case when [SQL Statistics Batch Requests sec]='' THEN NULL ELSE [SQL Statistics Batch Requests sec] END as decimal(20,15)),
	CAST(case when [SQL Statistics SQL Compilations sec]='' THEN NULL ELSE [SQL Statistics SQL Compilations sec] END as decimal(20,15)),
	CAST(case when [SQL Statistics SQL Re-Compilations sec]='' THEN NULL ELSE [SQL Statistics SQL Re-Compilations sec] END as decimal(20,15)),
	CAST(case when [Processor(0) % Processor Time]='' THEN NULL ELSE [Processor(0) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(1) % Processor Time]='' THEN NULL ELSE [Processor(1) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(2) % Processor Time]='' THEN NULL ELSE [Processor(2) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(3) % Processor Time]='' THEN NULL ELSE [Processor(3) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(4) % Processor Time]='' THEN NULL ELSE [Processor(4) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(5) % Processor Time]='' THEN NULL ELSE [Processor(5) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(6) % Processor Time]='' THEN NULL ELSE [Processor(6) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(7) % Processor Time]='' THEN NULL ELSE [Processor(7) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(8) % Processor Time]='' THEN NULL ELSE [Processor(8) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(9) % Processor Time]='' THEN NULL ELSE [Processor(9) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(10) % Processor Time]='' THEN NULL ELSE [Processor(10) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(11) % Processor Time]='' THEN NULL ELSE [Processor(11) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(12) % Processor Time]='' THEN NULL ELSE [Processor(12) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(13) % Processor Time]='' THEN NULL ELSE [Processor(13) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(14) % Processor Time]='' THEN NULL ELSE [Processor(14) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(15) % Processor Time]='' THEN NULL ELSE [Processor(15) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(16) % Processor Time]='' THEN NULL ELSE [Processor(16) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(17) % Processor Time]='' THEN NULL ELSE [Processor(17) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(18) % Processor Time]='' THEN NULL ELSE [Processor(18) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(19) % Processor Time]='' THEN NULL ELSE [Processor(19) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(20) % Processor Time]='' THEN NULL ELSE [Processor(20) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(21) % Processor Time]='' THEN NULL ELSE [Processor(21) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(22) % Processor Time]='' THEN NULL ELSE [Processor(22) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(23) % Processor Time]='' THEN NULL ELSE [Processor(23) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(24) % Processor Time]='' THEN NULL ELSE [Processor(24) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(25) % Processor Time]='' THEN NULL ELSE [Processor(25) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(26) % Processor Time]='' THEN NULL ELSE [Processor(26) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(27) % Processor Time]='' THEN NULL ELSE [Processor(27) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(28) % Processor Time]='' THEN NULL ELSE [Processor(28) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(29) % Processor Time]='' THEN NULL ELSE [Processor(29) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(30) % Processor Time]='' THEN NULL ELSE [Processor(30) % Processor Time] END as decimal(20,15)),
	CAST(case when [Processor(31) % Processor Time]='' THEN NULL ELSE [Processor(31) % Processor Time] END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(0 C ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(0 C ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(1) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(1) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(2 R ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(2 R ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(3 S ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(3 S ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(4 T ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(4 T ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(5 U ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(5 U ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(6 V ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(6 V ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(7 W ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(7 W ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(8 X ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(8 X ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(9 Y ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(9 Y ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(10 Z ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(10 Z ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(11 O ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(11 O ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(12 P ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(12 P ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(13 Q ) % Disk Time]))='' THEN NULL ELSE CAST([PhysicalDisk(13 Q ) % Disk Time] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(0 C ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(0 C ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(1) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(1) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(2 R ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(2 R ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(3 S ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(3 S ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(4 T ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(4 T ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(5 U ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(5 U ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(6 V ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(6 V ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(7 W ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(7 W ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(8 X ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(8 X ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(9 Y ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(9 Y ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(10 Z ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(10 Z ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(11 O ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(11 O ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(12 P ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(12 P ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(13 Q ) Avg  Disk sec Read]))='' THEN NULL ELSE CAST([PhysicalDisk(13 Q ) Avg  Disk sec Read] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(0 C ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(0 C ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(1) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(1) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(2 R ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(2 R ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(3 S ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(3 S ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(4 T ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(4 T ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(5 U ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(5 U ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(6 V ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(6 V ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(7 W ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(7 W ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(8 X ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(8 X ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(9 Y ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(9 Y ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(10 Z ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(10 Z ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(11 O ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(11 O ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(12 P ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(12 P ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(13 Q ) Avg  Disk sec Write]))='' THEN NULL ELSE CAST([PhysicalDisk(13 Q ) Avg  Disk sec Write] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(0 C ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(0 C ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(1) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(1) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(2 R ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(2 R ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(3 S ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(3 S ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(4 T ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(4 T ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(5 U ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(5 U ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(6 V ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(6 V ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(7 W ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(7 W ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(8 X ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(8 X ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(9 Y ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(9 Y ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(10 Z ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(10 Z ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(11 O ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(11 O ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(12 P ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(12 P ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(13 Q ) Disk Reads sec]))='' THEN NULL ELSE CAST([PhysicalDisk(13 Q ) Disk Reads sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(0 C ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(0 C ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(1) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(1) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(2 R ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(2 R ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(3 S ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(3 S ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(4 T ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(4 T ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(5 U ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(5 U ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(6 V ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(6 V ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(7 W ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(7 W ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(8 X ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(8 X ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(9 Y ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(9 Y ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(10 Z ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(10 Z ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(11 O ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(11 O ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(12 P ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(12 P ) Disk Writes sec] as float) END as decimal(20,15)),
	CAST(case when LTRIM(RTRIM([PhysicalDisk(13 Q ) Disk Writes sec]))='' THEN NULL ELSE CAST([PhysicalDisk(13 Q ) Disk Writes sec] as float) END as decimal(20,15)),
	cast(case when [System Processor Queue Length]='' THEN NULL ELSE [System Processor Queue Length] END as int)
from [extract].[ds_Perfmon]

GO


