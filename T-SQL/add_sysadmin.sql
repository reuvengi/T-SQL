--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	Adding sysadmins to the SQL server
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
USE [master]
GO
CREATE LOGIN [SSI\MSSQLServerAdms] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO
EXEC master..sp_addsrvrolemember @loginame = N'SSI\MSSQLServerAdms', @rolename = N'sysadmin'
GO
