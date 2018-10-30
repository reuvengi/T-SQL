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

/****** Object:  Table [dw].[wait_type]    Script Date: 8/30/2017 1:06:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[wait_type](
	[wait_type_id] [int] IDENTITY(1,1) NOT NULL,
	[wait_type_code] [int] NOT NULL,
	[wait_type] [varchar](250) NULL,
 CONSTRAINT [PK__wait_typ__479B0E37FFAEADA8] PRIMARY KEY CLUSTERED 
(
	[wait_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

