----------------------------------------------------------------------------------------------------------------------------------
--
-- Description: 
--	SCRIPT TO CREATE SCHEDULES AND DISABLE JOBS IN ALL MAINTENANCE JOBS
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version												Christian Soelje (chrs) Sundhedsdata Styrelsen
--
----------------------------------------------------------------------------------------------------------------------------------
USE [msdb]
GO

-- **********************************************************************************************
-- **                      JOB - DatabaseBackup - USER_DATABASES - FULL
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'DatabaseBackup - USER_DATABASES - FULL', 
		@enabled=0
print ('###    OK	###	- DatabaseBackup - USER_DATABASES - FULL Job disabled' )
GO

-- **  Create schedule on every friday 1800
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'DatabaseBackup - USER_DATABASES - FULL_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DatabaseBackup - USER_DATABASES - FULL', @name=N'DatabaseBackup - USER_DATABASES - FULL_Schedule', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=32, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_end_date=99991231, 
		@active_start_time=180000
	print ('###    OK	###	- DatabaseBackup - USER_DATABASES - FULL Schedule created every Friday 1800' )
END
ELSE
BEGIN
	print ('### WARNING ### - DatabaseBackup - USER_DATABASES - FULL Schedule Allready exist, check schedule' )
END
GO

-- **********************************************************************************************
-- **                      JOB - DatabaseBackup - USER_DATABASES - DIFF
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'DatabaseBackup - USER_DATABASES - DIFF', 
		@enabled=0
print ('###    OK	###	- DatabaseBackup - USER_DATABASES - DIFF Job disabled' )
GO

-- **  Create schedule on every monday, tuesday, wednesday, thursday & Sunday at 2000
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'DatabaseBackup - USER_DATABASES - DIFF_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DatabaseBackup - USER_DATABASES - DIFF', @name=N'DatabaseBackup - USER_DATABASES - DIFF_Schedule', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=95, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_end_date=99991231, 
		@active_start_time=200000
	print ('###    OK	###	- DatabaseBackup - USER_DATABASES - DIFF Schedule created every monday, tuesday, wednesday, thursday & Sunday at 2000' )
END
ELSE
BEGIN
	print ('### WARNING ### - DatabaseBackup - USER_DATABASES - DIFF Schedule Allready exist, check schedule' )
END
GO
-- **********************************************************************************************
-- **                      JOB - DatabaseBackup - USER_DATABASES - LOG
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'DatabaseBackup - USER_DATABASES - LOG', 
		@enabled=0
print ('###    OK	###	- DatabaseBackup - USER_DATABASES - LOG Job disabled' )
GO

-- **  Create schedule on every 30 minutes starting 0020
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'DatabaseBackup - USER_DATABASES - LOG_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DatabaseBackup - USER_DATABASES - LOG', @name=N'DatabaseBackup - USER_DATABASES - LOG_Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_end_date=99991231, 
		@active_start_time=2000
	print ('###    OK	###	- DatabaseBackup - USER_DATABASES - LOG Schedule created every 30 minutes starting 0020' )
END
ELSE
BEGIN
	print ('### WARNING ### - DatabaseBackup - USER_DATABASES - LOG Schedule Allready exist, check schedule' )
END
GO
-- **********************************************************************************************
-- **                      JOB - DatabaseBackup - SYSTEM_DATABASES - FULL
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'DatabaseBackup - SYSTEM_DATABASES - FULL', 
		@enabled=0
print ('###    OK	###	- DatabaseBackup - SYSTEM_DATABASES - FULL Job disabled' )
GO

-- **  Create schedule on every day 2100
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'DatabaseBackup - SYSTEM_DATABASES - FULL_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DatabaseBackup - SYSTEM_DATABASES - FULL', @name=N'DatabaseBackup - SYSTEM_DATABASES - FULL_Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_end_date=99991231, 
		@active_start_time=210000
	print ('###    OK	###	- DatabaseBackup - SYSTEM_DATABASES - FULL Schedule created every day 2100' )
END
ELSE
BEGIN
	print ('### WARNING ### - DatabaseBackup - SYSTEM_DATABASES - FULL Schedule Allready exist, check schedule' )
END
GO
-- **********************************************************************************************
-- **                      JOB - DatabaseIntegrityCheck - USER_DATABASES
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'DatabaseIntegrityCheck - USER_DATABASES', 
		@enabled=0
print ('###    OK	###	- DatabaseIntegrityCheck - USER_DATABASES Job disabled' )
GO

-- **  Create schedule on every saturday at 12:00
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'DatabaseIntegrityCheck - USER_DATABASES_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DatabaseIntegrityCheck - USER_DATABASES', @name=N'DatabaseIntegrityCheck - USER_DATABASES_Schedule', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=64, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_end_date=99991231, 
		@active_start_time=120000 
	print ('###    OK	###	- DatabaseIntegrityCheck - USER_DATABASES Schedule created every saturday at 12:00' )
END
ELSE
BEGIN
	print ('### WARNING ### - DatabaseIntegrityCheck - USER_DATABASES Schedule Allready exist, check schedule' )
END
GO
-- **********************************************************************************************
-- **                      JOB - DatabaseIntegrityCheck - SYSTEM_DATABASES
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'DatabaseIntegrityCheck - SYSTEM_DATABASES', 
		@enabled=0
print ('###    OK	###	- DatabaseIntegrityCheck - SYSTEM_DATABASES Job disabled' )
GO

-- **  Create schedule on every saturday at 1100
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'DatabaseIntegrityCheck - SYSTEM_DATABASES_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'DatabaseIntegrityCheck - SYSTEM_DATABASES', @name=N'DatabaseIntegrityCheck - System_Databases_Schedule', 
			@enabled=1, 
			@freq_type=8, 
			@freq_interval=64, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_end_date=99991231, 
			@active_start_time=110000, 
			@active_end_time=235959
	print ('###    OK	###	- DatabaseIntegrityCheck - SYSTEM_DATABASES Schedule created every Saturday 1200' )
END
ELSE
BEGIN
	print ('### WARNING ### - DatabaseIntegrityCheck - SYSTEM_DATABASES Schedule Allready exist, check schedule' )
END
GO
-- **********************************************************************************************
-- **                      JOB - IndexOptimize - USER_DATABASES
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'IndexOptimize - USER_DATABASES', 
		@enabled=0
print ('###    OK	###	- IndexOptimize - USER_DATABASES Job disabled' )
GO

-- **  Create schedule on every day at 00:00
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'IndexOptimize - USER_DATABASES_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'IndexOptimize - USER_DATABASES', @name=N'IndexOptimize - USER_DATABASES_Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20130111, 
		@active_start_time=0 
		print ('###    OK	###	- IndexOptimize - USER_DATABASES Schedule created every day at  00:00' )
END
ELSE
BEGIN
	print ('### WARNING ### - IndexOptimize - USER_DATABASES Schedule Allready exist, check schedule' )
END
GO

/*
--EXCLUDED AS THIS JOB WILL NOT BE USED AT FKIT

-- **********************************************************************************************
-- **                      JOB - CommandLog Cleanup
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'CommandLog Cleanup', 
		@enabled=0
print ('###    OK	###	- CommandLog Cleanup Job disabled' )
GO

-- **  Create schedule on every xxx
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'CommandLog Cleanup_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'CommandLog Cleanup', @name=N'CommandLog Cleanup_Schedule', 
			@enabled=1, 
			@freq_type=8, 
			@freq_interval=64, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_end_date=99991231, 
			@active_start_time=120000, 
			@active_end_time=235959
	print ('###    OK	###	- CommandLog Cleanup Schedule created every xxx' )
END
ELSE
BEGIN
	print ('### WARNING ### - CommandLog Cleanup Schedule Allready exist, check schedule' )
END
GO

--STOP EXCLUSION
*/


-- **********************************************************************************************
-- **                      JOB - Output File Cleanup
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'Output File Cleanup', 
		@enabled=0
print ('###    OK	###	- Output File Cleanup Job disabled' )
GO

-- **  Create schedule on every sunday 12:00
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'Output File Cleanup_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'Output File Cleanup', @name=N'Output File Cleanup_Schedule', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20130111, 
		@active_start_time=120000 
	print ('###    OK	###	- Output File Cleanup Schedule created every Sunday 12:00' )
END
ELSE
BEGIN
	print ('### WARNING ### - Output File Cleanup Schedule Allready exist, check schedule' )
END
GO

-- **********************************************************************************************
-- **                      JOB - sp_purge_jobhistory
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'sp_purge_jobhistory', 
		@enabled=0
print ('###    OK	###	- sp_purge_jobhistory Job disabled' )
GO

-- **  Create schedule on every Sunday 12:00
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'sp_purge_jobhistory_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'sp_purge_jobhistory', @name=N'sp_purge_jobhistory_Schedule', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20130111, 
		@active_start_time=120000 
	print ('###    OK	###	- sp_purge_jobhistory Schedule created every Sunday 12:00' )
END
ELSE
BEGIN
	print ('### WARNING ### - sp_purge_jobhistory Schedule Allready exist, check schedule' )
END
GO
-- **********************************************************************************************
-- **                      JOB - sp_delete_backuphistory
-- **********************************************************************************************
-- **  Disable the job
EXEC msdb.dbo.sp_update_job @job_name=N'sp_delete_backuphistory', 
		@enabled=0
print ('###    OK	###	- sp_delete_backuphistory Job disabled' )
GO

-- **  Create schedule on every Sunday at 12:00
if 0 = (SELECT count(*) FROM msdb.dbo.sysschedules where name = 'sp_delete_backuphistory_Schedule')
BEGIN
	EXEC msdb.dbo.sp_add_jobschedule @job_name=N'sp_delete_backuphistory', @name=N'sp_delete_backuphistory_Schedule', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20130111, 
		@active_start_time=120000 
	print ('###    OK	###	- sp_delete_backuphistory Schedule created every Sunday 12:00' )
END
ELSE