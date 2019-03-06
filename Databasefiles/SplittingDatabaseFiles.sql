--------------------------------------------------------------------------------------------
--
-- Description:
--  Splitting database into multiple database files
--
-- Revision history:
-- v1.0, 2019-01-15 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
use [<databasename>]

GO
use [model]

GO
USE [master]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>01', FILENAME = N'S:\SQLDB01\Database\<databasename>01.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>02', FILENAME = N'S:\SQLDB02\Database\<databasename>02.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>03', FILENAME = N'S:\SQLDB03\Database\<databasename>03.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>04', FILENAME = N'S:\SQLDB04\Database\<databasename>04.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>05', FILENAME = N'S:\SQLDB05\Database\<databasename>05.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>06', FILENAME = N'S:\SQLDB06\Database\<databasename>06.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>07', FILENAME = N'S:\SQLDB07\Database\<databasename>07.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>08', FILENAME = N'S:\SQLDB08\Database\<databasename>08.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>09', FILENAME = N'S:\SQLDB09\Database\<databasename>09.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO
ALTER DATABASE [<databasename>] ADD FILE ( NAME = N'<databasename>10', FILENAME = N'S:\SQLDB10\Database\<databasename>10.ndf' , SIZE = 1048576KB , FILEGROWTH = 1048576KB ) TO FILEGROUP [PRIMARY]
GO