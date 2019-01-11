--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	Moving Always on group to the secondary replica
--
-- Revision history:
-- v1.0, 2016-10-10 Initial version			Christian Soelje (chrs) Copenhagen Business School
--
--------------------------------------------------------------------------------------------
--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
--:Connect <FailOver SQL Server>

ALTER AVAILABILITY GROUP [AG-Group] FAILOVER;

GO