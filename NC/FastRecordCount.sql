use BBR
SELECT Total_Bygning = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'Bygning' AND (index_id < 2)
GO

SELECT Total_BBRAdresse = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'BBRAdresse' AND (index_id < 2)
GO

SELECT Total_Byggesag = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'Byggesag' AND (index_id < 2)
GO

SELECT Total_Enhed = SUM(st.row_count)
FROM
   sys.dm_db_partition_stats st
WHERE
    object_name(object_id) = 'Enhed' AND (index_id < 2)
 GO
