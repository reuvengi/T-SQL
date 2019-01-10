--------------------------------------------------------------------------------------------
--
-- Description:
--  Adding a database to a Avialablity Group
-- Revision history:
-- v1.0, 2019-01-10 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE [master]
GO
ALTER AVAILABILITY GROUP [test-ag] ADD DATABASE [pubs];
GO