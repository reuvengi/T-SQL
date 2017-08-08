/*============================================================================
	File:		005 - A02 - Statistics in explicit database.sql

	Summary:	This script gives you an overview of all statistics
				in a dedicated database.

	Date:		June 2015
	Session:	Analysis of a Microsoft SQL Server

	SQL Server Version: 2012 / 2014 / 2016
------------------------------------------------------------------------------
	Written by Uwe Ricken, db Berater GmbH

	This script is intended only as a supplement to demos and lectures
	given by Uwe Ricken.  
  
	THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
	ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
	TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
	PARTICULAR PURPOSE.
============================================================================*/
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
GO

-- Information about the condition of the statistics
SELECT	QUOTENAME(S.name) + '.' + QUOTENAME(T.name)	AS	Object_Name,
		ST.*,
		DDSP.last_updated,
		DDSP.rows,
		DDSP.rows_sampled,
		DDSP.steps,
		DDSP.unfiltered_rows,
		DDSP.modification_counter
FROM	sys.schemas AS S INNER JOIN sys.tables AS T
		ON (S.schema_id = T.schema_id) INNER JOIN sys.stats AS ST
		ON (T.object_id = ST.Object_Id)
		OUTER APPLY sys.dm_db_stats_properties(ST.object_id, ST.stats_id) AS DDSP
WHERE	T.is_ms_shipped = 0
ORDER BY
		S.name,
		T.name,
		ST.stats_id
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO
