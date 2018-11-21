--mdb 2013/06/01  Replication Monitor Part 3 - checking for delayed subscribers--      This script specifically looks for subscribers that haven't had changes applied recently
--        I believe this uses the same code that replication itself does for the "72 hour" inactivation
--2013/06/17 1.10 mdb thebakingdba.blogspot.com
--            added filter for "last_distsync is null", which should only be running or never-run.
--2013/08/08 2.00 mdb Version 2 - now works on SQL Server 2012 (via RESULT SETS).  2012 has a bug with sp_describe_first_result_set (please vote!)
--http://connect.microsoft.com/SQLServer/feedback/details/737341/sql-server-2012-openrowset-on-msdb-dbo-sp-help-job-throws-error

DECLARE @min INT, @max INT, @sql NVARCHAR(4000)
DECLARE @repl_server_list TABLE(id INT IDENTITY, srvname sysname)

SET NOCOUNT ON

--build a stripped down temp table; the OPENROWSET allows us to skip fields we don't care about.
IF OBJECT_ID('tempdb..#tmp_subscriptiondata') IS NOT NULL
    DROP TABLE #tmp_subscriptiondata
   
create table #tmp_subscriptiondata (
[status] int null,
warning int null ,
subscriber sysname null ,
subscriber_db sysname null ,
publisher_db sysname null ,
publication sysname null ,
publication_type int null ,
subtype int null ,
latency int null ,
latencythreshold int null ,
agentnotrunning int null ,
agentnotrunningthreshold  int null ,
timetoexpiration  int null ,
expirationthreshold  int null ,
last_distsync  datetime null ,
distribution_agentname  sysname null ,
mergeagentname  sysname null ,
mergesubscriptionfriendlyname  sysname null ,
mergeagentlocation  sysname null ,
mergeconnectiontype  int null ,
mergePerformance  int null ,
mergerunspeed float null ,
mergerunduration int null ,
monitorranking  int null ,
distributionagentjobid  binary(30) null ,
mergeagentjobid binary(30) null ,
distributionagentid  int null ,
distributionagentprofileid int null ,
mergeagentid int null ,
mergeagentprofileid int null ,
logreaderagentname sysname NULL,
publisher sysname
)


--list every server that our current server is handling distribution duties for. 
--    we do this since you can tell a different server to be the distributor.
INSERT INTO @repl_server_list
SELECT DISTINCT srvname --b.srvname,a.publisher_db,a.publication
FROM distribution.dbo.MSpublications a,  master.dbo.sysservers b
WHERE a.publisher_id=b.srvid

--------------------------------
--Get list of all replications--
--------------------------------
SELECT @min = MIN(id), @max = MAX(id) FROM @repl_server_list
WHILE @min <= @max
BEGIN
    --Transactional Replication
    select @sql = 'SELECT * FROM OPENROWSET(''SQLNCLI'', ''Server=' + @@servername + ';Trusted_Connection=yes'','
    + '  ''set fmtonly off;  exec distribution..sp_replmonitorhelpsubscription @Publisher="' + srvname + '",@publication_type=0
with RESULT SETS
(
    (
    status    int,
    warning    int,
    subscriber    sysname,
    subscriber_db    sysname,
    publisher_db    sysname,
    publication    sysname,
    publication_type    int,
    subtype    int,
    latency    int,
    latencythreshold    int,
    agentnotrunning    int,
    agentnotrunningthreshold    int,
    timetoexpiration    int,
    expirationthreshold    int,
    last_distsync    datetime,
    distribution_agentname    sysname,
    mergeagentname    sysname,
    mergesubscriptionfriendlyname    sysname,
    mergeagentlocation    sysname,
    mergeconnectiontype    int,
    mergePerformance    int,
    mergerunspeed    float,
    mergerunduration    int,
    monitorranking    int,
    distributionagentjobid    binary(16),
    mergeagentjobid    binary(16),
    distributionagentid    int,
    distributionagentprofileid    int,
    mergeagentid    int,
    mergeagentprofileid    int,
    logreaderagentname    sysname,
    publisher    sysname
    )
)    '')a'
        FROM @repl_server_list WHERE id = @min
   
    Insert Into #tmp_subscriptiondata
        EXEC sp_executesql @sql

    --Snapshot Replication
    select @sql = 'SELECT * FROM OPENROWSET(''SQLNCLI'', ''Server=' + @@servername + ';Trusted_Connection=yes'','
    + '  ''set fmtonly off;  exec distribution..sp_replmonitorhelpsubscription @Publisher="' + srvname + '",@publication_type=1
with RESULT SETS
(
    (
    status    int,
    warning    int,
    subscriber    sysname,
    subscriber_db    sysname,
    publisher_db    sysname,
    publication    sysname,
    publication_type    int,
    subtype    int,
    latency    int,
    latencythreshold    int,
    agentnotrunning    int,
    agentnotrunningthreshold    int,
    timetoexpiration    int,
    expirationthreshold    int,
    last_distsync    datetime,
    distribution_agentname    sysname,
    mergeagentname    sysname,
    mergesubscriptionfriendlyname    sysname,
    mergeagentlocation    sysname,
    mergeconnectiontype    int,
    mergePerformance    int,
    mergerunspeed    float,
    mergerunduration    int,
    monitorranking    int,
    distributionagentjobid    binary(16),
    mergeagentjobid    binary(16),
    distributionagentid    int,
    distributionagentprofileid    int,
    mergeagentid    int,
    mergeagentprofileid    int,
    logreaderagentname    sysname,
    publisher    sysname
    )
)    '')a'
        FROM @repl_server_list WHERE id = @min
   
    Insert Into #tmp_subscriptiondata
        EXEC sp_executesql @sql

    --Merge Replication
    select @sql = 'SELECT * FROM OPENROWSET(''SQLNCLI'', ''Server=' + @@servername + ';Trusted_Connection=yes'','
    + '  ''set fmtonly off;  exec distribution..sp_replmonitorhelpsubscription @Publisher="' + srvname + '",@publication_type=2
with RESULT SETS
(
    (
    status    int,
    warning    int,
    subscriber    sysname,
    subscriber_db    sysname,
    publisher_db    sysname,
    publication    sysname,
    publication_type    int,
    subtype    int,
    latency    int,
    latencythreshold    int,
    agentnotrunning    int,
    agentnotrunningthreshold    int,
    timetoexpiration    int,
    expirationthreshold    int,
    last_distsync    datetime,
    distribution_agentname    sysname,
    mergeagentname    sysname,
    mergesubscriptionfriendlyname    sysname,
    mergeagentlocation    sysname,
    mergeconnectiontype    int,
    mergePerformance    int,
    mergerunspeed    float,
    mergerunduration    int,
    monitorranking    int,
    distributionagentjobid    binary(16),
    mergeagentjobid    binary(16),
    distributionagentid    int,
    distributionagentprofileid    int,
    mergeagentid    int,
    mergeagentprofileid    int,
    logreaderagentname    sysname,
    publisher    sysname
    )
)    '')a' 
        FROM @repl_server_list WHERE id = @min
   
    Insert Into #tmp_subscriptiondata
        EXEC sp_executesql @sql
    SET @min = @min + 1
END

SELECT * FROM #tmp_subscriptiondata
-------------------
--Reporting Email--
-------------------
--variables and tablevar defined here to more easily add/modify/test rules
DECLARE @tableHTML NVARCHAR(MAX)
   ,@MailSubject VARCHAR(100)
, @rowcount INT
DECLARE @final_error_list TABLE (
    subscriber sysname null ,
    subscriber_db sysname null ,
    publisher_db sysname null ,
    publication sysname null ,
    warning int null ,
    last_distsync  datetime null ,
    hours_delayed INT,
    distribution_agentname  sysname null
    )

SELECT  @MailSubject = '[Replication] Delays/Errors on ' + @@servername

--using an interim table so that we can query it to see how many they are;
--    we could use a CTE but then we have no easy way, short of checking the HTML length,
--    of verifying there are records that need to be emailed. 

INSERT INTO @final_error_list
    SELECT subscriber, subscriber_db, publisher_db, publication, warning, last_distsync,
                DATEDIFF(hh,last_distsync, GETDATE()) AS Hours_Delayed,distribution_agentname 
        FROM #tmp_subscriptiondata WHERE warning > 0
    UNION ALL
    SELECT subscriber, subscriber_db, publisher_db, publication, warning, last_distsync,
                DATEDIFF(hh,last_distsync, GETDATE()) AS Hours_Delayed, distribution_agentname
        FROM #tmp_subscriptiondata

    --rule 1 - ignore publications that are current in the last hour or are currently running.
    DELETE FROM @final_error_list
        WHERE last_distsync > DATEADD(mi,-60, GETDATE()) OR last_distsync IS null

    --rule 2 - ignore subscriptions that only run once a day, after midnight
    --DELETE FROM @final_error_list
    --    WHERE (publication = 'yourdailypubname' AND last_distsync > CONVERT(CHAR(8),GETDATE(),112))

IF (SELECT COUNT(*) FROM @final_error_list)>0
BEGIN
    select @tableHTML = N'<H3>Replication Delays and Errors</H3>'
        + N'<table border="1">' + N'<tr>'
        + N'<th>Subscriber</th>' +
        + N'<th>  Subscriber_DB  </th>'
        + N'<th>  Publisher_DB  </th>'
        + N'<th> Publication </th>'
        + N'<th>Warning</th>'
        + N'<th> Last_Distsync </th>'
        + N'<th> Hours</th>'
        + N'<th> Distribution_AgentName</th>'
        + N'</tr>' + CAST((SELECT td = RTRIM(LTRIM(T.Subscriber))
                                ,''
                                ,td = RTRIM(LTRIM(T.Subscriber_DB))
                                ,''
                                ,td = RTRIM(LTRIM(T.Publisher_DB))
                                ,''
                                ,td = RTRIM(LTRIM(T.Publication))
                                ,''
                                ,td = RTRIM(LTRIM(T.Warning))
                                ,''
                                ,td = CONVERT(VARCHAR(16), T.Last_Distsync, 120)
                                ,''
                                ,td = CONVERT(VARCHAR(3), T.Hours_Delayed)
                                ,''
                                ,td = RTRIM(LTRIM(T.Distribution_AgentName))
                            FROM   @final_error_list T
                            ORDER BY T.[Warning] DESC, T.last_distsync ASC
                        FOR
                            XML PATH('tr')
                            ,TYPE
                        ) AS NVARCHAR(MAX)) + N'</table>';
   
        --PRINT @tableHTML      
            
    EXEC msdb.dbo.sp_send_dbmail @profile_name = 'BBR Replication', @recipients = 'eaf@netcompany.com',
        @subject = @MailSubject, @body = @tableHTML, @body_format = 'HTML';

--_Generate custom error to notify the user about this delay
            DECLARE @ErrorMessage NVARCHAR(1000)= '[Replication] Delays/Errors on ' + @@servername
            RAISERROR('Error Number-%d : Error Message-%s', 16, 1, 85000, @ErrorMessage);
            EXEC sys.xp_logevent 85000, @ErrorMessage, 'ERROR';

END

DROP TABLE #tmp_subscriptiondata