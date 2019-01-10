--------------------------------------------------------------------------------------------
--
-- Description:
--  Manual FailOver for Availablity Group
-- Revision history:
-- v1.0, 2019-01-10 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
-- Normal FailOver without data loss
ALTER AVAILABILITY GROUP [test_ag] FAILOVER;
GO

-- Forced FailOver with acceptence of data loss
ALTER AVAILABILITY GROUP [test_ag] FORCE_FAILOVER_ALLOW_DATA_LOSS;
GO