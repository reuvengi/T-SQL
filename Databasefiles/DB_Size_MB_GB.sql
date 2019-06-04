--------------------------------------------------------------------------------------------
--
-- Description:
--  Get the size of the database in MB and GB
-- Revision history:
-- v1.0, 2019-02-13 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
SELECT d.NAME
    ,ROUND(SUM(mf.size) * 8 / 1024, 0) Size_MBs
    ,(SUM(mf.size) * 8 / 1024) / 1024 AS Size_GBs
FROM sys.master_files mf
INNER JOIN sys.databases d ON d.database_id = mf.database_id
WHERE d.database_id > 4 -- Skip system databases
GROUP BY d.NAME
ORDER BY d.NAME