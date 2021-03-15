--*****************************************************
--CS 2258                               B.Senthil Kumar
--DBMS Lab				Asst. Prof
--	    		    Computer Science Department
--            		     SSN College of Engineering 
--	                   	     senthil@ssn.edu.in
--*****************************************************
-- 	          AIRLINES DATASET
--                 Version 1.0
--                February 05, 2013
--*****************************************************
--Sources:
--         This dataset is prepared for the assignment
--	on Subqueries and Join in SQL to students. This
--	is a test dataset.
--	The below SQL create the relations for airlines 
--	database with constraints.
--
--******************************************************

drop table fl_schedule;
drop table flights;
drop table routes;
drop table certified;
drop table employee;
drop table aircraft;

create table aircraft(
	aid number(4) constraint aid_pk primary key,
	aname varchar2(30),
	type varchar2(10),
	cruisingrange number(6)
	);

create table employee(
	eid number(9) constraint eid_pk primary key,
	ename varchar2(30),
	salary number(10,2)
	);

create table certified(
	eid number(9),
	aid number(4),
	constraint eaid_pk primary key(eid,aid),
	constraint eid_fk foreign key(eid) references employee,
	constraint aid_fk foreign key(aid) references aircraft
	);

create table routes(
	routeID varchar2(6) constraint rid_pk primary key,
	orig_airport varchar2(20),
	dest_airport varchar2(20),
	distance number(6)
	);

create table flights(
	flightNo varchar2(7) constraint fno_pk primary key,
	rID varchar2(6),
	aid number(4),
	constraint fl_aid_fk foreign key(aid) references aircraft,
	constraint rid_fk foreign key(rid) references routes
	);

create table fl_schedule(
	flno varchar2(7),
	departs date,
	dtime number(4),
	arrives date,
	atime number(4),
	price number(7,2),
	constraint fno_dep_pk primary key (flno,departs),
	constraint fno_fk foreign key(flno) references flights
	);

--********************END OF CREATE**********************************
