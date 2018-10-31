---------------------------------------------------------------------------------------------
--
-- Description:
--  Altering database autogrowth, initial size and maxsize
-- Revision history:
-- v1.0, 2018-10-31 Initial version         Christian Soelje (chso@netcompany.com) Netcompany
--
---------------------------------------------------------------------------------------------
USE [master]
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp2', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp3', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp4', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp5', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp6', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp7', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp8', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'tempdev', SIZE = 8388608KB , MAXSIZE = 102400000KB , FILEGROWTH = 1048576KB )
GO
