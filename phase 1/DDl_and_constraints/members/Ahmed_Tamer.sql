-- Table 1: Country
CREATE TABLE Country (
    country_id   INT IDENTITY(1,1) NOT NULL,
    country_name VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Country PRIMARY KEY (country_id),
    CONSTRAINT UQ_Country_Name UNIQUE (country_name)
);

-- Table 2: Participates_in
CREATE TABLE Participates_in (
    event_id   INT NOT NULL,
    athlete_id INT NOT NULL,
    medals_won VARCHAR(20) NOT NULL
        CONSTRAINT DF_Participates_Medal DEFAULT 'None',
    CONSTRAINT PK_Participates_In PRIMARY KEY (event_id, athlete_id),
    CONSTRAINT CHK_Participates_Medal CHECK (medals_won IN ('Gold', 'Silver', 'Bronze', 'None')),
    CONSTRAINT FK_Participates_Event FOREIGN KEY (event_id)
        REFERENCES Event(event_id),
    CONSTRAINT FK_Participates_Athlete FOREIGN KEY (athlete_id)
        REFERENCES Athlete(athlete_id)
);
