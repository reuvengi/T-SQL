--------------------------------------------------------------------------------------------
--
-- Description: 
--	Backing up all databases
--
-- Revision history:
-- v1.0, 2016-11-03 Initial version			Christian Soelje Copenhagen Business School
--
--------------------------------------------------------------------------------------------

USE [master]
GO
ALTER AVAILABILITY GROUP [SQL-AO-PRD-002] SET(
AUTOMATED_BACKUP_PREFERENCE = PRIMARY
);
GO
