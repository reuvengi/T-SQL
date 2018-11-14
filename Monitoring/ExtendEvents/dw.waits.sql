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

/****** Object:  Table [dw].[waits]    Script Date: 8/30/2017 1:06:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[waits](
	[query_id] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[sql_user_id] [int] NOT NULL,
	[client_app_id] [int] NOT NULL,
	[wait_type_id] [int] NOT NULL,
	[wait_ressource_id] [int] NOT NULL,
	[time_stamp] [datetime] NOT NULL,
	[duration] [int] NOT NULL,
	[signal_duration] [int] NOT NULL,
	[sql_query] [varchar](max) NOT NULL,
	[query_plan_hash] [decimal](20, 0) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

