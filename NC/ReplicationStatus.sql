DECLARE @Srvname VARCHAR(100)
DECLARE @Pub_db VARCHAR(100)
DECLARE @Pubname VARCHAR(100)

CREATE TABLE #REPLMONITOR
 (
 Status INT NULL,
 Warning INT NULL,
 Subscriber SYSNAME NULL,
 Subscriber_db SYSNAME NULL,
 Publisher_db SYSNAME NULL,
 Publication SYSNAME NULL,
 Publication_type INT NULL,
 Subtype INT NULL,
 Latency INT NULL,
 Latencythreshold INT NULL,
 Agentnotrunning INT NULL,
 Agentnotrunningthreshold INT NULL,
 Timetoexpiration INT NULL,
 Expirationthreshold INT NULL,
 Last_distsync DATETIME,
 Distribution_agentname SYSNAME NULL,
 Mergeagentname SYSNAME NULL,
 Mergesubscriptionfriendlyname SYSNAME NULL,
 Mergeagentlocation SYSNAME NULL,
 Mergeconnectiontype INT NULL,
 Mergeperformance INT NULL,
 Mergerunspeed FLOAT,
 Mergerunduration INT NULL,
 Monitorranking INT NULL,
 Distributionagentjobid BINARY(16),
 Mergeagentjobid BINARY(16),
 Distributionagentid INT NULL,
 Distributionagentprofileid INT NULL,
 Mergeagentid INT NULL,
 Mergeagentprofileid INT NULL,
 Logreaderagentname VARCHAR(100),
 Publisher VARCHAR(20)
 )


INSERT INTO #REPLMONITOR
SELECT A.*
FROM OPENROWSET('MSDASQL',
 'DRIVER={SQL Server}; SERVER=KOMB-BBRP-SCL01; UID=sa; PWD=vXbAzsFx!Jpa/qzhap',
 'SET FMTONLY OFF EXEC DISTRIBUTION.DBO.SP_REPLMONITORHELPSUBSCRIPTION @Publication_type = 0') AS A;

SELECT CASE Status
 WHEN 1 THEN 'Started'
 WHEN 2 THEN 'Succeeded'
 WHEN 3 THEN 'In Progress'
 WHEN 4 THEN 'Idle'
 WHEN 5 THEN 'Retrying'
 WHEN 6 THEN 'Failed'
 END AS Status,
 Publication,
 Publisher_db ,
 Subscriber_db,
 CONVERT(VARCHAR(8), STUFF(STUFF(RIGHT('000000' + CONVERT(VARCHAR, Latency
 ), 6),
 5, 0, ':'), 3, 0,
 ':'), 108) AS Latency,
 CASE Monitorranking
 WHEN 60 THEN 'Error'
 WHEN 56 THEN 'Warning: performance critical'
 WHEN 52 THEN 'Warning: expiring soon or expired'
 WHEN 50 THEN 'Warning: subscription uninitialized'
 WHEN 40 THEN 'Retrying failed command'
 WHEN 30 THEN 'Not running (success)'
 WHEN 20 THEN 'Running (starting, running, or idle)'
 END AS Healthcheck
FROM #REPLMONITOR

DECLARE @RunStatus NVARCHAR(100)
DECLARE @Publication NVARCHAR(100)
DECLARE @SubscriberDB NVARCHAR(100)

SELECT @Publication = Publication FROM #REPLMONITOR
SELECT @SubscriberDB = Subscriber_db FROM #REPLMONITOR

SELECT @RunStatus = CASE Status
 WHEN 1 THEN 'Started'
 WHEN 2 THEN 'Succeeded'
 WHEN 3 THEN 'In Progress'
 WHEN 4 THEN 'Idle'
 WHEN 5 THEN 'Retrying'
 WHEN 6 THEN 'Failed'
 END 
FROM #REPLMONITOR

PRINT @Publication
PRINT @SubscriberDB
PRINT @RunStatus

IF (@RunStatus ='Idle')
Begin
--_Generate custom error to notify the user about this delay
            DECLARE @ErrorMessage NVARCHAR(1000)= '[Replication] Delays/Errors on ' + @@servername + ' Publication:' + @Publication + ' Subscriber DB:' +@SubscriberDB + ' The Replication is in Idle state.'
            RAISERROR('Error Number-%d : Error Message-%s', 16, 1, 85000, @ErrorMessage);
            EXEC sys.xp_logevent 85000, @ErrorMessage, 'Warning';
End

IF (@RunStatus ='Failed')
Begin
--_Generate custom error to notify the user about this delay
            DECLARE @ErrorMessageFailed NVARCHAR(1000)= '[Replication] Delays/Errors on ' + @@servername + ' Publication:' + @Publication + ' Subscriber DB:' +@SubscriberDB + ' The Replication is in Failed state.'
            RAISERROR('Error Number-%d : Error Message-%s', 16, 1, 75000, @ErrorMessageFailed);
            EXEC sys.xp_logevent 85001, @ErrorMessageFailed, 'Error';
End

IF (@RunStatus ='In Progress')
Begin
--_Generate Message
            DECLARE @Message NVARCHAR(1000)= '[Replication] on ' + @@servername + ' Publication:' + @Publication + ' Subscriber DB:' +@SubscriberDB + ' The Replication is running (starting, running, or idle).'
            EXEC sys.xp_logevent 85002, @Message, 'Informational';
End

IF (@RunStatus ='Succeeded')
Begin
--_Generate custom error to notify the user about this delay
            DECLARE @MessageSucceeded NVARCHAR(1000)= '[Replication] Delays on ' + @@servername + ' Publication:' + @Publication + ' Subscriber DB:' +@SubscriberDB + ' The Replication is in Succeeded state. The Log Reader Agent maybe is paused.'
            EXEC sys.xp_logevent 85003, @MessageSucceeded, 'Warning';
End



DROP TABLE #REPLMONITOR