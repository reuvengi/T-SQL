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

/****** Object:  Table [dw].[client_app]    Script Date: 8/30/2017 1:02:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[client_app](
	[client_app_id] [int] IDENTITY(1,1) NOT NULL,
	[client_app_name] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[client_app_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

