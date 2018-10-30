CREATE DATABASE [dba];
USE [dba]
CREATE TABLE [dbo].[secAudit](
    [ID] [INT] IDENTITY(1,1) NOT NULL,
    [DBUserName] []
)

USE [dba]
GO
/****** Object:  StoredProcedure [dbo].[SaveUsers]    Script Date: 30-10-2018 10:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[SaveUsers]
AS
BEGIN
SET NOCOUNT ON;

TRUNCATE TABLE [dba].[Security].[CreateDBUserMapToServerLoginCMD];
TRUNCATE TABLE [dba].[Security].[GrantDBRoleToDBUserCMD];
TRUNCATE TABLE [dba].[Security].[CreateServerLoginCMD];
TRUNCATE TABLE [dba].[Security].[GrantServerRoleCMD];

INSERT INTO [dba].[Security].[GrantServerRoleCMD]
SELECT 'ALTER SERVER ROLE ['+role.name+'] ADD MEMBER ['+member.name+']', SYSDATETIME() as LoggedDateTime  
FROM sys.server_role_members  
JOIN sys.server_principals AS role  
    ON sys.server_role_members.role_principal_id = role.principal_id  
JOIN sys.server_principals AS member  
    ON sys.server_role_members.member_principal_id = member.principal_id;  
	
Create table #serverlogins ([Command] nvarchar(max))
INSERT INTO #serverlogins
SELECT 'IF(SUSER_ID('+QUOTENAME(SP.name,'''')+') IS NULL)BEGIN CREATE LOGIN '+QUOTENAME(SP.name)+ 
       CASE WHEN SP.type_desc = 'SQL_LOGIN' 
            THEN ' WITH PASSWORD = '+CONVERT(NVARCHAR(MAX),SL.password_hash,1)+' HASHED' 
            ELSE ' FROM WINDOWS' 
       END + ';/*'+SP.type_desc+'*/ END;'  
       COLLATE SQL_Latin1_General_CP1_CI_AS 
  FROM sys.server_principals AS SP 
  LEFT JOIN sys.sql_logins AS SL 
    ON SP.principal_id = SL.principal_id 
 WHERE SP.type_desc IN ('SQL_LOGIN','WINDOWS_GROUP','WINDOWS_LOGIN') 
   AND SP.name NOT LIKE '##%##'  
   AND SP.name NOT IN ('SA');
   
INSERT INTO [dba].[Security].[CreateServerLoginCMD]([Command], [LoggedDateTime])
select Command,
SYSDATETIME() from #serverlogins
DROP TABLE #serverlogins

DECLARE @StrCreateUser NVARCHAR(MAX)
SET @StrCreateUser = '
USE [?]

DECLARE @@DBNAME varchar(255)
SET @@DBNAME = db_name()

INSERT INTO [dba].[Security].[CreateDBUserMapToServerLoginCMD] ([DB], [Command], [LoggedDateTime] )
SELECT @@DBNAME as [DB], 
''CREATE USER ['' + name + '']; ALTER USER ['' + name + ''] WITH login = ['' + name + '']'' as [Command],
Sysdatetime() as [LoggedDateTime]
 from sys.database_principals
 where (Type IN (''U'', ''S'')) AND name NOT IN (''sys'', ''dbo'', ''guest'', ''INFORMATION_SCHEMA'')
'
EXEC SP_msforeachdb @StrCreateUser

DECLARE @StrGrantRole NVARCHAR(MAX)
SET @StrGrantRole = '
USE [?]
DECLARE @@DBNAME varchar(255)
SET @@DBNAME = db_name()

INSERT INTO [dba].[Security].[GrantDBRoleToDBUserCMD] ([DB], [Command], [LoggedDateTime])
 SELECT @@DBNAME as [DB],
 ''EXECUTE sp_addrolemember '''''' + roles.name +'''''', '''''' + users.name + '''''''' as [Command],
 Sysdatetime() as [LoggedDateTime]
 from sys.database_principals users
  inner join sys.database_role_members link
   on link.member_principal_id = users.principal_id
  inner join sys.database_principals roles
   on roles.principal_id = link.role_principal_id
   where users.name <> ''dbo''
'
EXEC sp_MSforeachdb @StrGrantRole

END


