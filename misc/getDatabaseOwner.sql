--------------------------------------------------------------------------------------------
--
-- Description:
--  Listing the database owner
-- Revision history:
-- v1.0, 2018-10-18 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
SELECT l.name AS 'login'
FROM sysusers u
    INNER JOIN master..syslogins l
    ON u.sid = l.sid
WHERE u.name = 'dbo';
GO