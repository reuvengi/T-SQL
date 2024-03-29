--The Dynamic Management View (DMV) named sys.dm_db_index_usage_stats that track 
-- index usage details of the database. This DMV gives an information about an index 
-- which is being updated but not used in any seeks, scan or lookup operations.
-- The below query listTable nameIndex name,N
USE [DatabaseName]
GO

select object_name(i.object_id) as ObjectName, i.name as [Unused Index],MAX(p.rows) Rows 
,8 * SUM(a.used_pages) AS 'Indexsize(KB)',
case  
    when i.type = 0 then 'Heap'  
    when i.type= 1 then 'clustered' 
    when i.type=2 then 'Non-clustered'   
    when i.type=3 then 'XML'   
    when i.type=4 then 'Spatial'  
    when i.type=5 then 'Clustered xVelocity memory optimized columnstore index'   
    when i.type=6 then 'Nonclustered columnstore index'  
end index_type,
case  
    when MAX(CONVERT(int,i.is_disabled)) = 0 then 'Enabled'  
    when MAX(CONVERT(int,i.is_disabled)) = 1 then 'Disabled' 
end 'Status',
max(s.user_seeks) as UserSeeks,
max(s.user_scans) as UserScans,
max(s.user_lookups) as UserLookUps, 
max(s.user_updates) as UserUpdates, 
max(s.last_user_seek) as LastUserSeek, 
max(s.last_user_scan) as LastUserScan, 
max(s.last_user_lookup) as LastUserLookUp, 
max(s.last_user_update) as LastUserUpdate,   
'ALTER INDEX ' + i.name + ' ON ' + object_name(i.object_id)  + ' DISABLE' 'Disable Statement' 
from sys.indexes i 
left join sys.dm_db_index_usage_stats s on s.object_id = i.object_id 
     and i.index_id = s.index_id 
     and s.database_id = db_id() 
JOIN sys.partitions AS p ON p.OBJECT_ID = i.OBJECT_ID AND p.index_id = i.index_id 
JOIN sys.allocation_units AS a ON a.container_id = p.partition_id 
where objectproperty(i.object_id, 'IsIndexable') = 1 
AND objectproperty(i.object_id, 'IsIndexed') = 1 
and s.index_id is null -- and dm_db_index_usage_stats has no reference to this index 
or (s.user_updates > 0 and s.user_seeks = 0 and s.user_scans = 0 and s.user_lookups = 0)-- index is being updated, but not used by seeks/scans/lookups 
GROUP BY object_name(i.object_id) ,i.name,i.type 
order by object_name(i.object_id) asc