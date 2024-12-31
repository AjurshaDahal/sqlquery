-- Creating a database
CREATE DATABASE eventRegistration;

-- Using the newly created database
USE eventRegistration;

-- Creating tables for Company, Client, Policy, Agent, Agent_Client, and Claim

CREATE TABLE Participants (
    ParticipantID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Age INT,
    Gender VARCHAR(20),
    PRIMARY KEY (ParticipantID)
);



CREATE TABLE Events (
    EventID INT NOT NULL,
    EventName VARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(100),
    Organizer VARCHAR(100),
    PRIMARY KEY (EventID)
);

CREATE TABLE EventRegistrations (
    RegistrationID INT AUTO_INCREMENT,
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    PRIMARY KEY (RegistrationID),
    FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
      
);


-- Inserting data into the tables 
INSERT INTO Participants (ParticipantID, FirstName, LastName, Email, Phone, Age, Gender)  
VALUES 
(1, 'Sita', 'Shrestha', 'sita.shrestha@example.com', '9801234567', 24, 'Female'),
(2, 'Ram', 'Thapa', 'ram.thapa@example.com', '9812345678', 28, 'Male'),
(3, 'Gita', 'Khadka', 'gita.khadka@example.com', '9823456789', 26, 'Female'),
(4, 'Hari', 'Tamang', 'hari.tamang@example.com', '9845678901', 30, 'Male');


INSERT INTO Events (EventID, EventName, EventDate, Location, Organizer)  
VALUES 
(101, 'Dashain Mela', '2025-01-10', 'Kathmandu', 'Nepal Mela Samiti'),
(102, 'Tihar Rangoli Competition', '2025-02-15', 'Lalitpur', 'Art Nepal'),
(103, 'Buddha Jayanti Celebration', '2025-03-05', 'Lumbini', 'Buddha Foundation'),
(104, 'Shivaratri Cultural Event', '2025-04-05', 'Pashupatinath', 'Pashupati Trust');



INSERT INTO EventRegistrations (ParticipantID, EventID)  
VALUES 
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(1, 102),
(2, 103),
(3, 101),
(4, 101);

DESCRIBE Participants;
DESCRIBE Events;
DESCRIBE EventRegistrations;



-- Retrieving all data from tables
SELECT * FROM Participants;
SELECT * FROM Events;
SELECT * FROM EventRegistrations;

SELECT p.ParticipantID, p.FirstName, p.LastName, e.EventName, e.EventDate, e.Location
FROM Participants p
INNER JOIN EventRegistrations er ON p.ParticipantID = er.ParticipantID
INNER JOIN Events e ON er.EventID = e.EventID;


SELECT p.ParticipantID, p.FirstName, p.LastName, e.EventName, e.EventDate, e.Location
FROM Participants p
LEFT JOIN EventRegistrations er ON p.ParticipantID = er.ParticipantID
LEFT JOIN Events e ON er.EventID = e.EventID;



SELECT p.ParticipantID, p.FirstName, p.LastName, e.EventName, e.EventDate, e.Location
FROM Participants p
RIGHT JOIN EventRegistrations er ON p.ParticipantID = er.ParticipantID
RIGHT JOIN Events e ON er.EventID = e.EventID;



SELECT p.ParticipantID, p.FirstName, p.LastName, e.EventName, e.EventDate, e.Location
FROM Participants p
LEFT JOIN EventRegistrations er ON p.ParticipantID = er.ParticipantID
LEFT JOIN Events e ON er.EventID = e.EventID

UNION

SELECT p.ParticipantID, p.FirstName, p.LastName, e.EventName, e.EventDate, e.Location
FROM Participants p
RIGHT JOIN EventRegistrations er ON p.ParticipantID = er.ParticipantID
RIGHT JOIN Events e ON er.EventID = e.EventID;


SELECT p.ParticipantID, p.FirstName, p.LastName, e.EventName, e.EventDate, e.Location
FROM Participants p
CROSS JOIN Events e;

SELECT ParticipantID, FirstName, LastName
FROM Participants
WHERE ParticipantID NOT IN (SELECT ParticipantID FROM EventRegistrations);

SELECT p.FirstName, e.EventName
FROM Participants p
INNER JOIN EventRegistrations er ON p.ParticipantID = er.ParticipantID
INNER JOIN Events e ON er.EventID = e.EventID;


SELECT p.FirstName, p.LastName
FROM Participants p
INNER JOIN EventRegistrations er ON p.ParticipantID = er.ParticipantID

UNION

SELECT e.EventName, e.Location
FROM Events e;


CREATE TABLE EventRegistrations_UNNF (
    Participant_ID INT,
    Participant_Name VARCHAR(100),
    Events_Registered VARCHAR(255)
);

INSERT INTO EventRegistrations_UNNF (Participant_ID, Participant_Name, Events_Registered)
VALUES
(1, 'John Doe', 'Tech Conference, Science Expo'),
(2, 'Jane Smith', 'Tech Conference, Business Summit'),
(3, 'Alice Johnson', 'Science Expo, Business Summit');

select *from EventRegistrations_UNNF;


-- Create a new table for 1NF
CREATE TABLE EventRegistration1NF (
    ParticipantID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) NOT NULL,
    EventName VARCHAR(100),
    PRIMARY KEY (ParticipantID, EventName)
);

-- Inserting data into the 1NF table
INSERT INTO EventRegistration1NF (ParticipantID, FirstName, LastName, Email, EventName)
VALUES
(1, 'Sita', 'Shrestha', 'sita.shrestha@example.com', 'Dashain Mela'),
(1, 'Sita', 'Shrestha', 'sita.shrestha@example.com', 'Tihar Rangoli'),
(1, 'Sita', 'Shrestha', 'sita.shrestha@example.com', 'Buddha Jayanti'),
(2, 'Ram', 'Thapa', 'ram.thapa@example.com', 'Tihar Rangoli'),
(2, 'Ram', 'Thapa', 'ram.thapa@example.com', 'Buddha Jayanti'),
(3, 'Gita', 'Khadka', 'gita.khadka@example.com', 'Dashain Mela'),
(3, 'Gita', 'Khadka', 'gita.khadka@example.com', 'Buddha Jayanti'),
(4, 'Hari', 'Tamang', 'hari.tamang@example.com', 'Shivaratri Event'),
(4, 'Hari', 'Tamang', 'hari.tamang@example.com', 'Dashain Mela');

select * from EventRegistration1NF;

-- Create tables for 2NF
CREATE TABLE Participants_2NF (
    Participant_ID INT PRIMARY KEY,
    Participant_Name VARCHAR(100)
);

CREATE TABLE EventRegistrations_2NF (
    Participant_ID INT,
    Event_Name VARCHAR(100),
    FOREIGN KEY (Participant_ID) REFERENCES Participants_2NF(Participant_ID)
);

-- Insert Data into 2NF Tables
INSERT INTO Participants_2NF (Participant_ID, Participant_Name)
VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Alice Johnson');

INSERT INTO EventRegistrations_2NF (Participant_ID, Event_Name)
VALUES
(1, 'Tech Conference'),
(1, 'Science Expo'),
(2, 'Tech Conference'),
(2, 'Business Summit'),
(3, 'Science Expo'),
(3, 'Business Summit');

select * from Participants_2NF ;
select * from EventRegistrations_2NF;

-- Create tables for 3NF
CREATE TABLE Events_3NF (
    Event_Name VARCHAR(100) PRIMARY KEY,
    Event_Organizer VARCHAR(100)
);

-- Insert Data into Events_3NF Table
INSERT INTO Events_3NF (Event_Name, Event_Organizer)
VALUES
('Tech Conference', 'TechOrg'),
('Science Expo', 'ScienceOrg'),
('Business Summit', 'BusinessOrg');

-- Modify the EventRegistrations Table
CREATE TABLE EventRegistrations_3NF (
    Participant_ID INT,
    Event_Name VARCHAR(100),
    FOREIGN KEY (Participant_ID) REFERENCES Participants_2NF(Participant_ID),
    FOREIGN KEY (Event_Name) REFERENCES Events_3NF(Event_Name)
);

-- Insert Data into EventRegistrations_3NF Table
INSERT INTO EventRegistrations_3NF (Participant_ID, Event_Name)
VALUES
(1, 'Tech Conference'),
(1, 'Science Expo'),
(2, 'Tech Conference'),
(2, 'Business Summit'),
(3, 'Science Expo'),
(3, 'Business Summit');

select *from Events_3NF;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_error_case`()
BEGIN
    -- Start transaction
    START TRANSACTION;
    
    -- Deduct a registration (e.g., participant ID 1)
    UPDATE EventRegistrations_3NF
    SET Event_Name = 'Business Summit' 
    WHERE Participant_ID = 1;
    
    -- Error: Attempt to update a non-existing Participant (e.g., Participant_ID = 999)
    UPDATE EventRegistrations_3NF
    SET Event_Name = 'Tech Conference'
    WHERE Participant_ID = 999;  -- This will fail because Participant_ID = 999 doesn't exist
    
    -- End transaction (this will never be reached if there's an error)
    COMMIT;
END$$

DELIMITER ;

-- Call the procedure with error scenario
CALL transaction_error_case();
SELECT * FROM EventRegistrations_3NF;
 
 
-- delimeter
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_success`()
BEGIN
    -- Start transaction
    START TRANSACTION;
    
    -- Update participant 1's registration to 'Tech Conference'
    UPDATE EventRegistrations_3NF
    SET Event_Name = 'Tech Conference'
    WHERE Participant_ID = 1;
    
    -- Update participant 2's registration to 'Business Summit'
    UPDATE EventRegistrations_3NF
    SET Event_Name = 'Business Summit'
    WHERE Participant_ID = 2;
    
    -- Commit transaction
    COMMIT;
END$$

DELIMITER ;

-- Call the procedure with successful transactions (no rollback)
CALL transaction_success();
SELECT * FROM EventRegistrations_3NF;



DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaction_with_error_handling`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction on error
        ROLLBACK;
        SELECT 'Transaction failed, rollback executed' AS message;
    END;

    -- Start transaction
    START TRANSACTION;
    
    -- Deduct a registration for participant 1 (valid update)
    UPDATE EventRegistrations_3NF
    SET Event_Name = 'Tech Conference'
    WHERE Participant_ID = 1;
    
    -- Error simulation: Attempt to update a non-existing Participant (e.g., Participant_ID = 999)
    UPDATE EventRegistrations_3NF
    SET Event_Name = 'Business Summit'
    WHERE Participant_ID = 999;  -- This will fail because Participant_ID = 999 doesn't exist
    
    -- Commit transaction if no errors
    COMMIT;
    SELECT 'Transaction successful, changes committed' AS message;
END$$

DELIMITER ;

-- Call the procedure with error handling (rollback)
CALL transaction_with_error_handling();
SELECT * FROM EventRegistrations_3NF;


