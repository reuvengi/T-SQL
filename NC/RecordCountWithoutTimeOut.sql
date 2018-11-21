use QUERYENGINE
SELECT Total_Rows_KildesystemKald_QUERYENGINE = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'KildesystemKald' AND (index_id < 2)
GO


USE QueryEngineVerification    
SELECT Total_Rows_KildesystemKald_Verification = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'KildesystemKald' AND (index_id < 2)
GO

USE QUERYENGINE  
SELECT Total_Rows_KildesystemSvar_QUERYENGINE = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'KildesystemSvar' AND (index_id < 2)
GO


USE QueryEngineVerification
SELECT Total_Rows_KildesystemSvar_Verification = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'KildesystemSvar' AND (index_id < 2)
 GO



