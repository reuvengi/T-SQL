----------------------------------------------------------------------------------------------------------------------------------
--
-- Description: 
--	Links the Login User Name to a SQl User Name on a Database
--	1. Change the [DBName] to the right Database
--	2. Change the LoginUserName to the right LoginUserName in Security -> Logins
--	3. Change the SQLUserName to the right SQLUserName under the [DBName] -> Security -> Users
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version												Christian Soelje (chrs) Sundhedsdata Styrelsen
--
----------------------------------------------------------------------------------------------------------------------------------
USE [DBName]
GO

exec sp_change_users_login 'update_one', 'LoginUserName', 'SQLUserName'
go