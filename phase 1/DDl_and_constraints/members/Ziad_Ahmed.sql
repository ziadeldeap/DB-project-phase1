-- FIRST: script reset condition
USE master;
IF DB_ID('OlympicsDB') IS NOT NULL
BEGIN
	-- change to single use and stop current oprerations
	ALTER DATABASE OlympicsDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	-- delete database
	DROP DATABASE OlympicsDB;
END

GO
-- creating database
CREATE DATABASE OlympicsDB
--creating primary file
ON PRIMARY (
	NAME = N'Olympics_Primary',
	FILENAME = N'C:\OlympicsDB\Olympics_Primary.mdf',
	SIZE = 10MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 5MB

    ),
	-- creating secondary file
(
	NAME = N'Olympics_Secondary',
	FILENAME =N'C:\OlympicsDB\Olympics_Secondary.ndf',
	SIZE = 10MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 5MB
	
)
-- creating first log file
LOG ON (

	NAME =N'Olympics_log1',
	FILENAME = N'C:\OlympicsDB\Olympics_log1.ldf',
	SIZE = 5MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 5MB
),
-- creating seconed log file
(
	NAME =N'Olympics_log2',
	FILENAME =N'C:\OlympicsDB\Olympics_log2.ldf',
	SIZE = 5MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 5MB

)

GO

USE OlympicsDB;