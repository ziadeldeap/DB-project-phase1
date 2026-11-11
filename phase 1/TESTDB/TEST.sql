USE OlympicsDB;
-- 1. Drop an existing constraint
ALTER TABLE Athlete DROP CONSTRAINT CHK_Athlete_Weight;

-- 2. Add the constraint back
ALTER TABLE Athlete ADD CONSTRAINT CHK_Athlete_Weight CHECK ([weight] > 0);

-- 3. Add a new column with a constraint to an existing table
ALTER TABLE Country ADD code CHAR(3) NULL CONSTRAINT UQ_Country_Code UNIQUE;

-- 4. Create a new table and relate it to an existing table
CREATE TABLE Coach (
    coach_id INT IDENTITY(1,1) NOT NULL,
    coach_name VARCHAR(100) NOT NULL,
    athlete_id INT NOT NULL,
    CONSTRAINT PK_Coach PRIMARY KEY (coach_id),
    CONSTRAINT FK_Coach_Athlete FOREIGN KEY (athlete_id) REFERENCES Athlete(athlete_id)
);