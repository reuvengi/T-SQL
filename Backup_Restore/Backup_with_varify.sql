



BACKUP DATABASE [GPA] TO  DISK = N'K:\Backup\GPA_FULL_20161005.bak' WITH NOFORMAT, INIT,  NAME = N'GPA-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10, CHECKSUM
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'GPA' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'GPA' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''GPA'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'K:\Backup\GPA_FULL_20161005.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO
