--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	Checking the Database which recovery model is not full
--
-- Revision history:
-- v1.0, 2015-10-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
USE master
GO

SET QUOTED_IDENTIFIER ON

-- Declare the variable to store the value [database name] returned by FETCH.
DECLARE @dbname sysname

-- Declare a cursor to iterate through the list of databases
DECLARE db_recovery_cursor CURSOR FOR
SELECT name from sysdatabases

-- Open the cursor
OPEN db_recovery_cursor

-- Perform the first fetch and store the value in a variable.
FETCH NEXT FROM db_recovery_cursor INTO @dbname

-- loop through cursor until no more records fetched
WHILE @@FETCH_STATUS = 0
BEGIN

-- display each dataabase and recovery model setting not set to FULL
IF (SELECT DATABASEPROPERTYEX(@dbname,'RECOVERY')) <> 'FULL'

BEGIN
SELECT DATABASEPROPERTYEX(@dbname,'RECOVERY'), @dbname
END

-- fetch the next database name
FETCH NEXT FROM db_recovery_cursor INTO @dbname
END

-- close the cursor and deallocate memory used by cursor
CLOSE db_recovery_cursor
DEALLOCATE db_recovery_cursor

