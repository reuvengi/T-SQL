/*
(C) 2015 NAER - Martin Backs (NAER)
*/

/****** Object:  Step [DatabaseBackup - USER_DATABASES - FULL]    Script Date: 14-04-2015 07:02:04 ******/

USE [msdb]
GO
SET NOCOUNT ON

DECLARE @JobName_FULL nvarchar(max)
DECLARE @JobName_DIFF nvarchar(max)
DECLARE @JobName_LOG nvarchar(max)
DECLARE @JobStep_Name_1 nvarchar(max)
DECLARE @step_id_1 nvarchar(max)
DECLARE @cmdexec_success_code_1 nvarchar(max)
DECLARE @on_success_action_Step_1 nvarchar(max)
DECLARE @on_success_action_Step_2 nvarchar(max)
DECLARE @on_fail_action_1 nvarchar(max)
DECLARE @retry_attempts_1 nvarchar(max)
DECLARE @retry_interval_1 nvarchar(max)
DECLARE @os_run_priority_1 nvarchar(max)
DECLARE @subsystem_1 nvarchar(max)
DECLARE @Command_FULL nvarchar(max)
DECLARE @Command_DIFF nvarchar(max)
DECLARE @Command_LOG nvarchar(max)
DECLARE @database_name_1 nvarchar(max)
DECLARE @flags_1 nvarchar(max)
DECLARE @TokenServerInstance nvarchar(max)
DECLARE @TokenInstance nvarchar(max)
DECLARE @TokenMachineName nvarchar(max)


SET @JobStep_Name_1 = 'Generate Dynamic Restore Script'
SET @step_id_1 = 2
SET @cmdexec_success_code_1 = 0
SET @on_success_action_Step_1 = 3
SET @on_success_action_Step_2 = 1
SET @on_fail_action_1 = 2
SET @retry_attempts_1 = 0
SET @retry_interval_1 = 0
SET @os_run_priority_1 = 0
SET @subsystem_1 = 'PowerShell'
SET @database_name_1 = 'master'
SET @flags_1 = 32

SET @TokenServerInstance = '$' + '(ESCAPE_SQUOTE(SRVR))'
SET @TokenInstance = '$' + '(ESCAPE_SQUOTE(INST))'
SET @TokenMachineName = '$' + '(ESCAPE_SQUOTE(MACH))'	


EXEC msdb.dbo.sp_update_jobstep @job_name = N'DatabaseBackup - USER_DATABASES - FULL', @step_id=1 , @on_success_action = @on_success_action_Step_1, @flags = @flags_1
--		@on_success_action=3, @flags=32
SET @JobName_FULL = 'DatabaseBackup - USER_DATABASES - FULL'
SET @Command_FULL = '$BackupDirectory = ''HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL11.' + @TokenInstance + '\MSSQLServer'';' + ' $InstanceBackupDirectory = (Get-ItemProperty -Path $BackupDirectory -Name BackupDirectory).BackupDirectory;' + ' SQLCMD -E -S ' + @TokenServerInstance + ' -Q "EXEC DBADB.dbo.GenerateRestoreScript" -o "$InstanceBackupDirectory\' + @TokenMachineName + '`$' + @TokenInstance + '\Restore_Script.txt"'
EXECUTE msdb.dbo.sp_add_jobstep @job_name= @JobName_FULL, @step_name = @JobStep_Name_1, @step_id = @step_id_1, @cmdexec_success_code = @cmdexec_success_code_1, @on_success_action = @on_success_action_Step_2, @on_fail_action = @on_fail_action_1, @retry_attempts = @retry_attempts_1, @retry_interval = @retry_interval_1, @os_run_priority = @os_run_priority_1, @subsystem = @subsystem_1, @command = @Command_FULL, @database_name = @database_name_1,  @flags = @flags_1

---
/****** Object:  Step [DatabaseBackup - USER_DATABASES - DIFF]    Script Date: 14-04-2015 07:02:04 ******/
EXEC msdb.dbo.sp_update_jobstep @job_name = N'DatabaseBackup - USER_DATABASES - DIFF', @step_id=1 , @on_success_action = @on_success_action_Step_1, @flags = @flags_1
--		@on_success_action=3

SET @JobName_DIFF = 'DatabaseBackup - USER_DATABASES - DIFF'
SET @Command_DIFF = '$BackupDirectory = ''HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL11.' + @TokenInstance + '\MSSQLServer'';' + ' $InstanceBackupDirectory = (Get-ItemProperty -Path $BackupDirectory -Name BackupDirectory).BackupDirectory;' + ' SQLCMD -E -S ' + @TokenServerInstance + ' -Q "EXEC DBADB.dbo.GenerateRestoreScript" -o "$InstanceBackupDirectory\' + @TokenMachineName + '`$' + @TokenInstance + '\Restore_Script.txt"'
EXECUTE msdb.dbo.sp_add_jobstep @job_name= @JobName_DIFF, @step_name = @JobStep_Name_1, @step_id = @step_id_1, @cmdexec_success_code = @cmdexec_success_code_1, @on_success_action = @on_success_action_Step_2, @on_fail_action = @on_fail_action_1, @retry_attempts = @retry_attempts_1, @retry_interval = @retry_interval_1, @os_run_priority = @os_run_priority_1, @subsystem = @subsystem_1, @command = @Command_DIFF, @database_name = @database_name_1,  @flags = @flags_1

---
/****** Object:  Step [DatabaseBackup - USER_DATABASES - LOG]    Script Date: 14-04-2015 07:02:04 ******/
EXEC msdb.dbo.sp_update_jobstep @job_name = N'DatabaseBackup - USER_DATABASES - LOG', @step_id=1 , @on_success_action = @on_success_action_Step_1, @flags = @flags_1
--		@on_success_action=3
--@on_success_action = @on_success_action_1

SET @JobName_LOG = 'DatabaseBackup - USER_DATABASES - LOG'
SET @Command_LOG = '$BackupDirectory = ''HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL11.' + @TokenInstance + '\MSSQLServer'';' + ' $InstanceBackupDirectory = (Get-ItemProperty -Path $BackupDirectory -Name BackupDirectory).BackupDirectory;' + ' SQLCMD -E -S ' + @TokenServerInstance + ' -Q "EXEC DBADB.dbo.GenerateRestoreScript" -o "$InstanceBackupDirectory\' + @TokenMachineName + '`$' + @TokenInstance + '\Restore_Script.txt"'

EXECUTE msdb.dbo.sp_add_jobstep @job_name= @JobName_LOG, @step_name = @JobStep_Name_1, @step_id = @step_id_1, @cmdexec_success_code = @cmdexec_success_code_1, @on_success_action = @on_success_action_Step_2, @on_fail_action = @on_fail_action_1, @retry_attempts = @retry_attempts_1, @retry_interval = @retry_interval_1, @os_run_priority = @os_run_priority_1, @subsystem = @subsystem_1, @command = @Command_LOG, @database_name = @database_name_1,  @flags = @flags_1
GO

