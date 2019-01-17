--------------------------------------------------------------------------------------------
--
-- Description:
--  Moving MDF File
-- Revision history:
-- v1.0,  Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------

USE master;
GO
-- Disconnect all exeisting session.
ALTER DATABASE PROD_AKT_Organizer SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE PROD_AKT_Organizer SET OFFLINE;
GO
ALTER DATABASE PROD_AKT_Organizer MODIFY FILE (Name='PROD_AKT_Organizer', FILENAME='S:\SQLDB01\Database\PROD_AKT_Organizer.mdf')
GO
ALTER DATABASE PROD_AKT_Organizer SET ONLINE;
GO
ALTER DATABASE PROD_AKT_Organizer SET MULTI_USER;
GO 


USE [PROD_AKT_Organizer]
GO
ALTER DATABASE [PROD_AKT_Organizer]  REMOVE FILE [PROD_AKT_Organizer01]
GO
