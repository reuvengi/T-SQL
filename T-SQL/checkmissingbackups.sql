--------------------------------------------------------------------------------------
--
-- Description: 
--
-- Revision history:
-- v1.0, 2016-09-23 Initial version			Christian Soelje (cso.it) CBS
--
--------------------------------------------------------------------------------------
create table Missing_Backups (
	[DB Name] [varchar](100) NOT NULL,
	[Type] [varchar] (5) NOT NULL,
	[Last Backup] [varchar](100) NULL)

insert into Missing_Backups 
SELECT d.name AS "Database",'Full' as "Type",
       ISNULL(CONVERT(VARCHAR,b.backupdate,120),'NEVER') AS "Last Full Backup"
FROM sys.databases d
LEFT JOIN (SELECT database_name,type,MAX(backup_finish_date) backupdate FROM backupset
           WHERE type LIKE 'D'
           GROUP BY database_name,type) b on d.name=b.database_name
WHERE (backupdate IS NULL OR backupdate < getdate()-1) 
  AND d.name <> 'tempdb'
UNION
SELECT d.name AS "Database",'Trn' as "Type",
       ISNULL(CONVERT(VARCHAR,b.backupdate,120),'NEVER') AS "Last Log Backup"
FROM sys.databases d
LEFT JOIN (SELECT database_name,type,MAX(backup_finish_date) backupdate FROM backupset
           WHERE type LIKE 'L'
           GROUP BY database_name,type) b on d.name=b.database_name
WHERE recovery_model = 1
  AND (backupdate IS NULL OR backupdate < getdate()-1)
  AND d.name <> 'tempdb'
  
declare @cnt int  
select @cnt=COUNT(1) from Missing_Backups    
if (@cnt > 0)
begin

	declare @strsubject varchar(100)
	select @strsubject='Check for missing backups on ' + @@SERVERNAME

	declare @tableHTML  nvarchar(max);
	set @tableHTML =
		N'<H1>Databases Missing Backups Listing - ' + @@SERVERNAME +'</H1>' +
		N'<table border="1">' +
		N'<tr><th>DB Name</th><th>Type</th>' +
		N'<th>Last Backup</th></tr>' +
		CAST ( ( SELECT td = [DB Name], '',
	                    td = [Type], '',
	                    td = [Last Backup]
				  FROM Missing_Backups
				  FOR XML PATH('tr'), TYPE 
		) AS NVARCHAR(MAX) ) +
		N'</table>' ;

	EXEC msdb.dbo.sp_send_dbmail
	@from_address='test@test.com',
	@recipients='test@test.com',
	@subject = @strsubject,
	@body = @tableHTML,
	@body_format = 'HTML' ,
	@profile_name='test profile'
end

drop table Missing_Backups