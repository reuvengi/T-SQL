--------------------------------------------------------------------------------------------
--
-- Description: 
-- The backup with multiable files is to speed up the backup process. The MAX amount of files that you 
-- can backup is the equel to how many CPU's the SQL Server has.
-- 
-- Replace <Databasename> with the name of your database.
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
BACKUP DATABASE [<Databasename>] TO DISK = '<Backup path>_File1.bak',  
									DISK = '<Backup path>_File2.bak',  
									DISK = '<Backup path>_File3.bak',  
									DISK = '<Backup path>_File4.bak',  
									DISK = '<Backup path>_File5.bak' WITH FORMAT, INIT, STATS = 100
GO