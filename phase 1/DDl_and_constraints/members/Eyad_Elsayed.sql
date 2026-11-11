create table games(
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
)

create table sport(
	sport_id INT IDENTITY(1,1) NOT NULL,
	sport_name VARCHAR(100) NOT NULL,
	CONSTRAINT PK_Sport PRIMARY KEY (sport_id),
	CONSTRAINT UQ_Sport_Name UNIQUE (sport_name)
)

create table Athlete(
	athlete_id INT IDENTITY(1,1) NOT NULL,
	full_name VARCHAR(100) NOT NULL,
	gender	CHAR(1) NOT NULL,
	[weight] DECIMAL(5,2) NOT NULL,
	height DECIMAL(5,2) NOT NULL,
	Athlete_country_id INT NOT NULL,
	CONSTRAINT PK_Athlete PRIMARY KEY (athlete_id),
	CONSTRAINT CHK_Athlete_Gender CHECK (gender IN ('M', 'F')),
	CONSTRAINT CHK_Athlete_Weight CHECK ([weight] > 0),
	CONSTRAINT CHK_Athlete_Height CHECK (height > 0),
	CONSTRAINT FK_Athlete_Country FOREIGN KEY (Athlete_country_id) REFERENCES Country(country_id)
)