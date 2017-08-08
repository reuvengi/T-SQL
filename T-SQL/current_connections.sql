----------------------------------------------------------------------------------------------------------------------------------
--
-- Description: 
--	Showing current connections on the server
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version												Christian Soelje (chrs) Sundhedsdata Styrelsen
--
----------------------------------------------------------------------------------------------------------------------------------
USE master
GO
SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame
;