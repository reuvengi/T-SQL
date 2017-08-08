/*============================================================================
	File:		004 - A01 - What tasks are CURRENTLY waiting.sql

	Summary:	Dieses Script zeigt Beispiele für die momentanen Verbindungen,
				die zum Server aufgebaut sind.

				PS: Für einen Test mit mehreren Sessions müssen folgende Bedingungen
					erfüllt sein:

				osstress ist auf dem Computer vorhanden
				http://support.microsoft.com/kb/944837/en-us

				Sowohl die Datenbank demo_db als auch die Prozedur für den Stresstest
				sind implementiert:

				0001 - create database and relations.sql
				0002 - Stored Procedure for execution with ostress.exe.sql

	Date:		Mai 2015
	Historie:	Januar 2016	- Anzeigen von Blocking Prozessen, die NICHT warten!

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
USE master;
GO

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO

SELECT	DES.host_name,
		DES.program_name,
		DES.login_name,
		DOWT.session_id,
		DOWT.wait_duration_ms,
		DOWT.wait_type,
		DOWT.blocking_session_id,
		DOWT.resource_description,
		SUBSTRING
		(
			DEST.text,
			DER.statement_start_offset / 2 - 1,
			CASE WHEN DER.statement_end_offset = -1
				 THEN DATALENGTH(DEST.text)
				 ELSE (DER.statement_end_offset - DER.statement_start_offset) / 2 + 1
			END
		)		AS	SQLCommand,
		DEST.text
FROM	sys.dm_exec_sessions AS DES
		LEFT JOIN sys.dm_os_waiting_tasks DOWT
		ON(DES.session_id = DOWT.session_id)
		INNER JOIN sys.dm_exec_requests AS DER
		ON (DOWT.session_id = DER.session_id)
		CROSS APPLY sys.dm_exec_sql_text(DER.sql_handle) AS DEST
WHERE	DOWT.session_id IN
(
	SELECT	DES.session_id
	FROM	sys.dm_exec_sessions AS DES
	WHERE	DES.is_user_process = 1
)

UNION ALL

SELECT	DES.host_name,
		DES.program_name,
		DES.login_name,
		DES.session_id,
		DER.wait_time,
		DER.wait_type,
		DER.blocking_session_id,
		DER.wait_resource,
		SUBSTRING
		(
			DEST.text,
			DER.statement_start_offset / 2,
			CASE WHEN DER.statement_end_offset = -1
				 THEN DATALENGTH(DEST.text)
				 ELSE (DER.statement_end_offset - DER.statement_start_offset) / 2
			END
		)		AS	SQLCommand,
		DEST.text
FROM	sys.dm_exec_sessions AS DES
		LEFT JOIN sys.dm_exec_requests AS DER
		ON (DES.session_id = DER.session_id)
		OUTER APPLY sys.dm_exec_sql_text(DER.sql_handle) AS DEST
WHERE	DER.session_id IN (SELECT blocking_session_id FROM sys.dm_os_waiting_tasks WHERE blocking_session_id IS NOT NULL)
--ORDER BY
--		DER.session_id;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
GO
