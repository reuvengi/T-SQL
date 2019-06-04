--------------------------------------------------------------------------------------------
--
-- Description:
--  Setting up secondary replica to readonly and creating the read_only_routing_url
--
-- Revision history:
-- v1.0, 2019-05-28 Initial version        Christian Soelje (chso@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------

ALTER AVAILABILITY GROUP [<AVAILABILITY_GROUPNAME>]
 MODIFY REPLICA ON
N'<ReplicaName2>' WITH
(SECONDARY_ROLE (ALLOW_CONNECTIONS = READ_ONLY));
ALTER AVAILABILITY GROUP [<AVAILABILITY_GROUPNAME>]
 MODIFY REPLICA ON
N'<ReplicaName2>' WITH
(SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'tcp://<ReplicaFQDN2:[PORT]>'));

ALTER AVAILABILITY GROUP [<AVAILABILITY_GROUPNAME>]
 MODIFY REPLICA ON
N'<ReplicaName1>' WITH
(SECONDARY_ROLE (ALLOW_CONNECTIONS = READ_ONLY));
ALTER AVAILABILITY GROUP [<AVAILABILITY_GROUPNAME>]
 MODIFY REPLICA ON
N'<ReplicaName1>' WITH
(SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'tcp://<ReplicaFQDN1:[PORT]>'));

ALTER AVAILABILITY GROUP [<AVAILABILITY_GROUPNAME>]
MODIFY REPLICA ON
N'<ReplicaName2>' WITH
(PRIMARY_ROLE (READ_ONLY_ROUTING_LIST=('<ReplicaName2>','<ReplicaName1>')));

ALTER AVAILABILITY GROUP [<AVAILABILITY_GROUPNAME>]
MODIFY REPLICA ON
N'<ReplicaName1>' WITH
(PRIMARY_ROLE (READ_ONLY_ROUTING_LIST=('<ReplicaName1>','<ReplicaName2>')));
