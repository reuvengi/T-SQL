USE master;
GO

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE WITH OVERRIDE;
GO

EXEC sp_configure N'scan for startup procs', 1;
RECONFIGURE WITH OVERRIDE;
GO

CREATE PROCEDURE dbo.sp_startup
AS
BEGIN
	/*
		Autor:	Uwe Ricken - db Berater GmbH
				uwe.ricken@db-berater.de

		Datum:	01.12.2016

		Info:	Diese Prozedur ist als Startprozedur auf allen Servern hinterlegt.
				Mit Hilfe dieser Prozedur werden initiale Konfigurationseinstellungen
				vorgenommen, die bei jedem Start vorhanden sein sollen.

				Um eine individuelle Anpassung der Startparameter zu verhindern,
				wurde der Weg einer Startprozedur gewählt.
	*/

	-- Aktivierung von TF 1117: Wachstum aller Dateien einer Datenbank zur gleichen Zeit
	-- https://msdn.microsoft.com/de-de/library/ms188396.aspx
	DBCC TRACEON (1117, -1);

	-- Aktivierung von TF 1118: Verwendung von UNIFORM extents statt MIXED extents bei kleinen Tabellen (<= 8 Pages)
	-- https://msdn.microsoft.com/de-de/library/ms188396.aspx
	DBCC TRACEON (1118, -1);

	-- Anpassung des Cost Thresholds für die Aktualsierung von Statistiken
	-- https://support.microsoft.com/en-us/kb/2754171
	DBCC TRACEON (2371, -1);

	-- Unterdrückung von "Successful backup" in Fehlerprotokoll
	-- https://msdn.microsoft.com/de-de/library/ms188396.aspx
	DBCC TRACEON (3226, -1);
END
GO

-- Konfiguration der Prozedur als Startup-Prozedur
EXEC sp_procoption @ProcName = N'sp_startup', @OptionName = 'startup', @OptionValue = 'true';
GO

-- Aktivierung aller TF und Ausgabe des Ergebnisses
EXEC dbo.sp_startup;
GO

DBCC TRACESTATUS(-1);
GO
