--------------------------------------------------------------------------------------------
--
-- Description:
--  Granting access to NC operators mssql group with the privilegies it needs.
-- Revision history:
-- v1.0, 2018-10-18 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
--
--------------------------------------------------------------------------------------------
USE [master];
GO

CREATE LOGIN [komb-fli-prod\g_komb-flip-sql01_prod_fli_komb_nchosting_dk_admin] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english];
GO
GRANT CONTROL SERVER TO [komb-fli-prod\g_komb-flip-sql01_prod_fli_komb_nchosting_dk_admin];
GO
USE [DATABASE];
CREATE USER [komb-fli-prod\g_komb-flip-sql01_prod_fli_komb_nchosting_dk_admin] FOR LOGIN [komb-fli-prod\g_komb-flip-sql01_prod_fli_komb_nchosting_dk_admin] WITH DEFAULT_SCHEMA=[dbo];
DENY SELECT TO [komb-fli-prod\g_komb-flip-sql01_prod_fli_komb_nchosting_dk_admin];
GO