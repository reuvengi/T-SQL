----------------------------------------------------------------------------------------------------------------------------------
--
-- Description: 
--	Listing all Microsoft SQL Server Logins AD and SQL users
--
-- Revision history:
-- v1.0, 2016-02-01 Initial version												Christian Soelje (chrs) Sundhedsdata Styrelsen
--
----------------------------------------------------------------------------------------------------------------------------------
USE master;
GO
SELECT name as Login_Name, type_desc AS Account_Type
FROM sys.server_principals
WHERE TYPE IN ('U','S','G')
AND name not like '%##%'
ORDER BY name, type_desc