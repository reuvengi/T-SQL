USE MASTER
GO
SET NOCOUNT ON
GO
SELECT 'SQL server started at ' + 
CAST((CONVERT(DATETIME, sqlserver_start_time, 126)) AS VARCHAR(20))
+' and is up and running from '+
CAST((DATEDIFF(MINUTE,sqlserver_start_time,GETDATE()))/60 AS VARCHAR(5)) 
+ ' hours and ' +
RIGHT('0' + CAST(((DATEDIFF(MINUTE,sqlserver_start_time,GETDATE()))%60) AS VARCHAR(2)),2) 
+ ' minutes' AS [Start_Time_Up_Time] FROM sys.dm_os_sys_info
GO
SET NOCOUNT OFF
GO 