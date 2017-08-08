/*============================================================================
	File:		005 - A02 - Index physical stats in dedicated database.sql

	Summary:	This script analyzes the current situation in the plan cache
				of the connected SQL Server instance

	Date:		May 2014

	SQL Server Version: 2008 / 2012
------------------------------------------------------------------------------
	Written by Uwe Ricken, db Berater GmbH

	This script is intended only as a supplement to demos and lectures
	given by Uwe Ricken.  
  
	THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
	ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
	TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
	PARTICULAR PURPOSE.
============================================================================*/
IF CAST(SERVERPROPERTY('ProductVersion') AS CHAR(2)) <= '10'
EXEC	sp_executesql N'
SELECT	QUOTENAME(S.name) + ''.'' + QUOTENAME(T.name)	AS	Object_Name,
		QUOTENAME(I.name)								AS	Index_name,
		DDIPS.index_level,
		DDIPS.avg_fragmentation_in_percent,
		DDIPS.fragment_count,
		DDIPS.avg_fragment_size_in_pages,
		DDIPS.avg_page_space_used_in_percent,
		DDIPS.page_count,
		DDIPS.record_count,
		-- DDIPS.forwarded_records,
		DDIPS.version_ghost_record_count
FROM	sys.schemas AS S INNER JOIN sys.tables AS T
		ON	(S.schema_id = T.schema_Id) INNER JOIN sys.indexes AS I
		ON	(T.object_id = I.object_Id)
		INNER JOIN sys.dm_db_index_physical_stats
		(
			DB_ID(),
			NULL,
			NULL,
			NULL,
			''DETAILED''
		) AS DDIPS
		ON (
			I.object_id = DDIPS.object_id AND
			I.index_id = DDIPS.index_id
		   )
ORDER BY
		S.name,
		T.name,
		I.index_id,
		DDIPS.index_level;'
ELSE
EXEC	sp_executesql N'
SELECT	QUOTENAME(S.name) + ''.'' + QUOTENAME(T.name)	AS	Object_Name,
		QUOTENAME(I.name)								AS	Index_name,
		DDIPS.index_level,
		DDIPS.avg_fragmentation_in_percent,
		DDIPS.fragment_count,
		DDIPS.avg_fragment_size_in_pages,
		DDIPS.avg_page_space_used_in_percent,
		DDIPS.page_count,
		DDIPS.record_count,
		DDIPS.forwarded_record_count,
		DDIPS.version_ghost_record_count
FROM	sys.schemas AS S INNER JOIN sys.tables AS T
		ON	(S.schema_id = T.schema_Id) INNER JOIN sys.indexes AS I
		ON	(T.object_id = I.object_Id)
		CROSS APPLY sys.dm_db_index_physical_stats
		(
			DB_ID(),
			I.object_Id,
			I.index_id,
			NULL,
			''DETAILED''
		) AS DDIPS
ORDER BY
		S.name,
		T.name,
		I.index_id,
		DDIPS.index_level;'