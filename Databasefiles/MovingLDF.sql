--------------------------------------------------------------------------------------------
--
-- Description:
--  Moving LDF File
-- Revision history:
-- v1.0, 2019-01-15 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE master;
GO
-- Disconnect all exeisting session.
ALTER DATABASE PROD_AKT_Organizer SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE PROD_AKT_Organizer SET OFFLINE;
GO
ALTER DATABASE PROD_AKT_Organizer MODIFY FILE (Name='PROD_AKT_Organizer_log', FILENAME='S:\SQLLog01\Log\PROD_AKT_Organizer_log.ldf')
GO
ALTER DATABASE PROD_AKT_Organizer SET ONLINE;
GO
ALTER DATABASE PROD_AKT_Organizer SET MULTI_USER;
GO 
