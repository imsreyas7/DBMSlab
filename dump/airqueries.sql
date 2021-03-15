REM ********************************************************************
REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
REM 		EX : 3     ADVANCED	DML
REM 	
REM		SREYAS V	CSE - c		185001162
REM ********************************************************************

REM 1. Display the flight number,departure date and time of a flight, its route details and aircraft
REM name of type either Schweizer or Piper that departs during 8.00 PM and 9.00 PM.

SELECT	f.flightno as "FLIGHT NUMBER",
	s.departs AS "DEPARTURE DATE",
	S.dtime AS "DEPARTURE TIME",
	r.routeid AS "ROUTE ID",
	r.dest_airport	AS "DESTINATION",
	r.orig_airport AS "ORIG AIRPORT",
	r.distance AS "DISTANCE"
FROM 	flights f,fl_schedule s,routes r
WHERE	f.flightno = s.flno
AND	r.routeid = f.rid
AND	s.dtime BETWEEN 2000 AND 2100
AND	f.aid = ANY(	SELECT a.aid 
			FROM aircraft a
			WHERE a.type IN ('Schweizer' , 'Piper' ));

REM 2. For all the routes, display the flight number, origin and destination airport, if a flight is
REM assigned for that route.

SELECT	f.flightno AS "FLIGHT NUMBER",
	r.orig_airport AS "ORIG. AIRPORT",
	r.dest_airport AS "DEST. AIRPORT",
FROM	routes r
INNER JOIN flights f
ON	f.rid = r.routeid;
 
REM 3. For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the
REM average salary of all pilots certified for this aircraft.

SELECT	a.aname AS "AIRCRAFT NAME",
	avg(e.salary) AS "AVG.SALARY",
FROM	aircraft a, certified c, employee e
WHERE	a.aid = c.aid
AND	c.id=e.eid
AND	a.cruisingrange > 5000
GROUP BY a.aname;

REM 4. Show the employee details such as id, name and salary who are not pilots and whose salary
REM is more than the average salary of pilots.

SELECT	e.eid AS "EMPLOYEE ID",
	e.ename AS "EMPLOYEE NAME",
	e.salary AS "SALARY"
FROM 	employee e
LEFT JOIN certified c
ON	e.eid=c.eid
WHERE	c.eid IS NULL
AND	e.salary(	SELECT AVG(emp.salary)
			FROM employee e, certified ct
			WHERE emp.eid = ct.eid);

REM 5. Find the id and name of pilots who were certified to operate some aircrafts but at least one
REM of that aircraft is not scheduled from any routes.

SELECT	e.eid AS "EMPLOYEE ID",
	e.ename AS "EMPLOYEE NAME",
FROM	employee e,certified c
WHERE	e.eid=c.eid
AND 	c.aid IN (	SELECT c.aid
			FROM certified c
			LEFT JOIN flights f
			ON f.aid=c.aid
			WHERE f.rid IS NOT NULL);

6. Display the origin and destination of the flights having at least three departures with
maximum distance covered.

SELECT	orig_airport "ORIGIN AIRPORT",
	dest_airport "DESTINATION"
FROM	(SELECT     r.orig_airport, r.dest_airport, COUNT(fl.departs)
    	FROM        routes	r, flights f, fl_schedule fl
        WHERE       r.routeID = f.rID AND fl.flno = f.flightNo
        AND         r.distance  =   (SELECT MAX(r.distance) 
                                    FROM routes r)
    	GROUP BY    r.orig_airport, r.dest_airport
    	HAVING      COUNT(fl.departs) >= 3);	 