/*============================================================================
	File:		005 - A01 - Index usage in dedicated database.sql

	Summary:	This script analyzes the current situation in the plan cache
				of the connected SQL Server instance

	Optimization:	INCLUDE Pagecount

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
SET NOCOUNT ON
GO

DECLARE	@ServerStartTime DATETIME2(7);

SELECT	@ServerStartTime = MIN(last_startup_time) 
FROM	sys.dm_server_services;

SELECT	@ServerStartTime	AS	[ServerStartTime],
		QUOTENAME(S.name) + N'.' + QUOTENAME(T.name)	AS	Object_Name,
		I.index_id,
		P.partition_id,
		QUOTENAME(I.name)						AS	Index_name,
		DDIUS.user_seeks,
		DDIUS.user_scans,
		DDIUS.user_lookups,
		DDIUS.user_updates,
		P.rows,
		(
			DDIUS.user_seeks +
			DDIUS.user_scans +
			DDIUS.user_lookups -
			DDIUS.user_updates
		)										AS	Index_Performance
		,
		DDIUS.last_user_seek,
		DDIUS.last_user_scan,
		DDIUS.last_user_lookup,
		DDIUS.last_user_update
FROM	sys.schemas AS S INNER JOIN sys.tables AS T
		ON	(S.schema_id = T.schema_id) INNER JOIN sys.indexes AS I
		ON	(T.object_id = I.object_id) LEFT JOIN sys.dm_db_index_usage_stats AS DDIUS
		ON	(
				I.object_id = DDIUS.object_id AND
				I.index_id = DDIUS.index_id
			) INNER JOIN sys.partitions AS P
		ON	(
				I.index_id = P.index_id AND
				I.object_id = P.object_id
			)
WHERE	DDIUS.database_id = DB_ID()
		AND P.rows >= 10000
ORDER BY
		QUOTENAME(S.name) + QUOTENAME(T.name),
		I.index_id;
GO

-- unused indexes
;WITH unusedIndexes
AS
(
	SELECT	QUOTENAME(S.name) + N'.' + QUOTENAME(T.name)	AS	Object_Name,
			I.index_id,
			QUOTENAME(I.name)						AS	Index_name,
			ISNULL(DDIUS.user_seeks, 0)				AS	user_seeks,
			ISNULL(DDIUS.user_scans, 0)				AS	user_scans,
			ISNULL(DDIUS.user_lookups, 0)			AS	user_lookups,
			ISNULL(DDIUS.user_updates, 0)			AS	user_updates,
			(
				ISNULL(DDIUS.user_seeks, 0) +
				ISNULL(DDIUS.user_scans, 0) +
				ISNULL(DDIUS.user_lookups, 0) -
				ISNULL(DDIUS.user_updates, 0)
			)										AS	Index_Performance
			,
			DDIUS.last_user_seek,
			DDIUS.last_user_scan,
			DDIUS.last_user_lookup,
			DDIUS.last_user_update
	FROM	sys.schemas AS S INNER JOIN sys.tables AS T
			ON	(S.schema_id = T.schema_id) INNER JOIN sys.indexes AS I
			ON	(T.object_id = I.object_id) LEFT JOIN sys.dm_db_index_usage_stats AS DDIUS
			ON	(
					I.object_id = DDIUS.object_id AND
					I.index_id = DDIUS.index_id
				)
)
SELECT * FROM unusedIndexes
WHERE	user_seeks +
		user_scans +
		user_lookups = 0
		AND index_id > 1;
