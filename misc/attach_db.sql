--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	Attaching a Database
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
USE [master]
GO
CREATE DATABASE [Parkering] ON 
( FILENAME = N'<MDF File path>' ),
( FILENAME = N'<LDF File path>' )
 FOR ATTACH
GO