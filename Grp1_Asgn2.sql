--Contains table creation & insert Query - Group 1

USE master
GO
IF NOT EXISTS (
   SELECT name
FROM sys.databases
WHERE name = 'BTD210_Asg2_1'
)
CREATE DATABASE [BTD210_Asg2_1]
GO

---------------CREATE TABLE-----------------
USE [BTD210_Asg2_1]
BEGIN TRANSACTION

DROP TABLE IF EXISTS Booking_Flight;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Airline;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Traveler;
DROP TABLE IF EXISTS Airport;

CREATE TABLE Airline
(
    airline_code VARCHAR(3) PRIMARY KEY,
    airline_name VARCHAR(64) NOT NULL
)

CREATE TABLE Aircraft
(
    aircraft_code VARCHAR(3) PRIMARY KEY,
    aircraft_desc VARCHAR(225) NOT NULL,

)

CREATE TABLE Airport
(
    airport_code VARCHAR(3) PRIMARY KEY,
    airport_name VARCHAR(225),
    city VARCHAR(64) NOT NULL
)

CREATE TABLE Booking
(
    bookingID VARCHAR(8) PRIMARY KEY,
    bookedON DATE NOT NULL
)

CREATE TABLE Traveler
(
    traveler_id VARCHAR(3) PRIMARY KEY,
    traveler_Fname VARCHAR(64) NOT NULL,
    traveler_Lname VARCHAR(64) NOT NULL,
    meal_preference VARCHAR(64) NOT NULL,
    gender VARCHAR(8) NOT NULL
)

CREATE TABLE Ticket
(
    eticket_num VARCHAR(12) PRIMARY KEY,
    ticket_price INT NOT NULL,
    taxes_fees INT NOT NULL,
    bookingID VARCHAR(8) NOT NULL,
    traveler_id VARCHAR(3) NOT NULL,
    FOREIGN KEY (bookingID) REFERENCES Booking,
    FOREIGN KEY (traveler_id) REFERENCES Traveler
)

CREATE TABLE Flight
(
    flight_num VARCHAR(8) PRIMARY KEY,
    airline_code VARCHAR(3) NOT NULL,
    aircraft_code VARCHAR(3) NOT NULL,
    dep_airport_code VARCHAR(3) NOT NULL,
    arr_airport_code VARCHAR(3) NOT NULL,
    operatedBy VARCHAR(3) NOT NULL,
    FOREIGN KEY (operatedBy) REFERENCES Airline,
    FOREIGN KEY (airline_code) REFERENCES Airline,
    FOREIGN KEY (aircraft_code) REFERENCES Aircraft,
    FOREIGN KEY (dep_airport_code) REFERENCES Airport,
    FOREIGN KEY (arr_airport_code) REFERENCES Airport
)

CREATE TABLE Booking_Flight
(
    bookingID VARCHAR(8), 
    flight_num VARCHAR(8) NOT NULLS,
    dep_date DATE NOT NULL,
    dep_time TIME NOT NULL,
    arr_date DATE NOT NULL,
    arr_time TIME NOT NULL,
    FOREIGN KEY
(bookingID) REFERENCES Booking,
    FOREIGN KEY
(flight_num) REFERENCES Flight,
    PRIMARY KEY
(bookingID, flight_num)
)

COMMIT;

-------------------INSERT---------------------------
USE [BTD210_Asg2_1]
GO

-- insert airline
INSERT INTO Airline
    (airline_code, airline_name)
VALUES
    ('AF', 'Air France')

INSERT INTO Airline
    (airline_code, airline_name)
VALUES
    ('MEA', 'Middle East Airline')

-- insert aircraft
INSERT INTO Aircraft
    (aircraft_code, aircraft_desc)
VALUES('772', 'BOEING 777 285-305 STD SEATS')

INSERT INTO Aircraft
    (aircraft_code, aircraft_desc)
VALUES('332', 'AIRBUS INDUSTRIE JET 200-345 STD SEATS')

-- insert airport
INSERT INTO Airport
    (airport_code, airport_name, city)
VALUES('YYZ', 'Toronro Pearson Intl, Ontario', 'Toronro')

INSERT INTO Airport
    (airport_code, airport_name, city)
VALUES('CDG', 'Charles de Gaul', 'Paris')

INSERT INTO Airport
    (airport_code, airport_name, city)
VALUES('BEY', NULL, 'Beirut')

-- insert flight
INSERT INTO Flight
    (flight_num, airline_code, aircraft_code, dep_airport_code, arr_airport_code, operatedBy)
VALUES('AF393', 'AF', '772', 'YYZ', 'CDG', 'AF')

INSERT INTO Flight
    (flight_num, airline_code, aircraft_code, dep_airport_code, arr_airport_code, operatedBy)
VALUES('AF5106', 'AF', '332', 'CDG', 'BEY', 'MEA')

INSERT INTO Flight
    (flight_num, airline_code, aircraft_code, dep_airport_code, arr_airport_code, operatedBy)
VALUES('AF386', 'AF', '772', 'CDG', 'YYZ', 'AF')

-- insert booking
INSERT INTO Booking
    (bookingID, bookedON)
VALUES('56753365', '28-Jan-19')

INSERT INTO Booking
    (bookingID, bookedON)
VALUES('56753936', '25-Jan-19')

-- insert booking_flight
INSERT INTO Booking_Flight
    (bookingID, flight_num, dep_date, dep_time, arr_date, arr_time)
VALUES('56753365', 'AF393', '22-Jun-19', '21:20', '23-Jun-19', '10:50')

INSERT INTO Booking_Flight
    (bookingID, flight_num, dep_date, dep_time, arr_date, arr_time)
VALUES('56753365', 'AF5106', '23-Jun-19', '13:40', '23-Jun-19', '18:55')

INSERT INTO Booking_Flight
    (bookingID, flight_num, dep_date, dep_time, arr_date, arr_time)
VALUES('56753936', 'AF393', '22-Jun-19', '21:20', '23-Jun-19', '10:50')

INSERT INTO Booking_Flight
    (bookingID, flight_num, dep_date, dep_time, arr_date, arr_time)
VALUES('56753936', 'AF386', '17-JuL-19', '17:00', '17-JuL-19', '19:20')

-- insert Traveler
INSERT INTO Traveler
    (traveler_id, traveler_Fname, traveler_Lname, meal_preference, gender)
VALUES
    ('111', 'Andrew', 'Smith', 'Vegetarian', 'Male'),
    ('112', 'Mariam', 'Daoud', 'Halal', 'Female'),
    ('113', 'Yasmine', 'Ch', 'Vegetarian', 'Female'),
    ('114', 'Hasan', 'Ch', 'Halal', 'Male');

-- insert Ticket
INSERT INTO TICKET
    (eticket_num, bookingID, traveler_id, ticket_price, taxes_fees)
VALUES
    ('573480996631', '56753936', '111', 1200, 182),
    ('573480996619', '56753365', '112', 1353, 182),
    ('573480996620', '56753365', '113', 1142, 180),
    ('573480996621', '56753365', '114', 1142, 180);


------------------------Part III. Data Manipulation-----------------------------

--Q1
SELECT flight_num, f.airline_code, al.airline_name, f.aircraft_code, ac.aircraft_desc,
    f.dep_airport_code, dep.airport_name, f.arr_airport_code, arr.airport_name
FROM Flight f
    INNER JOIN Airline al ON f.airline_code = al.airline_code AND flight_num = 'AF393'
    INNER JOIN Aircraft ac ON f.aircraft_code = ac.aircraft_code
    INNER JOIN Airport dep ON f.dep_airport_code = dep.airport_code
    INNER JOIN Airport arr ON f.arr_airport_code = arr.airport_code

--Q2: Booking, Flight, Booking_Flight
SELECT Booking_Flight.bookingID, bookedON, Booking_Flight.flight_num, dep_airport_code, dep_date,
    dep_time, arr_airport_code, arr_date, arr_time
FROM Booking_Flight
    INNER JOIN Booking
    ON Booking_Flight.bookingID = Booking.bookingID
    INNER JOIN Flight
    ON Booking_Flight.flight_num = Flight.flight_num
WHERE Booking_Flight.bookingID = '56753365'
ORDER BY dep_date, dep_time

--Q3
SELECT Ti.bookingID, Ti.eticket_num, Tr.traveler_Fname, Tr.traveler_Lname
FROM Ticket Ti
    INNER JOIN Traveler Tr
    ON Ti.traveler_id = Tr.Traveler.ID
WHERE Ti.bookingID = '56753365'

--Q4
SELECT SUM(ticket_price + taxes_fees) AS "Total Cost"
FROM Ticket
WHERE bookingID = '56753365'

--Q5
SELECT bookingID, COUNT(eticket_num) AS #Tickets
FROM Ticket
GROUP BY bookingID

--Q6
SELECT bookingID, SUM(ticket_price + taxes_fees) AS "Total Fees"
FROM Ticket
GROUP BY bookingID

--Q7
SELECT bookingID AS "Booking ID", SUM(taxes_fees) AS "Total Fees"
From Ticket
GROUP BY bookingID
HAVING SUM(taxes_fees) > 1000

--Q8
CREATE VIEW bookingFees
AS
    SELECT bookingID AS Bookings,
        SUM(ticket_price + taxes_fees) AS "Total Fees"
    FROM Ticket
    GROUP BY bookingID

--Q9
SELECT *
FROM bookingFees
WHERE "Total Fees" > 1000 

