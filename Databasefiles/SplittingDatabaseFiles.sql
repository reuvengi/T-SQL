--------------------------------------------------------------------------------------------
--
-- Description:
--  Splitting database into multiple database files
-- Revision history:
-- v1.0, 2019-01-15 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
use [PROD_AKT_Organizer]

GO
use [model]

GO
USE [master]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer01', FILENAME = N'S:\SQLDB01\Database\PROD_AKT_Organizer01.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer02', FILENAME = N'S:\SQLDB02\Database\PROD_AKT_Organizer02.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer03', FILENAME = N'S:\SQLDB03\Database\PROD_AKT_Organizer03.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer04', FILENAME = N'S:\SQLDB04\Database\PROD_AKT_Organizer04.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer05', FILENAME = N'S:\SQLDB05\Database\PROD_AKT_Organizer05.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer06', FILENAME = N'S:\SQLDB06\Database\PROD_AKT_Organizer06.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer07', FILENAME = N'S:\SQLDB07\Database\PROD_AKT_Organizer07.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer08', FILENAME = N'S:\SQLDB08\Database\PROD_AKT_Organizer08.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer09', FILENAME = N'S:\SQLDB09\Database\PROD_AKT_Organizer09.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [PROD_AKT_Organizer] ADD FILE ( NAME = N'PROD_AKT_Organizer10', FILENAME = N'S:\SQLDB10\Database\PROD_AKT_Organizer10.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO