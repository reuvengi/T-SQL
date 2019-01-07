--------------------------------------------------------------------------------------------
--
-- Description:
--  Enabling query store on a database
-- Revision history:
-- v1.0, 2019-01-07 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
ALTER DATABASE [DatabaseName] SET QUERY_STORE = ON;

ALTER DATABASE [DatabaseName]   
SET QUERY_STORE (  
    OPERATION_MODE = READ_WRITE,  
    CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30),  
    DATA_FLUSH_INTERVAL_SECONDS = 3000,  
    MAX_STORAGE_SIZE_MB = 500,  
    INTERVAL_LENGTH_MINUTES = 15,  
    SIZE_BASED_CLEANUP_MODE = AUTO,  
    QUERY_CAPTURE_MODE = AUTO,  
    MAX_PLANS_PER_QUERY = 1000,
    WAIT_STATS_CAPTURE_MODE = ON 
);