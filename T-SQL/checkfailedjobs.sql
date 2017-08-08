--------------------------------------------------------------------------------------
--
-- Description: 
--
-- Revision history:
-- v1.0, 2016-09-23 Initial version			Christian Soelje (cso.it) CBS
--
--------------------------------------------------------------------------------------
create table Failed_Jobs (
	[Status] [varchar](6) NOT NULL,
	[Job Name] [varchar](100) NULL,
	[Step ID] [varchar](5) NULL,
	[Step Name] [varchar](30) NULL,
	[Start Date Time] [varchar](30) NULL,
	[Message] [nvarchar](4000) NULL)

insert into Failed_Jobs
select 'FAILED' as Status, cast(sj.name as varchar(100)) as "Job Name",
       cast(sjs.step_id as varchar(5)) as "Step ID",
       cast(sjs.step_name as varchar(30)) as "Step Name",
       cast(REPLACE(CONVERT(varchar,convert(datetime,convert(varchar,sjh.run_date)),102),'.','-')+' '+SUBSTRING(RIGHT('000000'+CONVERT(varchar,sjh.run_time),6),1,2)+':'+SUBSTRING(RIGHT('000000'+CONVERT(varchar,sjh.run_time),6),3,2)+':'+SUBSTRING(RIGHT('000000'+CONVERT(varchar,sjh.run_time),6),5,2) as varchar(30)) 'Start Date Time',
       sjh.message as "Message"
from sysjobs sj
join sysjobsteps sjs 
 on sj.job_id = sjs.job_id
join sysjobhistory sjh 
 on sj.job_id = sjh.job_id and sjs.step_id = sjh.step_id
where sjh.run_status <> 1
  and cast(sjh.run_date as float)*1000000+sjh.run_time > 
      cast(convert(varchar(8), getdate()-1, 112) as float)*1000000+70000 --yesterday at 7am
union
select 'FAILED',cast(sj.name as varchar(100)) as "Job Name",
       'MAIN' as "Step ID",
       'MAIN' as "Step Name",
       cast(REPLACE(CONVERT(varchar,convert(datetime,convert(varchar,sjh.run_date)),102),'.','-')+' '+SUBSTRING(RIGHT('000000'+CONVERT(varchar,sjh.run_time),6),1,2)+':'+SUBSTRING(RIGHT('000000'+CONVERT(varchar,sjh.run_time),6),3,2)+':'+SUBSTRING(RIGHT('000000'+CONVERT(varchar,sjh.run_time),6),5,2) as varchar(30)) 'Start Date Time',
       sjh.message as "Message"
from sysjobs sj
join sysjobhistory sjh 
 on sj.job_id = sjh.job_id
where sjh.run_status <> 1 and sjh.step_id=0
  and cast(sjh.run_date as float)*1000000+sjh.run_time >
      cast(convert(varchar(8), getdate()-1, 112) as float)*1000000+70000 --yesterday at

declare @cnt int  
select @cnt=COUNT(1) from Failed_Jobs    
if (@cnt > 0)
begin

	declare @strsubject varchar(100)
	select @strsubject='Check the following failed jobs on ' + @@SERVERNAME

	declare @tableHTML  nvarchar(max);
	set @tableHTML =
		N'<H1>Failed Jobs Listing - ' + @@SERVERNAME +'</H1>' +
		N'<table border="1">' +
		N'<tr><th>Status</th><th>Job Name</th>' +
		N'<th>Step ID</th><th>Step Name</th><th>Start Date</th>' +
		N'<th>Message</th></tr>' +
		CAST ( ( SELECT td = [Status], '',
	                    td = [Job Name], '',
	                    td = [Step ID], '',
	                    td = [Step Name], '',
	                    td = [Start Date Time], '',
	                    td = [Message]
				  FROM Failed_Jobs
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

drop table Failed_Jobs