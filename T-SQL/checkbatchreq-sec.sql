declare @inibrps bigint
declare @brps decimal(38,2)

select @inibrps=cntr_value 
from sys.dm_os_performance_counters
where counter_name LIKE 'Batch Requests/sec%'

waitfor delay '000:00:10'

select @brps=(cntr_value-@inibrps)/10.0
from sys.dm_os_performance_counters
where counter_name like 'Batch Requests/sec%'

if (@brps > 1000)
begin

	declare @strsubject varchar(100)
	select @strsubject='Check batch requests/sec on ' + @@SERVERNAME

	declare @tableHTML  nvarchar(max);
	set @tableHTML =
		N'<H1>Batch Request rate - ' + @@SERVERNAME +'</H1>' +
		N'<table border="1">' +
		N'<tr><th>Batch Reqests/sec</th></tr>' +
		CAST ( ( SELECT td = @brps
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
