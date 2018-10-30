--------------------------------------------------------------------------------------------
--
-- Description: 
--
-- Revision history:
-- v1.0, 2015-09-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------
EXEC sp_MSforeachdb 'EXEC [?]..sp_changedbowner ''sa'' '