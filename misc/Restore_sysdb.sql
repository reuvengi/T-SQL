--------------------------------------------------------------------------------------
--
-- Description:
--  Restoring master database
-- Revision history:
-- v1.0, 2018-09-11 Initial version     Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------

RESTORE DATABASE [master] FROM DISK = N'S:\Program
Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\
Backup\master_FULL.bak' WITH FILE = 1, MOVE N'master' TO N'S:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\master.mdf', MOVE N'mastlog' TO N'S:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\mastlog.ldf'