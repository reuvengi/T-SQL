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

/****** Object:  Table [extract].[ds_wait_details]    Script Date: 8/30/2017 1:07:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [extract].[ds_wait_details](
	[ts] [datetime] NULL,
	[wait_type] [int] NULL,
	[wait_type_text] [varchar](50) NULL,
	[opcode] [int] NULL,
	[opcode_text] [varchar](50) NULL,
	[duration] [int] NULL,
	[signal_duration] [int] NULL,
	[wait_ressource] [binary](8) NULL,
	[username] [nvarchar](250) NULL,
	[sql] [nvarchar](max) NULL,
	[query_plan_hash] [decimal](20, 0) NULL,
	[query_hash] [decimal](20, 0) NULL,
	[database_name] [nvarchar](250) NULL,
	[client_app_name] [nvarchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

