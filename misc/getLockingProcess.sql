-----------------------------------------------------------------------------------------------------------------
--
-- Description:
--  Checking the server for locking processes
-- Revision history:
-- v1.0, 2018-12-19 Initial version              Christian Solje csolje@gmail.com) @dbamist
--
-----------------------------------------------------------------------------------------------------------------
DECLARE @Table TABLE(
        SPID INT,
        Status VARCHAR(MAX),
        LOGIN VARCHAR(MAX),
        HostName VARCHAR(MAX),
        BlkBy VARCHAR(MAX),
        DBName VARCHAR(MAX),
        Command VARCHAR(MAX),
        CPUTime INT,
        DiskIO INT,
        LastBatch VARCHAR(MAX),
        ProgramName VARCHAR(MAX),
        SPID_1 INT,
        REQUESTID INT
)

INSERT INTO @Table EXEC sp_who2

SELECT  COUNT(*)
FROM    @Table
WHERE BlkBy >= '.'