--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (csolje@gmail.com) 
--
--------------------------------------------------------------------------------------------

-- in master
create login [admcso] with password = 'YYYYY'
create user [admcso] from login [admcso];

-- if you want the user to be able to create databases and logins
exec sp_addRoleMember 'dbmanager', 'admcso';
exec sp_addRoleMember 'loginmanager', 'admcso'

-- in each individual database, to grant dbo
create user [admcso] from login [admcso];
exec sp_addRoleMember 'db_owner', 'admcso';