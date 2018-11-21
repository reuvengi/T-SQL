set nocount on
create table #spaceused (
  name nvarchar(120),
  rows char(11),
  reserved varchar(18),
  data varchar(18),
  index_size varchar(18),
  unused varchar(18)
)

declare Tables cursor for
  select name
  from sysobjects where type='U'
  order by name asc

OPEN Tables
DECLARE @table varchar(128)

FETCH NEXT FROM Tables INTO @table

WHILE @@FETCH_STATUS = 0
BEGIN
  insert into #spaceused exec sp_spaceused @table
  FETCH NEXT FROM Tables INTO @table
END

CLOSE Tables
DEALLOCATE Tables 

select * from #spaceused 
drop table #spaceused

exec sp_spaceused


--SELECT SUM(DATALENGTH(Kommuner)) / 1048576.0 
--FROM dbo.Kommuner


