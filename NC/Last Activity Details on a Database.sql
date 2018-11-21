
USE CUSTOMERPRODUCT
GO
SELECT
      T.NAME
      ,USER_SEEKS
      ,USER_SCANS
      ,USER_LOOKUPS
      ,USER_UPDATES
      ,LAST_USER_SEEK
      ,LAST_USER_SCAN
      ,LAST_USER_LOOKUP
      ,LAST_USER_UPDATE
FROM
      SYS.DM_DB_INDEX_USAGE_STATS I JOIN
      SYS.TABLES T ON (T.OBJECT_ID = I.OBJECT_ID)
WHERE
      DATABASE_ID = DB_ID('CUSTOMERPRODUCT')
ORDER BY LAST_USER_SEEK DESC