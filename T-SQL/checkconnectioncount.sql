--------------------------------------------------------------------------------------
--
-- Description: 
--
-- Revision history:
-- v1.0, 2016-09-23 Initial version			Christian Soelje (cso.it) CBS
--
--------------------------------------------------------------------------------------
create table ConnectionCount (
	[spid] bigint NOT NULL,
	[blocked] int NOT NULL,
	[dbname] varchar(250) NOT NULL,
	[open_tran] int NOT NULL,
	[status] varchar(250) NOT NULL,
	[hostname] varchar(250) NOT NULL,
	[cmd] varchar(250) NOT NULL,
	[login_time] varchar(250) NOT NULL,
	[loginame] varchar(250) NOT NULL,
	[net_library] varchar(250) NOT NULL )

insert into ConnectionCount
  select spid,blocked,d.name,open_tran,status,hostname,cmd,login_time,loginame,net_library
  from sys.sysprocesses p
  inner join sys.databases d on p.dbid=d.database_id
  where status not like 'background%'


declare @connectioncnt float  
select @connectioncnt=COUNT(1) from ConnectionCount    
if (@connectioncnt > 500)
begin

	declare @strsubject varchar(100)
	select @strsubject='Check user connection count on ' + @@SERVERNAME

	declare @tableHTML  nvarchar(max);
	set @tableHTML =
		N'<H1>Connection information - ' + @@SERVERNAME +'</H1>' +
		N'<table border="1">' +
		N'<tr><th>SPID</th><th>Blocked</th>' +
		N'<th>DBName</th><th>Open_Tran</th>' +		
		N'<th>Status</th><th>Hostname</th>' +
		N'<th>cmd</th><th>Login_Time</th>' +				
		N'<th>Login_Name</th><th>Net_Library</th></tr>' +
		CAST ( ( SELECT td = [spid], '',
	                    td = [blocked], '',
	                    td = [dbname], '',
	                    td = [open_tran], '',
	                    td = [status], '',
	                    td = [hostname], '',
	                    td = [cmd], '',
	                    td = [login_time], '',
	                    td = [loginame], '',
	                    td = [net_library]
				  FROM ConnectionCount
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

drop table ConnectionCount