--------------------------------------------------------------------------------------------
--
-- Description:
--  Creates a database on mount point and splits the data files up on the data mount points
-- Revision history:
-- v1.0, 2018-11-23 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
CREATE DATABASE [databasename]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'<databasename>', FILENAME = N'<data mountpoint1>' , SIZE = 8192KB , FILEGROWTH = 65536KB ),
( NAME = N'<databasename_number>', FILENAME = N'<data mountpoint2>' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'<databaselogname_log>', FILENAME = N'<logfile path>' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [databasename] MODIFY FILEGROUP [PRIMARY] AUTOGROW_ALL_FILES
GO