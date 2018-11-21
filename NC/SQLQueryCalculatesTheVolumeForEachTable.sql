SET NOCOUNT ON 
    IF OBJECT_ID('tempdb..#SpaceUsed') IS NOT NULL DROP TABLE #SpaceUsed

    CREATE TABLE #SpaceUsed 
    (
    TableName sysname ,
    [Rows] int ,
    [Reserved] varchar(20),
    [Data] varchar(20),
    [Index_Size] varchar(20),
    [Unused] varchar(20),
    [Reserved_KB] bigint,
    [Data_KB] bigint,
    [Index_Size_KB] bigint,
    [Unused_KB] bigint
    )

    DECLARE @CMD NVARCHAR(MAX) =''
    SELECT @CMD +='EXEC sp_spaceused ' +  ''''+QUOTENAME(TABLE_SCHEMA)+'.'+ QUOTENAME(TABLE_NAME)+''''+';'+CHAR(10)
    FROM INFORMATION_SCHEMA.TABLES 
    --PRINT @CMD

     INSERT INTO #SpaceUsed (TableName ,[Rows] , [Reserved], [Data] , [Index_Size] , [Unused] )
     EXEC sp_executesql @CMD



     UPDATE #SpaceUsed 
     SET [Reserved_KB] = CONVERT(BIGINT,RTRIM(LTRIM(REPLACE([Reserved] , ' KB', '')))),
         [Data_KB] = CONVERT(BIGINT,RTRIM(LTRIM(REPLACE([Data] , ' KB', '')))),
         [Index_Size_KB]= CONVERT(BIGINT,RTRIM(LTRIM(REPLACE([Index_Size] , ' KB', '')))),
         [Unused_KB]= CONVERT(BIGINT,RTRIM(LTRIM(REPLACE([Unused] , ' KB', ''))))


     SELECT TableName, [Rows], Reserved_KB , Data_KB , Index_Size_KB , Unused_KB ,  Data_KB / 1024.0 Data_MB , Data_KB / 1024.0 / 1024.0 Data_GB
     FROM #SpaceUsed
     ORDER BY Data_KB DESC 

     SELECT SUM(Reserved_KB) Reserved_KB , SUM(Data_KB) Data_KB, SUM(Index_Size_KB) Index_Size_KB , SUM(Unused_KB) Unused_KB ,SUM(Data_KB / 1024.0) Data_MB , SUM(Data_KB / 1024.0 / 1024.0) Data_GB
     FROM #SpaceUsed

     DROP TABLE #SpaceUsed