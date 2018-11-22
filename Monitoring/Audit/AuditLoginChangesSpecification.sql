--------------------------------------------------------------------------------------------
--
-- Description:
--  Creates the audit for permission done on the server
-- Revision history:
-- v1.0, 2018-11-14 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------

USE [master]
GO

CREATE SERVER AUDIT [Permission_Audit]
TO FILE 
(	FILEPATH = N'L:\SQL_PermissionsLog\'
	,MAXSIZE = 0 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
)
WHERE  class_type != 17747;

ALTER SERVER AUDIT [Permission_Audit] WITH (STATE = ON)
GO

CREATE SERVER AUDIT SPECIFICATION [AuditPermissionsServerSpecification]
FOR SERVER AUDIT [Permission_Audit]
ADD (SERVER_PERMISSION_CHANGE_GROUP),
ADD (SERVER_ROLE_MEMBER_CHANGE_GROUP),
ADD (DATABASE_PERMISSION_CHANGE_GROUP),
ADD (DATABASE_ROLE_MEMBER_CHANGE_GROUP)
WITH (STATE = OFF)
GO


