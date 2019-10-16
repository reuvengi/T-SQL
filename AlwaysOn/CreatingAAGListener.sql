--------------------------------------------------------------------------------------------
--
-- Description:
--  Creates a Availability Group Listener
--
-- Revision history:
-- v1.0, 2019-10-16 Initial version        Christian Solje (csolje@gmail.com) @dbamist
--
--------------------------------------------------------------------------------------------
USE [master]
GO
ALTER AVAILABILITY GROUP [MSCORPAG]
ADD LISTENER N'mscorpag' (
WITH IP
((N'192.168.0.7', N'255.255.252.0')
)
, PORT=1433);
GO