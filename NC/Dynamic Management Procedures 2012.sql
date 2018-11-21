USE master;
GO
 
CREATE PROCEDURE dbo.sp_ford_dm_log_metrics AS 
--=======================================================
--  FORDDMPs (Dynamic Management Procedures)
--	dbo.sp_ford_dm_log_metrics
--  Created by Tim Ford, SQL Server MVP
--  thesqlagentman.com, sqlcruise.com,
--	@sqlagentman on Twitter
--  Use permitted with full attribution to creator
-- Present Log File Properties Ordered by VLF Count DESC
--
-- ***  THIS VERSION VALID FOR 2012 SQL SERVER ONLY ***
--
--=======================================================
 
CREATE TABLE #DBCC_LogInfo
	(
		[RecoveryUnitId] INT,
		[FileID] INT,
		[FileSize] BIGINT,
		[StartOffset] BIGINT,
		[FSeqNo] BIGINT,
		[STATUS] BIGINT,
		[Parity] BIGINT,
		[CreateLSN] NUMERIC(38)
	);
 
CREATE TABLE #VLF_Counts
    (
		[database_name] sysname, 
		[file_id] INT,
		[vlf_count] INT
    );
 
CREATE TABLE #Log_Space
	(
		[physical_name] NVARCHAR(260), 
		[SpaceUsed_mb] BIGINT
	);
 
CREATE TABLE #Log_Backup_History
	(
		[physical_name] NVARCHAR(260), 
		[days_in_history] INT, 
		[max_backup_size_mb] BIGINT
	);
 
INSERT INTO #Log_Backup_History 
	(
	[physical_name]
	, [days_in_history]
	, [max_backup_size_mb]
	)
SELECT MF.[physical_name]
	, DATEDIFF(d, MIN(BS.[backup_finish_date]), GETDATE()) AS [days_metadata]
	, MAX(CEILING(BF.[backup_size]/1024/1024)) AS [max_backup_file_size_mb]
FROM sys.DATABASES D INNER JOIN sys.master_files MF ON D.database_id = MF.database_id
	LEFT JOIN msdb.dbo.[backupset] BS ON D.[name] = BS.[database_name]
	LEFT JOIN msdb.dbo.[backupfile] BF ON [BF].[backup_set_id] = [BS].[backup_set_id]
WHERE BS.[TYPE] = 'L'
	AND MF.[type_desc] = 'LOG'
	AND D.[recovery_model_desc] != 'SIMPLE'
GROUP BY MF.[physical_name];
 
EXEC sp_MSforeachdb 
	N'USE [?]; 
    INSERT INTO #DBCC_LogInfo 
		([RecoveryUnitId]
		, [FileID]
		, [FileSize]
		, [StartOffset]
		, [FSeqNo]
		, [Status]
		, [Parity]
		, [CreateLSN]
		) 
    EXECUTE sp_executesql N''DBCC LogInfo([?])''; 
 
    INSERT INTO #VLF_Counts 
    SELECT DB_Name(), [FileID], COUNT([FileID]) 
    FROM #DBCC_LogInfo
	GROUP BY [FileID]; 
 
    TRUNCATE TABLE #DBCC_LogInfo;
 
	INSERT INTO #Log_Space ([physical_name], [SpaceUsed_mb])  
    SELECT [physical_name], CAST(FILEPROPERTY([name], ''SpaceUsed'') as int) * 8/1024 AS [SpaceUsed_mb] 
	FROM sys.database_files
	WHERE type_desc = ''LOG'';'
 
SELECT V.database_name
	, MF.[name] AS [logical_file_name]
	, MF.[physical_name] AS [physical_file_name]
	, V.[vlf_count]
	, D.[recovery_model_desc] AS [recovery_model]
	, L.[SpaceUsed_mb] AS [log_used_mb]
	, MF.[SIZE]*8/1024 AS [log_size_mb]
	, LH.[max_backup_size_mb]
	, CASE D.[recovery_model_desc]
		WHEN 'SIMPLE' THEN NULL
		ELSE (MF.SIZE*8/1024) - ISNULL(LH.[max_backup_size_mb], 0) 
	END AS [file_excess_mb]
	, MF.[is_percent_growth] AS [is_pct_growth]
	, CASE MF.[is_percent_growth]
		WHEN 1 THEN CAST(MF.[growth] AS VARCHAR(3)) + '%'
		WHEN 0 THEN CAST(MF.[growth]*8/1024 AS VARCHAR(15)) + 'mb'
	END AS [growth_units]
	, LH.[days_in_history] AS [backup_days_in_sample]
FROM #VLF_Counts V
	INNER JOIN sys.DATABASES D ON V.[database_name] = D.[name]
	INNER JOIN sys.master_files MF 
		ON D.[database_id] = MF.[database_id] 
			AND V.[file_id] = MF.[file_id]
	INNER JOIN #Log_Space L 
		ON MF.[physical_name] = L.[physical_name]
	LEFT JOIN #Log_Backup_History LH ON MF.physical_name = LH.physical_name
WHERE MF.[type_desc] = 'LOG'
ORDER BY V.[vlf_count] DESC;
 
--==============================================
-- Cleanup
--==============================================
IF EXISTS (SELECT [name] FROM tempdb.sys.[TABLES] WHERE [name] LIKE '#DBCC_LogInfo') 
	DROP TABLE #DBCC_LogInfo;
 
IF EXISTS (SELECT [name] FROM tempdb.sys.[TABLES] WHERE [name] LIKE '#VLF_Counts%') 
	DROP TABLE #VLF_Counts;
 
IF EXISTS (SELECT [name] FROM tempdb.sys.[TABLES] WHERE [name] LIKE '#Log_Space%') 
	DROP TABLE #Log_Space;
 
IF EXISTS (SELECT [name] FROM tempdb.sys.[TABLES] WHERE [name] LIKE '#Log_Backup_History%') 
	DROP TABLE #Log_Backup_History;
GO