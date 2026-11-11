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
    CONSTRAINT PK_Country PRIMARY KEY (country_id),
    CONSTRAINT UQ_Country_Name UNIQUE (country_name)
);

CREATE TABLE Sport (
    sport_id INT IDENTITY(1,1) NOT NULL,
    sport_name VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Sport PRIMARY KEY (sport_id),
    CONSTRAINT UQ_Sport_Name UNIQUE (sport_name)
);

CREATE TABLE organizer (
    organizer_id INT IDENTITY(1,1) NOT NULL,
    organizer_name VARCHAR(100) NOT NULL,
    organizer_email VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Organizer PRIMARY KEY (organizer_id),
    CONSTRAINT UQ_Organizer_Email UNIQUE (organizer_email)
);

GO

CREATE TABLE games (
    games_id INT IDENTITY(1,1) NOT NULL,
    host_city VARCHAR(100) NOT NULL,
    season VARCHAR(20) NOT NULL CONSTRAINT DF_Games_Season DEFAULT 'Summer',
    game_year INT NOT NULL,
    game_country_id INT NOT NULL,
    game_organizer_id INT NOT NULL,
    CONSTRAINT PK_Games PRIMARY KEY (games_id),
    CONSTRAINT CHK_Games_Season CHECK (season IN ('Summer', 'Winter')),
    CONSTRAINT CHK_Games_Year CHECK (game_year >= 1896),
    CONSTRAINT FK_Games_Country FOREIGN KEY (game_country_id) REFERENCES Country(country_id),
    CONSTRAINT FK_Games_Organizer FOREIGN KEY (game_organizer_id) REFERENCES organizer(organizer_id)
);

CREATE TABLE Athlete (
    athlete_id INT IDENTITY(1,1) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    [weight] DECIMAL(5,2) NOT NULL,
    height DECIMAL(5,2) NOT NULL,
    Athlete_country_id INT NOT NULL,
    CONSTRAINT PK_Athlete PRIMARY KEY (athlete_id),
    CONSTRAINT CHK_Athlete_Gender CHECK (gender IN ('M', 'F')),
    CONSTRAINT CHK_Athlete_Weight CHECK ([weight] > 0),
    CONSTRAINT CHK_Athlete_Height CHECK (height > 0),
    CONSTRAINT FK_Athlete_Country FOREIGN KEY (Athlete_country_id) REFERENCES Country(country_id)
);
GO

CREATE TABLE Event (
    event_id INT IDENTITY(1,1) NOT NULL,
    event_date DATE NOT NULL CONSTRAINT DF_Event_Date DEFAULT GETDATE(),
    event_name VARCHAR(100) NOT NULL,
    event_games_id INT NOT NULL,
    event_sport_id INT NOT NULL,
    CONSTRAINT PK_Event PRIMARY KEY (event_id),
    CONSTRAINT FK_Event_Games FOREIGN KEY (event_games_id) REFERENCES games(games_id),
    CONSTRAINT FK_Event_Sport FOREIGN KEY (event_sport_id) REFERENCES Sport(sport_id)
);
GO

CREATE TABLE Participates_in (
    event_id INT NOT NULL,
    athlete_id INT NOT NULL,
    medals_won VARCHAR(20) NOT NULL CONSTRAINT DF_Participates_Medal DEFAULT 'None',
    CONSTRAINT PK_Participates_In PRIMARY KEY (event_id, athlete_id),
    CONSTRAINT CHK_Participates_Medal CHECK (medals_won IN ('Gold', 'Silver', 'Bronze', 'None')),
    CONSTRAINT FK_Participates_Event FOREIGN KEY (event_id) REFERENCES Event(event_id),
    CONSTRAINT FK_Participates_Athlete FOREIGN KEY (athlete_id) REFERENCES Athlete(athlete_id)
);
GO