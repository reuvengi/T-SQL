--------------------------------------------------------------------------------------------
--
-- Description: 
--	Backing up all databases
--
-- Revision history:
-- v1.0, 2016-11-24 Initial version			Christian Soelje Copenhagen Business School
--
--------------------------------------------------------------------------------------------
USE [master]
GO

ALTER DATABASE [MyTechMantra] 
	MODIFY FILE ( NAME = N'MyTechMantra', FILEGROWTH = 512MB )
GO

ALTER DATABASE [MyTechMantra] 
	MODIFY FILE 
		(NAME = N'MyTechMantra_log', FILEGROWTH = 256MB )
GO