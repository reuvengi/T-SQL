--------------------------------------------------------------------------------------------
--
-- Description: 
-- Change the database collation
-- Replace <databasename> with your database
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
USE master;
GO
SELECT name, collation_name
FROM sys.databases
WHERE name = N'<databasename>';
GO

ALTER DATABASE <databasename>
COLLATE SQL_Latin1_General_CP1_CI_AS ;
GO
