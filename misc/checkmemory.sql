--------------------------------------------------------------------------------------
--
-- Description: 
--
-- Revision history:
-- v1.0, 2016-09-23 Initial version			Christian Soelje (cso.it) CBS
--
--------------------------------------------------------------------------------------
SELECT available_physical_memory_kb/1024 as "Total Memory MB",
       available_physical_memory_kb/(total_physical_memory_kb*1.0)*100 AS "% Memory Free"
FROM sys.dm_os_sys_memory