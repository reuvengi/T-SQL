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

/****** Object:  Table [extract].[ds_Perfmon]    Script Date: 8/30/2017 1:07:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [extract].[ds_Perfmon](
	[ts] [varchar](50) NULL,
	[Memory Available MBytes] [varchar](50) NULL,
	[Memory Pages sec] [varchar](50) NULL,
	[General Statistics User Connections] [varchar](50) NULL,
	[Memory Manager Memory Grants Pending] [varchar](50) NULL,
	[SQL Statistics Batch Requests sec] [varchar](50) NULL,
	[SQL Statistics SQL Compilations sec] [varchar](50) NULL,
	[SQL Statistics SQL Re-Compilations sec] [varchar](50) NULL,
	[PhysicalDisk(0 C ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(0 C ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(0 C ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(0 C ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(0 C ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(1) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(1) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(1) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(1) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(1) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(10 Z ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(10 Z ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(10 Z ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(10 Z ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(10 Z ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(11 O ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(11 O ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(11 O ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(11 O ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(11 O ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(12 P ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(12 P ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(12 P ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(12 P ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(12 P ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(13 Q ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(13 Q ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(13 Q ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(13 Q ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(13 Q ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(2 R ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(2 R ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(2 R ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(2 R ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(2 R ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(3 S ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(3 S ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(3 S ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(3 S ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(3 S ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(4 T ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(4 T ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(4 T ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(4 T ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(4 T ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(5 U ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(5 U ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(5 U ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(5 U ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(5 U ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(6 V ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(6 V ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(6 V ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(6 V ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(6 V ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(7 W ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(7 W ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(7 W ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(7 W ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(7 W ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(8 X ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(8 X ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(8 X ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(8 X ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(8 X ) Disk Writes sec] [varchar](50) NULL,
	[PhysicalDisk(9 Y ) % Disk Time] [varchar](50) NULL,
	[PhysicalDisk(9 Y ) Avg  Disk sec Read] [varchar](50) NULL,
	[PhysicalDisk(9 Y ) Avg  Disk sec Write] [varchar](50) NULL,
	[PhysicalDisk(9 Y ) Disk Reads sec] [varchar](50) NULL,
	[PhysicalDisk(9 Y ) Disk Writes sec] [varchar](50) NULL,
	[Processor(0) % Processor Time] [varchar](50) NULL,
	[Processor(1) % Processor Time] [varchar](50) NULL,
	[Processor(10) % Processor Time] [varchar](50) NULL,
	[Processor(11) % Processor Time] [varchar](50) NULL,
	[Processor(12) % Processor Time] [varchar](50) NULL,
	[Processor(13) % Processor Time] [varchar](50) NULL,
	[Processor(14) % Processor Time] [varchar](50) NULL,
	[Processor(15) % Processor Time] [varchar](50) NULL,
	[Processor(16) % Processor Time] [varchar](50) NULL,
	[Processor(17) % Processor Time] [varchar](50) NULL,
	[Processor(18) % Processor Time] [varchar](50) NULL,
	[Processor(19) % Processor Time] [varchar](50) NULL,
	[Processor(2) % Processor Time] [varchar](50) NULL,
	[Processor(20) % Processor Time] [varchar](50) NULL,
	[Processor(21) % Processor Time] [varchar](50) NULL,
	[Processor(22) % Processor Time] [varchar](50) NULL,
	[Processor(23) % Processor Time] [varchar](50) NULL,
	[Processor(24) % Processor Time] [varchar](50) NULL,
	[Processor(25) % Processor Time] [varchar](50) NULL,
	[Processor(26) % Processor Time] [varchar](50) NULL,
	[Processor(27) % Processor Time] [varchar](50) NULL,
	[Processor(28) % Processor Time] [varchar](50) NULL,
	[Processor(29) % Processor Time] [varchar](50) NULL,
	[Processor(3) % Processor Time] [varchar](50) NULL,
	[Processor(30) % Processor Time] [varchar](50) NULL,
	[Processor(31) % Processor Time] [varchar](50) NULL,
	[Processor(4) % Processor Time] [varchar](50) NULL,
	[Processor(5) % Processor Time] [varchar](50) NULL,
	[Processor(6) % Processor Time] [varchar](50) NULL,
	[Processor(7) % Processor Time] [varchar](50) NULL,
	[Processor(8) % Processor Time] [varchar](50) NULL,
	[Processor(9) % Processor Time] [varchar](50) NULL,
	[System Processor Queue Length] [varchar](50) NULL
) ON [PRIMARY]
GO

