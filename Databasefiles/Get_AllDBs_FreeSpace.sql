--------------------------------------------------------------------------------------------
--
-- Description:
--  Getting all the databases free space
-- Revision history:
-- v1.0, 2019-02-11 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
DECLARE @begin INT = 1, @end INT, @name VARCHAR(250), @sql NVARCHAR(MAX)
SELECT @end = COUNT(name) FROM sys.databases WHERE database_id > 4

WHILE @begin <= @end
BEGIN

	;WITH DatabaseName AS(
		SELECT ROW_NUMBER() OVER (ORDER BY name) as ID
			, name
			FROM sys.databases WHERE database_id > 4
	)
	SELECT @name = name FROM DatabaseName WHERE ID = @begin
	--SELECT @name
	SET @sql = 'USE  [' + @name + '] ; SELECT DB_NAME() AS [DatabaseName], name, physical_name, ((size * 8.0/1024)/1024) as [Size in GB],
    ((size * 8.0/1024)/1024) - ((SUM(FILEPROPERTY(name, ''SpaceUsed'')) * 8.0/1024)/1024) As [FreeSpace in GB], type_desc, state_desc FROM sys.database_files'
	EXECUTE sp_executesql @sql

	SET @begin = @begin + 1

END