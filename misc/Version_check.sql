--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	Checking Version on the SQL server
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
SELECT
SERVERPROPERTY('ProductVersion') AS ProductVersion,
SERVERPROPERTY('ProductLevel') AS ProductLevel,
SERVERPROPERTY('ProductUpdateLevel') AS ProductUpdateLevel,
SERVERPROPERTY('ProductBuild') AS ProductBuild,
SERVERPROPERTY('ProductUpdateReference') AS ProductUpdateReference,
SERVERPROPERTY('ProductMajorVersion') AS ProductMajorVersion,
SERVERPROPERTY('ProductMinorVersion') AS ProductMinorVersion,
SERVERPROPERTY('ProductBuildType') AS ProductBuildType,
SERVERPROPERTY('Edition') AS Edition
GO

--SELECT RIGHT(SUBSTRING(@@VERSION, CHARINDEX('Windows NT', @@VERSION), 14), 3) AS WindowsOS_Version
