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
GO

CREATE TABLE Country (

country_id INT IDENTITY(1,1) NOT NULL,
country_name VARCHAR(100) NOT NULL,
--PRIMARY KEY KEYWORD TO MAKE 
CONSTRAINT PK_country PRIMARY KEY (country_id),
CONSTRAINT UQ_country_name UNIQUE(country_name),

);

CREATE TABLE games (
	games_id INT IDENTITY(1,1)NOT NULL,
	host_city VARCHAR(100) NOT NULL,
	season VARCHAR (100) NOT NULL CONSTRAINT DF_games_season DEFAULT 'Summer',
	game_year INT NOT NULL,
	game_country_id INT NOT NULL,
	game_orgnizer_id INT NOT NULL,

	CONSTRAINT PK_Games PRIMARY KEY (games_id),
	CONSTRAINT CHK_Games_Season CHECK(season IN ('Summer','Winter')),
	CONSTRAINT CHK_game_year CHECK (game_year >= 1896),
	CONSTRAINT FK_Games_country_id FOREIGN KEY (game_country_id) REFERENCES Country(country_id),
	CONSTRAINT FK_Games_orgnizer_id FOREIGN KEY (game_orgnizer_id) REFERENCES orgnizer(orgnizer_id)

)