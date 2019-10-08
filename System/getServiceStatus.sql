--------------------------------------------------------------------------------------------
--
-- Description:
--  Listing status on services
--
-- Revision history:
-- v1.0, 2019-10-08 Initial version        Christian Solje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
SELECT servicename, startup_type_desc, status_desc, service_account
FROM sys.dm_server_services