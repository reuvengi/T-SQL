--------------------------------------------------------------------------------------------
--
-- Description: 
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
declare @physical_reads bigint,
            @logical_reads bigint,
            @physical_reads2 bigint,
            @logical_reads2 bigint

select @physical_reads=@@total_read,@logical_reads=cntr_value
from sys.dm_os_performance_counters
where counter_name COLLATE Latin1_General_BIN ='Page lookups/sec'

waitfor delay '00:00:10'

/* grab a second set*/
select @physical_reads2=@@total_read,@logical_reads2=cntr_value
from sys.dm_os_performance_counters
where counter_name COLLATE Latin1_General_BIN ='Page lookups/sec'

/*calculate the cache ratio properly (catering for divide by zero errors)*/
select @physical_reads2-@physical_reads as PhysicalReads, @logical_reads2-@logical_reads as LogicalReads,
case when @physical_reads2-@physical_reads = 0 then -1
else 100-((@physical_reads2-@physical_reads)/CAST((@logical_reads2-@logical_reads) as float)) end
as CacheRatio