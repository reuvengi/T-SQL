--------------------------------------------------------------------------------------------
--
-- Description:
--  Getting the audit class type's number
-- Revision history:
-- v1.0, 2018-11-15 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------

SELECT spt.[name], spt.[number]
FROM   [master].[dbo].[spt_values] spt
WHERE  spt.[type] = N'EOD'
ORDER BY spt.[name];