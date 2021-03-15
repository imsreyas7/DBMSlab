REM : 1. Display the flight number,departure date and time of a flight, its  route details and aircraft 
REM : name of type either Schweizer or Piper that departs during 8.00 PM AND 9.00 PM;

   SELECT f.flightno as flight_num,s.departs as depart_date,s.dtime as time,r.routeid as route_id,r.orig_airport as orig_airport,r.dest_airport as dest_airport,a.aname as aircraft_name
   FROM flights f 
   JOIN fl_schedule s ON(f.flightno = s.flno) 
   JOIN routes r ON(f.rid=r.routeid) 
   JOIN aircraft a ON (f.aid= a.aid)
   WHERE (a.type IN ('Schweizer','Piper')) AND (s.dtime BETWEEN 2000 AND 2100);

REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 2. For all the routes, display the flight number, origin and destination airport, if a flight is 
REM : assigned for that route.

   SELECT routeid,flightno,orig_airport,dest_airport
   FROM flights f 
   FULL OUTER JOIN routes r 
	ON(f.rid=r.routeid);


REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 3. For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the 
REM : average salary of all pilots certified for this aircraft.

   SELECT aname as Aircraft_Name,round(AVG(salary),-1) as AVG_emp_SAL
   FROM aircraft a 
   JOIN certified c USING (aid) 
   JOIN employee e USING (eid)
   WHERE cruisingrange > 5000
   GROUP BY aname;


REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 4. Show the employee details such as id, name and salary who are not pilots and whose salary 
REM : is more than the average salary of pilots.

    SELECT eid,ename,salary
    FROM employee e
    WHERE eid NOT IN (SELECT eid FROM certified c)
    AND salary >(SELECT AVG(salary) 
                        FROM employee JOIN certified
                        USING(eid));


REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 5. Find the id AND name of pilots who were certified to operate some aircrafts but at least one 
REM : of that aircraft is not scheduled from any routes.

   SELECT distinct eid,ename
   FROM employee e 
   JOIN certified c  USING (eid) 
   JOIN aircraft a USING (aid)
   WHERE aid NOT IN (SELECT f.aid FROM flights f);


REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 6. Display the origin AND destination of the flights having at least three departures with 
REM : maximum distance covered.

  SELECT orig_airport,dest_airport
  FROM routes 
  JOIN flights ON (rid=routeid)
  WHERE distance = (SELECT max(distance)
                    FROM routes
                    )
  GROUP BY orig_airport,dest_airport
  HAVING count(*) >= 3;

REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 7. Display name and salary of pilot whose salary is more than the average salary of any pilots 
REM : for each route other than flights originating from Madison airport.

SELECT distinct eid,ename,salary
FROM employee e 
JOIN certified c USING(eid) 
JOIN flights f USING(aid) 
JOIN routes r ON(f.rid=r.routeid)
WHERE e.salary > ANY(SELECT AVG(salary) 
               		 FROM employee e1 JOIN certified c1 USING(eid) JOIN flights f1 USING(aid) JOIN routes r1 ON(f1.rid=r1.routeid)
	               	 WHERE r1.routeid=r.routeid
	               	 AND orig_airport <> 'Madison'
	               	 GROUP BY(r1.routeid)
	            );


REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 8. Display the flight number, aircraft type, source and destination airport of the aircraft having 
REM : maximum number of flights to Honolulu;

SELECT	f.flightNo AS "FLIGHT NO.", a.type AS "AIRCRAFT TYPE", r.orig_airport AS "SRC. AIRPORT", r.dest_airport AS "DEST. AIRPORT"
FROM	flights f, aircraft a, routes r
WHERE	f.rID = r.routeID AND f.aid = a.aid
AND		r.dest_airport = 'Honolulu'
AND		f.aid =	(SELECT aid FROM	(SELECT f_outer.aid, COUNT(*) 
									FROM routes r, flights f_outer 
									WHERE r.dest_airport = 'Honolulu' AND r.routeID = f_outer.rID
									GROUP BY f_outer.aid
									ORDER BY COUNT(*) DESC) 
							WHERE rownum = 1);


REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM: 9. Display the pilot(s) who are certified exclusively to pilot all aircraft in a type.


SELECT * 
FROM employee 
WHERE eid IN (SELECT c.eid
			 FROM certified c JOIN aircraft a ON(c.aid=a.aid)
			 WHERE c.eid IN (SELECT c1.eid
							FROM certified c1 JOIN aircraft a1 ON(c1.aid=a1.aid)
							GROUP BY c1.eid
							HAVING(count(DISTINCT a1.type)) = 1
							)
			 GROUP BY c.eid,a.type
			 HAVING count(*) = (  SELECT count(a1.aid)
								 FROM aircraft a1 
								 WHERE a1.type = a.type
							   )
			);

REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM : 10) Name the employee(s) who is earning the maximum salary among the airport having 
REM : maximum number of departures

    SELECT distinct eid,ename,salary
    FROM employee e
    WHERE salary=(SELECT MAX(salary)
                  FROM employee e
                  JOIN certified c
                  USING(eid)
                  JOIN flights f
                  USING(aid)
    		  JOIN routes r
    		  ON(rid=r.routeid)
              	  GROUP BY(orig_airport)
                  HAVING orig_airport=(SELECT orig_airport
                                       FROM routes r JOIN flights f
                                       ON(routeid=rid)
                                       GROUP BY orig_airport
                                       HAVING count(*)=(SELECT MAX(count(*))
                					 FROM routes r JOIN flights f
                					 ON(routeid=rid)
                					 GROUP BY orig_airport)));

REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM 11. Display the departure chart as follows:
REM flight number, departure(date,airport,time), destination airport, arrival time, aircraft name
REM for the flights from New York airport during 15 to 19th April 2005. Make sure that the route
REM contains at least two flights in the above specified condition.
        
SELECT	f.flightNo												AS "FLIGHT NUMBER", 
		fl.departs || ' ' || r.orig_airport || ' ' || fl.dtime	AS "DEPARTURE",
		r.dest_airport 											AS "DEST. AIRPORT",
		fl.atime 												AS	"ARRIVAL TIME",
		a.aname 												AS "AIRCRAFT NAME"
FROM	flights f, fl_schedule fl, routes r, aircraft a
WHERE	f.flightNo = fl.flno AND r.routeID = f.rID AND f.aid = a.aid
AND		r.orig_airport = 'New York' AND	fl.departs BETWEEN TO_DATE('15/04/2005', 'DD/MM/YYYY') AND TO_DATE('19/04/2005', 'DD/MM/YYYY')
AND		r.routeID IN 	(SELECT r.routeID
						FROM	flights f, fl_schedule fl, routes r, aircraft a
						WHERE	f.flightNo = fl.flno AND r.routeID = f.rID AND f.aid = a.aid
						AND		r.orig_airport = 'New York' AND	fl.departs BETWEEN TO_DATE('15/04/2005', 'DD/MM/YYYY') AND TO_DATE('19/04/2005', 'DD/MM/YYYY')
						GROUP BY r.routeID
						HAVING COUNT(*) >= 2);





REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM Use SET operators (any one operator) for each of the following:

REM 12. A customer wants to travel from Madison to New York with no more than two changes of
REM flight. List the flight numbers from Madison if the customer wants to arrive in New York by
REM 6.50 p.m.

SELECT	f.flightNo	AS	"FLIGHT NUMBER"
FROM	flights f
WHERE	f.flightNo	IN( (SELECT		f0.flightNo
						FROM		flights f0, routes r, fl_schedule fl
						WHERE		r.routeID = f0.rID 					AND f0.flightNo = fl.flno
						AND			r.orig_airport = 'Madison' 			AND	r.dest_airport = 'New York'	AND fl.atime <= 1850)
						UNION
						(SELECT		f0.flightNo
						FROM		flights f0, flights f1, routes r0, routes r1, fl_schedule fl0, fl_schedule fl1 
						WHERE		r0.routeID = f0.rID					AND	f0.flightNo = fl0.flno
						AND 		r1.routeID = f1.rID					AND f1.flightNo = fl1.flno
						AND			r0.orig_airport = 'Madison'			AND r0.dest_airport <> 'New York'
						AND			r1.orig_airport = r0.dest_airport	AND	r1.dest_airport = 'New York' 
						AND 		fl1.atime <= 1850 					AND fl0.departs <= fl1.arrives)
					);


REM: ------------------------------------------------------------------------------------------------------------------------------------------------;

REM 13. Display the id and name of employee(s) who are not pilots.

SELECT	eid AS "EMPLOYEE ID", ename AS "EMPLOYEE NAME"	
		FROM	((SELECT * 
				FROM 	employee) 
				MINUS
				(SELECT e.* 
				FROM 	employee e, certified c WHERE e.eid = c.eid));