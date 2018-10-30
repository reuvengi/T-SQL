/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4446)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2016
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [iss_analysis]
GO

/****** Object:  Table [extract].[ds_query_details]    Script Date: 8/30/2017 1:07:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [extract].[ds_query_details](
	[ts] [datetime] NULL,
	[duration] [int] NULL,
	[cpu_time] [int] NULL,
	[physical_reads] [int] NULL,
	[logical_reads] [int] NULL,
	[writes] [int] NULL,
	[row_count] [int] NULL,
	[last_row_count] [int] NULL,
	[line_number] [int] NULL,
	[offset] [int] NULL,
	[offset_end] [int] NULL,
	[sql] [nvarchar](max) NULL,
	[username] [nvarchar](250) NULL,
	[query_plan_hash] [decimal](20, 0) NULL,
	[query_hash] [decimal](20, 0) NULL,
	[database_name] [nvarchar](250) NULL,
	[client_app_name] [nvarchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

