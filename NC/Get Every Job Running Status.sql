select DISTINCT
	job_name,
	run_datetime,
	SUBSTRING(run_duration, 1, 2) + ':' + SUBSTRING(run_duration, 3, 2) + ':' +
	SUBSTRING(run_duration, 5, 2) AS run_duration,
	CASE run_status WHEN 0 THEN 'Failed'
				WHEN 1 THEN 'Succeeded'
				WHEN 2 THEN 'Retry'
				WHEN 3 THEN 'Canceled'
				ELSE 'Unknown'
	END 'status',run_status,
	(CASE WHEN run_status NOT IN (0, 1, 2, 3) THEN dt.message ELSE '' END) as 'reason'
from
(
	select 
		job_name, 
		DATEADD(hh, 0, run_datetime) as run_datetime, 
		run_duration = RIGHT('000000' + CONVERT(varchar(6), h.run_duration), 6),
		run_status,
		h.message
	from
	(
		select 
			j.name as job_name, 
			run_datetime = max(CONVERT(DATETIME, RTRIM(run_date)) + 
				(run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4)
		from msdb..sysjobhistory h
		inner join msdb..sysjobs j on h.job_id = j.job_id
		group by j.name
	) t
	inner join msdb..sysjobs j on t.job_name = j.name
	inner join msdb..sysjobhistory h on	j.job_id = h.job_id 
			and t.run_datetime = (CONVERT(DATETIME, RTRIM(h.run_date)) + 
				(h.run_time * 9 + h.run_time % 10000 * 6 + h.run_time % 100 * 10) / 216e4)
			and DATEADD(DAY, DATEDIFF(DAY, 0, t.run_datetime), 0) = DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0)
) dt