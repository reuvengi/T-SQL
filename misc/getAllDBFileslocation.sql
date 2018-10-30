--------------------------------------------------------------------------------------------
--
-- Description:
--
-- Revision history:
-- v1.0, 2018-10-16 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
SELECT
    db.name AS DBName,
    type_desc AS FileType,
    Physical_Name AS Location
FROM
    sys.master_files mf
    INNER JOIN
    sys.databases db ON db.database_id = mf.database_id