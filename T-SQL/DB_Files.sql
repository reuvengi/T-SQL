--------------------------------------------------------------------------------------
--
-- Description: 
--
-- Revision history:
-- v1.0, 2012-04-26 Initial version			Christian Soelje (cso.it) CBS
--
--------------------------------------------------------------------------------------
exec sp_databases
exec sys.sp_db_vardecimal_storage_format


IF OBJECT_ID('DatabaseFiles') IS NULL
BEGIN
	SELECT TOP 0 * INTO DatabaseFiles
	FROM sys.database_files
END	

USE	<DatabaseName>
GO
EXECUTE sp_msforeachdb 'SELECT * FROM sys.database_files'