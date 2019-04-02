--------------------------------------------------------------------------------------------
--
-- Description:
--  Adding a new filegroup
-- Revision history:
-- v1.0, 2018-10-31 Initial version Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE [master]
GO
ALTER DATABASE [tempdb] ADD FILEGROUP [Secondary]
GO