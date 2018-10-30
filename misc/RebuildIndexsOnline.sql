--------------------------------------------------------------------------------------------
--
-- Description:
--
-- Revision history:
-- v1.0, 2018-10-17 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE [AdvisDb]
GO
ALTER INDEX ALL ON [dbo].[Besked] REBUILD PARTITION = ALL WITH (ONLINE = ON)
GO
ALTER INDEX ALL ON [dbo].[Beskedkuvert] REBUILD PARTITION = ALL WITH (ONLINE=ON)
GO
ALTER INDEX ALL ON [dbo].[TilladtModtager] REBUILD PARTITION = ALL WITH (ONLINE=ON)
GO
