CREATE TABLE organizer (
    organizer_id    INT           IDENTITY (1, 1) NOT NULL,
    organizer_name  VARCHAR (100) NOT NULL,
    organizer_email VARCHAR (100) NOT NULL,
    CONSTRAINT PK_Organizer PRIMARY KEY (organizer_id),
    CONSTRAINT UQ_Organizer_Email UNIQUE (organizer_email)
);


GO
CREATE TABLE Event (
    event_id       INT           IDENTITY (1, 1) NOT NULL,
    event_date     DATE          CONSTRAINT DF_Event_Date DEFAULT getdate() NOT NULL,
    event_name     VARCHAR (100) NOT NULL,
    event_games_id INT           NOT NULL,
    event_sport_id INT           NOT NULL,
    CONSTRAINT PK_Event PRIMARY KEY (event_id),
    CONSTRAINT FK_Event_Games FOREIGN KEY (event_games_id) REFERENCES games (games_id),
    CONSTRAINT FK_Event_Sport FOREIGN KEY (event_sport_id) REFERENCES Sport (sport_id)
);