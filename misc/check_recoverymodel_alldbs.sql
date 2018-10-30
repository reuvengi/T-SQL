--------------------------------------------------------------------------------------------
--
-- Description: 
--
--	Checking Recovery Model on all databases
--
-- Revision history:
-- v1.0, 2015-10-29 Initial version			Christian Soelje (chrs) Sundhedsdata Styrelsen
--
--------------------------------------------------------------------------------------------

select name, recovery_model_desc as Recovery_mode from sys.databases order by name
go