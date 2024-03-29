declare @Time_Start datetime;
declare @Time_End datetime;
set @Time_Start=getdate()-2;
set @Time_End=getdate();
-- Create the temporary table
CREATE TABLE #ErrorLog (logdate datetime
                      , processinfo varchar(255)
                      , Message varchar(500))
-- Populate the temporary table
INSERT #ErrorLog (logdate, processinfo, Message)
   EXEC master.dbo.xp_readerrorlog 0, 1, null, null , @Time_Start, @Time_End, N'desc';
-- Filter the temporary table
SELECT LogDate, Message FROM #ErrorLog
WHERE (Message LIKE '%error%' OR Message LIKE '%failed%') AND processinfo NOT LIKE 'logon'
ORDER BY logdate DESC
-- Drop the temporary table 
DROP TABLE #ErrorLog
