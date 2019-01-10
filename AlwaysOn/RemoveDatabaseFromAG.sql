--------------------------------------------------------------------------------------------
--
-- Description:
--  Removing a database from Avialablity Group
-- Revision history:
-- v1.0, 2019-01-10 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE [master]
GO
ALTER AVAILABILITY GROUP [test-ag] REMOVE DATABASE [pubs];
GO