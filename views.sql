-- Creating Database for Flight Schedule
SET ECHO OFF;
@v:/air_cre.sql
@v:/air_pop.sql
SET ECHO ON;
SET LINESIZE 1000;

-- ***********************************************************************************************
--	1. Create a view Schedule_15 that display the flight number, route, airport(origin, destination) 
--	   departure (date, time), arrival (date, time) of a flight on 15 apr 2005. Label the view 
--	   column as flight, route, from_airport, to_airport, ddate, dtime, adate, atime respectively.
-- ***********************************************************************************************

CREATE OR REPLACE VIEW Schedule_15 AS
SELECT  flightNo "FLIGHT", r.routeID "ROUTE", orig_airport "FROM_AIRPORT", dest_airport "TO_AIRPORT", departs "DDATE", dtime , arrives "ADATE", atime 
FROM    routes r, flights f, fl_schedule fl
WHERE   departs = '15-APR-2005'
AND     f.rID = r.routeID AND fl.flno = f.flightNo;

SELECT *
FROM Schedule_15;

SAVEPOINT Q1;

INSERT INTO Schedule_15 
VALUES  ('9E-9999','MD-150','Houston','Texas','15-04-05',1130,'15-04-05',1730);

SELECT *
FROM Schedule_15;

UPDATE Schedule_15
SET flight = '8K-9998'
WHERE flight = 'HA-1' AND flight = '9E-3851';

UPDATE Schedule_15
SET route = 'MD144'
WHERE route = 'MD200' AND flight = '9E-3851';

UPDATE Schedule_15
SET from_airport = 'Houston'
WHERE flight = 'A5-3246' AND route = 'CN151' AND ddate = '15-APR-2005';

UPDATE Schedule_15
SET to_airport = 'Texas'
WHERE flight = 'A5-3246' AND flight = '9E-3851';

UPDATE Schedule_15
SET ddate = '19-APR-2005'
WHERE flight = 'A5-3246' AND ddate = '15-APR-2005';

UPDATE Schedule_15
SET dtime = 1420
WHERE flight = 'SQ-11';

UPDATE Schedule_15
SET adate = '18-APR-05'
WHERE flight = 'SQ-11';

UPDATE Schedule_15
SET atime = 1830
WHERE flight = 'SQ-11';

DELETE FROM Schedule_15
WHERE flight = 'SQ-11';

SELECT *
FROM Schedule_15;

-- Checking if changes are reflected in base tables

SELECT  flightNo "FLIGHT", r.routeID "ROUTE", orig_airport "FROM_AIRPORT", dest_airport "TO_AIRPORT", departs "DDATE", dtime, arrives "ADATE", atime
FROM    routes r, flights f, fl_schedule fl
WHERE   departs = '15-Apr-2005'
AND     f.rID = r.routeID AND fl.flno = f.flightNo;

ROLLBACK TO Q1;

-- Insertion cannot take place as the view is based on 3 joined tables
-- Updation works for some columns: ddate, dtime, adate, atime.
-- Updation cannot take place on columns like to_airport which are mapped to a non-key preserved table.
-- Deletion is possible
-- Changes are reflected in the base tables.

-- ***********************************************************************************************
-- 2. Define a view Airtype that display the number of aircrafts for each of its type. Label the 
--    column as craft_type, total.
-- ***********************************************************************************************


CREATE OR REPLACE VIEW Airtype AS
    SELECT type "CRAFT_TYPE", COUNT(*) "TOTAL"
    FROM   aircraft
    GROUP BY type;

SELECT *
FROM Airtype;

SAVEPOINT Q2;

INSERT INTO Airtype VALUES  ('Spicejet',10);

UPDATE Airtype
SET craft_type = 'Locker123'
WHERE craft_type = 'Lockheed';

UPDATE Airtype
SET total = 25
WHERE total = 3;

DELETE FROM Airtype
WHERE craft_type = 'Lockheed';

SELECT *
FROM Airtype;

ROLLBACK TO Q2;

-- Insertion cannot take place due to Virtual Column.
-- Deletion & Updation cannot take place as data manipulation is illegal on this view (due to Group By based view)

-- ***********************************************************************************************
-- 3. Create a view Losangeles_Route that contains Los Angeles in the route. Ensure that the view 
--    always contain/allows only information about the Los Angeles route
-- ***********************************************************************************************

CREATE OR REPLACE VIEW LosAngeles_Route AS
    SELECT  *
    FROM    routes
    WHERE   orig_airport = 'Los Angeles'
    OR      dest_airport = 'Los Angeles'
WITH CHECK OPTION;

SELECT *
FROM LosAngeles_Route;

SAVEPOINT Q3;

INSERT INTO LosAngeles_Route VALUES ('LE066','Los Angeles','Houston',4200);

SELECT *
FROM routes
WHERE routeID = 'LE066';

INSERT INTO LosAngeles_Route VALUES ('LE420','Boston','Houston',4269);

SELECT *
FROM routes
WHERE routeID = 'LE066';

UPDATE LosAngeles_Route
SET routeID = 'LE069'
WHERE routeID = 'LE066';

UPDATE LosAngeles_Route
SET orig_airport = 'Texas'
WHERE routeID = 'LE069';

UPDATE LosAngeles_Route
SET orig_airport = 'Texas'
WHERE routeID = 'CL150';

UPDATE LosAngeles_Route
SET dest_airport = 'Texas'
WHERE routeID = 'LE069';

UPDATE LosAngeles_Route
SET distance = 1420
WHERE routeID = 'LE069';

DELETE FROM LosAngeles_Route
WHERE routeID = 'LE069';

SELECT *
FROM LosAngeles_Route;

SELECT  *
FROM    routes
WHERE   orig_airport = 'Los Angeles'
OR      dest_airport = 'Los Angeles';

-- Checking if changes are reflected in base tables

SELECT  *
FROM    routes
WHERE   orig_airport = 'Los Angeles'
OR      dest_airport = 'Los Angeles';


ROLLBACK TO Q3;

-- Insertion is possible only if the conditions of the view (i.e. dest or origin airport should be Los Angeles) is satisfied.
-- Updation works for some columns: routeID, orig_airport, dest_airport, distance.
-- Deletion is possible. 
-- All changes are reflected in base table.

-- ***********************************************************************************************
-- 4. Create a view named Losangeles_Flight on Schedule_15 (as defined in 1) that display flight, 
--    departure (date, time), arrival (date, time) of flight(s) from Los Angeles
-- ***********************************************************************************************

CREATE OR REPLACE VIEW LosAngeles_Flight AS
    SELECT flight, ddate, dtime, adate, atime
    FROM   Schedule_15
    WHERE  from_airport = 'Los Angeles';

SELECT *
FROM LosAngeles_Flight;

SAVEPOINT Q4;

INSERT INTO LosAngeles_Flight VALUES    ('HA-66','16-05-05',1650,'17-05-05',1840);

UPDATE LosAngeles_Flight
SET flight = 'HA-69'
WHERE flight = 'HA-1' AND ddate = '15-APR-2005';

UPDATE LosAngeles_Flight
SET ddate = '17-APR-05'
WHERE flight = 'HA-1';

SELECT * 
FROM fl_schedule 
WHERE flno = 'HA-1';

UPDATE LosAngeles_Flight
SET dtime = 1230
WHERE flight = 'SQ-11';

UPDATE LosAngeles_Flight
SET adate = '17-APR-05'
WHERE flight = 'SQ-11';

UPDATE LosAngeles_Flight
SET atime = 1430
WHERE flight = 'SQ-11';

SELECT *
FROM LosAngeles_Flight;

SELECT * 
FROM fl_schedule 
WHERE flno = 'SQ-11';

DELETE FROM LosAngeles_Flight
WHERE flight = 'SQ-11';

SELECT * 
FROM LosAngeles_Flight;

SELECT flight, ddate, dtime, adate, atime
FROM   Schedule_15
WHERE  from_airport = 'Los Angeles';

-- Checking if changes are reflected in base tables

SELECT flight, ddate, dtime, adate, atime
    FROM   Schedule_15
    WHERE  from_airport = 'Los Angeles';


ROLLBACK TO Q4;

-- Insertion is not possible as view comprises columns from more than one table
-- Updation works for some columns: ddate, dtime, adate, atime.
-- Deletion is possible. 
-- All changes are reflected in base table.

SELECT table_name, column_name, insertable
FROM user_updatable_columns
WHERE insertable = 'NO';

SELECT table_name, column_name, updatable
FROM user_updatable_columns
WHERE updatable = 'NO';