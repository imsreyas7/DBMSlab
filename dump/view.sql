REM ********************************************************************
REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
REM 		EX : 4     VIEWS
REM 								
REM ********************************************************************



REM	1. Create a view Schedule_15 that display the flight number, route, airport(origin, destination) 
REM	departure (date, time), arrival (date, time) of a flight on 15 apr 2005. Label the view 
REM	column as flight, route, from_airport, to_airport, ddate, dtime, adate, atime respectively.

CREATE OR REPLACE VIEW Schedule_15 AS
SELECT  flightNo "FLIGHT", r.routeID "ROUTE", orig_airport "FROM_AIRPORT", dest_airport "TO_AIRPORT", departs "DDATE", dtime "DTIME", arrives "ADATE", atime "ATIME"
FROM    routes r, flights f, fl_schedule fl
WHERE   to_date('15-Apr-2005', 'DD-MON-YYYY') = departs
AND     f.rID = r.routeID AND fl.flno = f.flightNo;

SELECT *
FROM Schedule_15;

SAVEPOINT A;

INSERT INTO Schedule_15 VALUES  ('9E-9999'
                                ,'MD-150'
                                ,'Houston'
                                ,'Texas'
                                ,'15-04-05'
                                ,1130
                                ,'15-04-05'
                                ,1730
                                );

SELECT *
FROM Schedule_15;

UPDATE Schedule_15
SET flight = '9E-9998'
WHERE flight = 'HA-1' AND flight = '9E-3851';

UPDATE Schedule_15
SET route = 'MD144'
WHERE route = 'MD200' AND flight = '9E-3851';

UPDATE Schedule_15
SET from_airport = 'Texas'
WHERE flight = 'A5-3246' AND route = 'CN151' AND ddate = '15-APR-2005';

UPDATE Schedule_15
SET to_airport = 'Texas'
WHERE flight = 'A5-3246' AND flight = '9E-3851';

UPDATE Schedule_15
SET ddate = '18-APR-2005'
WHERE flight = 'A5-3246' AND ddate = '15-APR-2005';

UPDATE Schedule_15
SET dtime = 1820
WHERE flight = 'SQ-11';

UPDATE Schedule_15
SET adate = '18-APR-05'
WHERE flight = 'SQ-11';

UPDATE Schedule_15
SET atime = 1820
WHERE flight = 'SQ-11';

DELETE FROM Schedule_15
WHERE flight = 'SQ-11';

SELECT *
FROM Schedule_15;

SELECT  flightNo "FLIGHT", r.routeID "ROUTE", orig_airport "FROM_AIRPORT", dest_airport "TO_AIRPORT", departs "DDATE", dtime "DTIME", arrives "ADATE", atime "ATIME"
FROM    routes r, flights f, fl_schedule fl
WHERE   to_date('15-Apr-2005', 'DD-MON-YYYY') = departs
AND     f.rID = r.routeID AND fl.flno = f.flightNo;

ROLLBACK TO A;

REM Insertion cannot take place as the view is based on 3 joined tables
REM Updation works for some columns, which are mapped to a key preserved table.
REM Updatable columns : ddate, dtime, adate, atime.
REM Updation cannot take place on columns like to_airport which are mapped to a non-key preserved table.
REM Deletion occurs. Changes are reflected on the base tables also.

REM 2. Define a view Airtype that display the number of aircrafts for each of its type. Label the 
REM column as craft_type, total.

CREATE OR REPLACE VIEW Airtype AS
SELECT type "CRAFT_TYPE", COUNT(*) "TOTAL"
FROM   aircraft
GROUP BY type;

SELECT *
FROM Airtype;

SAVEPOINT B;

INSERT INTO Airtype VALUES  ('Spicejet'
                            ,null);

UPDATE Airtype
SET craft_type = 'Lockerseed'
WHERE craft_type = 'Lockheed';

UPDATE Airtype
SET total = 100
WHERE total = 3;

DELETE FROM Airtype
WHERE craft_type = 'Lockheed';

SELECT *
FROM Airtype;

ROLLBACK TO B;

REM Insertion cannot take place due to Virtual Column.
REM Updation cannot take place as data manipulation is illegal on this view (due to Group By based view)
REM Deletion cannot take place for the same reason as above.

REM 3. Create a view Losangeles_Route that contains Los Angeles in the route. Ensure that the view 
REM always contain/allows only information about the Los Angeles route

CREATE OR REPLACE VIEW LosAngeles_Route AS
SELECT  *
FROM    routes
WHERE   orig_airport = 'Los Angeles'
OR      dest_airport = 'Los Angeles'
WITH CHECK OPTION;

SELECT *
FROM LosAngeles_Route;

SAVEPOINT C;

INSERT INTO LosAngeles_Route VALUES ('LE066'
                                    ,'Los Angeles'
                                    ,'Houston'
                                    ,4200);

SELECT *
FROM routes
WHERE routeID = 'LE066';

INSERT INTO LosAngeles_Route VALUES ('LE420'
                                    ,'Boston'
                                    ,'Houston'
                                    ,4269);

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

ROLLBACK TO C;

REM Insertion is possible only if the conditions of the view (i.e. airport should be related to Los Angeles) is satisfied.
REM Insertion changes are reflected in base table.
REM Updation is possible. Changes are reflected in base table.
REM Updatable columns : routeID, orig_airport, dest_airport, distance.
REM Deletion is also possible. Changes are reflected in base table.

REM 4. Create a view named Losangeles_Flight on Schedule_15 (as defined in 1) that display flight, 
REM departure (date, time), arrival (date, time) of flight(s) from Los Angeles

CREATE OR REPLACE VIEW LosAngeles_Flight AS
SELECT flight, ddate, dtime, adate, atime
FROM   Schedule_15
WHERE  from_airport = 'Los Angeles';

SELECT *
FROM LosAngeles_Flight;

SAVEPOINT D;

INSERT INTO LosAngeles_Flight VALUES    ('HA-66'
                                        ,'16-04-05'
                                        ,1430
                                        ,'16-04-05'
                                        ,1840);

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

ROLLBACK TO D;

REM Insertion is not allowed as base view Schedule_15 comprises columns from more than 1 table.
REM Updation is carried out. Changes are reflected in the Schedule_15 view as well as base table Fl_Schedule
REM Updatable columns : ddate, dtime, adate, atime.
REM Deletion is carried out. Changes are reflected in the Schedule_15 view as well as base tables Fl_Schedule, Route and Flights

SELECT table_name, column_name, insertable
FROM user_updatable_columns
WHERE insertable = 'NO';

SELECT table_name, column_name, updatable
FROM user_updatable_columns
WHERE updatable = 'NO';