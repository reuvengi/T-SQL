--------------------------------------------------------------------------------------------
--
-- Description:
--	Getting all the databases LOG files path
-- Revision history:
-- v1.0, 2018-10-23 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
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
	SET @sql = 'USE  ' + @name + ' ; SELECT name, physical_name, type_desc, state_desc FROM sys.database_files WHERE type_desc = ''LOG'' '
	EXECUTE sp_executesql @sql

	SET @begin = @begin + 1

END