--------------------------------------------------------------------------------------------
--
-- Description:
--  Listing the name, endpoint, connection description, backup priority and the read only
--  rounting URL
--
-- Revision history:
-- v1.0, 2019-05-28 Initial version        Christian Soelje (chso@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
SELECT Replica_Server_name, Endpoint_url, Secondary_Role_Allow_Connections_Desc, Backup_Priority, Read_Only_Routing_Url FROM sys.availability_replicas