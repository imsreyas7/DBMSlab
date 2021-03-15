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
--	The below SQL statements will populate the 
--	airlines database. The flight schedule contains
--	information pertained to flights during 12 to 22
--	April 2005. Do NOT MODIFY the instances.
--
--******************************************************
--


-- Populating Aircraft 
--aircraft(aid,	aname, type, cruisingrange)

INSERT INTO  aircraft VALUES (1,'Boeing 747-400','Boeing',8430);
INSERT INTO  aircraft VALUES (2,'Boeing 737-800','Boeing',3383);
INSERT INTO  aircraft VALUES (3,'Airbus A340-300','Airbus',7120);
INSERT INTO  aircraft VALUES (4,'British Aerospace Jetstream 41','BAe',1502);
INSERT INTO  aircraft VALUES (5,'Embraer ERJ-145','Embraer',1530);
INSERT INTO  aircraft VALUES (6,'SAAB 340','Saab',2128);
INSERT INTO  aircraft VALUES (7,'Piper PA-46 Meridian','Piper',520);
INSERT INTO  aircraft VALUES (8,'Tupolev Tu-154','Tupolev',4103);
INSERT INTO  aircraft VALUES (16,'Schweizer 2-33','Schweizer',300);
INSERT INTO  aircraft VALUES (9,'Lockheed L1011 Tristar','Lockheed',6900);
INSERT INTO  aircraft VALUES (10,'Boeing 757-300','Boeing',4010);
INSERT INTO  aircraft VALUES (11,'Boeing 777-300','Boeing',6441);
INSERT INTO  aircraft VALUES (12,'Boeing 767-400ER','Boeing',6475);
INSERT INTO  aircraft VALUES (13,'Airbus A320','Airbus',2605);
INSERT INTO  aircraft VALUES (14,'Airbus A319','Airbus',1805);
INSERT INTO  aircraft VALUES (15,'Boeing 727','Boeing',1504);


-- Populating employee relation
--employee(eid, ename, salary)

INSERT INTO  employee VALUES (242518965,'James Smith',120433);
INSERT INTO  employee VALUES (141582651,'Mary Johnson',178345);
INSERT INTO  employee VALUES (011564812,'John Williams',153972);
INSERT INTO  employee VALUES (567354612,'Lisa Walker',256481);
INSERT INTO  employee VALUES (552455318,'Larry West',101745);
INSERT INTO  employee VALUES (550156548,'Karen Scott',205187);
INSERT INTO  employee VALUES (390487451,'Lawrence Sperry',212156);
INSERT INTO  employee VALUES (274878974,'Michael Miller',99890);
INSERT INTO  employee VALUES (254099823,'Patricia Jones',24450);
INSERT INTO  employee VALUES (356187925,'Robert Brown',44740);
INSERT INTO  employee VALUES (355548984,'Angela Martinez',212156); 
INSERT INTO  employee VALUES (310454876,'Joseph Thompson',212156);
INSERT INTO  employee VALUES (489456522,'Linda Davis',127984);
INSERT INTO  employee VALUES (489221823,'Richard Jackson',23980);
INSERT INTO  employee VALUES (548977562,'William Ward',84476);
INSERT INTO  employee VALUES (310454877,'Chad Stewart',33546);
INSERT INTO  employee VALUES (142519864,'Betty Adams',227489);
INSERT INTO  employee VALUES (269734834,'George Wright',289950);
INSERT INTO  employee VALUES (287321212,'Michael Miller',48090);
INSERT INTO  employee VALUES (552455348,'Dorthy Lewis',92013);
INSERT INTO  employee VALUES (248965255,'Barbara Wilson',43723);
INSERT INTO  employee VALUES (159542516,'William Moore',48250);
INSERT INTO  employee VALUES (348121549,'Haywood Kelly',32899);
INSERT INTO  employee VALUES (090873519,'Elizabeth Taylor',32021);
INSERT INTO  employee VALUES (486512566,'David Anderson',743001);
INSERT INTO  employee VALUES (619023588,'Jennifer Thomas',54921);
INSERT INTO  employee VALUES (015645489,'Donald King',18050);
INSERT INTO  employee VALUES (556784565,'Mark Young',205187);
INSERT INTO  employee VALUES (573284895,'Eric Cooper',114323);
INSERT INTO  employee VALUES (574489456,'William Jones',105743);
INSERT INTO  employee VALUES (574489457,'Milo Brooks',12000);


-- Populating Certified relation
--certified(eid, aid)

INSERT INTO certified VALUES (567354612,1);
INSERT INTO certified VALUES (567354612,2);
INSERT INTO certified VALUES (567354612,10);
INSERT INTO certified VALUES (567354612,11);
INSERT INTO certified VALUES (567354612,12);
INSERT INTO certified VALUES (567354612,15);
INSERT INTO certified VALUES (567354612,7);
INSERT INTO certified VALUES (567354612,9);
INSERT INTO certified VALUES (567354612,3);
INSERT INTO certified VALUES (567354612,4);
INSERT INTO certified VALUES (567354612,5);
INSERT INTO certified VALUES (552455318,2);
INSERT INTO certified VALUES (552455318,14);
INSERT INTO certified VALUES (550156548,1);
INSERT INTO certified VALUES (550156548,12);
INSERT INTO certified VALUES (390487451,3);
INSERT INTO certified VALUES (390487451,13);
INSERT INTO certified VALUES (390487451,14);
INSERT INTO certified VALUES (274878974,10);
INSERT INTO certified VALUES (274878974,12);
INSERT INTO certified VALUES (355548984,8);
INSERT INTO certified VALUES (355548984,9);
INSERT INTO certified VALUES (310454876,8);
INSERT INTO certified VALUES (310454876,9);
INSERT INTO certified VALUES (548977562,7);
INSERT INTO certified VALUES (142519864,1);
INSERT INTO certified VALUES (142519864,11);
INSERT INTO certified VALUES (142519864,12);
INSERT INTO certified VALUES (142519864,10);
INSERT INTO certified VALUES (142519864,3);
INSERT INTO certified VALUES (142519864,2);
INSERT INTO certified VALUES (142519864,13);
INSERT INTO certified VALUES (142519864,7);
INSERT INTO certified VALUES (269734834,1);
INSERT INTO certified VALUES (269734834,2);
INSERT INTO certified VALUES (269734834,3);
INSERT INTO certified VALUES (269734834,4);
INSERT INTO certified VALUES (269734834,5);
INSERT INTO certified VALUES (269734834,6);
INSERT INTO certified VALUES (269734834,7);
INSERT INTO certified VALUES (269734834,8);
INSERT INTO certified VALUES (269734834,9);
INSERT INTO certified VALUES (269734834,10);
INSERT INTO certified VALUES (269734834,11);
INSERT INTO certified VALUES (269734834,12);
INSERT INTO certified VALUES (269734834,13);
INSERT INTO certified VALUES (269734834,14);
INSERT INTO certified VALUES (269734834,15);
INSERT INTO certified VALUES (552455318,7);
INSERT INTO certified VALUES (556784565,5);
INSERT INTO certified VALUES (556784565,2);
INSERT INTO certified VALUES (556784565,3);
INSERT INTO certified VALUES (573284895,3);
INSERT INTO certified VALUES (573284895,4);
INSERT INTO certified VALUES (573284895,5);
INSERT INTO certified VALUES (574489456,8);
INSERT INTO certified VALUES (574489456,6);
INSERT INTO certified VALUES (574489457,16);
INSERT INTO certified VALUES (287321212,7);
INSERT INTO certified VALUES (242518965,2);
INSERT INTO certified VALUES (242518965,10);
INSERT INTO certified VALUES (141582651,2);
INSERT INTO certified VALUES (141582651,10);
INSERT INTO certified VALUES (141582651,12);
INSERT INTO certified VALUES (011564812,2);
INSERT INTO certified VALUES (011564812,10);
INSERT INTO certified VALUES (356187925,6);
INSERT INTO certified VALUES (159542516,5);
INSERT INTO certified VALUES (159542516,7);
INSERT INTO certified VALUES (090873519,6);


-- Populating Routes relation
--routes(routeID, orig_airport,	dest_airport, distance)

INSERT INTO routes VALUES ('LW100','Los Angeles','Washington D.C.',2308);
INSERT INTO routes VALUES ('LC101','Los Angeles','Chicago',1749);
INSERT INTO routes VALUES ('LD102','Los Angeles','Dallas',1251);
INSERT INTO routes VALUES ('LB103','Los Angeles','Boston',2606);
INSERT INTO routes VALUES ('LS104','Los Angeles','Sydney',7487);
INSERT INTO routes VALUES ('LT105','Los Angeles','Tokyo',5478);
INSERT INTO routes VALUES ('LH106','Los Angeles','Honolulu',2551);
INSERT INTO routes VALUES ('CL150','Chicago','Los Angeles',1749);
INSERT INTO routes VALUES ('CN151','Chicago','New York',802);
INSERT INTO routes VALUES ('MD200','Madison','Detroit',319);
INSERT INTO routes VALUES ('DN250','Detroit','New York',470);
INSERT INTO routes VALUES ('DM251','Detroit','Montreal',517);
INSERT INTO routes VALUES ('MN204','Madison','New York',789);
INSERT INTO routes VALUES ('MC201','Madison','Chicago',150);
INSERT INTO routes VALUES ('MP202','Madison','Pittsburgh',510);
INSERT INTO routes VALUES ('MM203','Madison','Minneapolis',247);
INSERT INTO routes VALUES ('MNY300','Minneapolis','New York',991);
INSERT INTO routes VALUES ('PN350','Pittsburgh','New York',303);
INSERT INTO routes VALUES ('PC351','Pittsburgh','Chicago',409);
INSERT INTO routes VALUES ('NYL400','New York','London',3471);
INSERT INTO routes VALUES ('NYP401','New York','Paris',3631);
INSERT INTO routes values('LNY107','Los Angeles','New York',2510);


-- Populating Fligts relations
--flights(flightNo, rID, aid)

INSERT INTO flights VALUES ('9E-3749','DM251',4);
INSERT INTO flights VALUES ('MQ-4477','DN250',5);
INSERT INTO flights VALUES ('MQ-4565','DN250',5);
INSERT INTO flights VALUES ('CX-7520','LD102',4);
INSERT INTO flights VALUES ('WS-5060','LD102',5);
INSERT INTO flights VALUES ('QF-3045','LD102',15);
INSERT INTO flights VALUES ('JJ-7456','LW100',13);
INSERT INTO flights VALUES ('JJ-2482','LW100',13);
INSERT INTO flights VALUES ('SN-8814','LW100',2);
INSERT INTO flights VALUES ('WN-484','LC101',14);
INSERT INTO flights VALUES ('WN-434','LC101',13);
INSERT INTO flights VALUES ('B6-474','LB103',2);
INSERT INTO flights VALUES ('B6-482','LB103',2);
INSERT INTO flights VALUES ('VA-6551','LS104',1);
INSERT INTO flights VALUES ('VA-2','LS104',1);
INSERT INTO flights VALUES ('DJ-2','LS104',1);
INSERT INTO flights VALUES ('SQ-11','LT105',11);
INSERT INTO flights VALUES ('AI-7205','LT105',12);
INSERT INTO flights VALUES ('MH-93','LT105',11);
INSERT INTO flights VALUES ('HA-3','LH106',13);
INSERT INTO flights VALUES ('HA-1','LH106',13);
INSERT INTO flights VALUES ('UA-1428','LH106',2);
INSERT INTO flights VALUES ('A5-3376','CL150',14);
INSERT INTO flights VALUES ('A5-3246','CN151',4);
INSERT INTO flights VALUES ('9E-3851','MD200',5);
INSERT INTO flights VALUES ('9E-3622','MD200',4);
INSERT INTO flights VALUES ('G7-6205','MN204',4);
INSERT INTO flights VALUES ('EV-5134','MN204',15);
INSERT INTO flights VALUES ('RP-5018','MC201',16);
INSERT INTO flights VALUES ('G7-3664','MC201',5);
INSERT INTO flights VALUES ('FX-2351','MP202',7);
INSERT INTO flights VALUES ('AS-5958','MM203',16);
INSERT INTO flights VALUES ('AS-5062','MM203',7);
INSERT INTO flights VALUES ('DL-3402','PN350',15);
INSERT INTO flights VALUES ('CY-1846','NYL400',8);
INSERT INTO flights VALUES ('BA-178','NYL400',10);
INSERT INTO flights VALUES ('IB-4618','NYL400',9);
INSERT INTO flights VALUES ('VS-26','NYL400',8);
INSERT INTO flights VALUES ('AF-23','NYP401',10);
INSERT INTO flights VALUES ('AF-11','NYP401',10);
INSERT INTO flights VALUES ('RJ-7056','NYP401',8);
INSERT INTO flights values('AF-12','LNY107',10);


-- Populating Fl_schedule relation
--fl_schedule(flno, departs, dtime, arrives, atime, price)

INSERT INTO fl_schedule VALUES ('9E-3851','12-apr-2005',0710,'12-apr-2005',0800,120.40);
INSERT INTO fl_schedule VALUES ('CX-7520','12-apr-2005',0730,'12-apr-2005',0840,225.43);
INSERT INTO fl_schedule VALUES ('JJ-7456','12-apr-2005',0930,'12-apr-2005',1240,235.98);
INSERT INTO fl_schedule VALUES ('WS-5060','12-apr-2005',0930,'12-apr-2005',1042,227.60);
INSERT INTO fl_schedule VALUES ('AI-7205','12-apr-2005',1010,'13-apr-2005',1850,785.19);
INSERT INTO fl_schedule VALUES ('CY-1846','12-apr-2005',1040,'13-apr-2005',0920,250.50);
INSERT INTO fl_schedule VALUES ('DL-3402','12-apr-2005',1140,'12-apr-2005',1220,116.50);
INSERT INTO fl_schedule VALUES ('AS-5958','12-apr-2005',1210,'14-apr-2005',1300,220.15);
INSERT INTO fl_schedule VALUES ('QF-3045','12-apr-2005',1320,'12-apr-2005',1440,227.60);
INSERT INTO fl_schedule VALUES ('9E-3749','12-apr-2005',1940,'14-apr-2005',2020,170.40);
INSERT INTO fl_schedule VALUES ('G7-3664','13-apr-2005',0535,'13-apr-2005',0610,112.45);
INSERT INTO fl_schedule VALUES ('WN-484','13-apr-2005',0800,'13-apr-2005',0935,220.98);
INSERT INTO fl_schedule VALUES ('HA-3','13-apr-2005',1230,'13-apr-2005',1555,375.23);
INSERT INTO fl_schedule VALUES ('AS-5062','13-apr-2005',2010,'14-apr-2005',2100,120.11);
INSERT INTO fl_schedule VALUES ('VA-2','13-apr-2005',2030,'15-apr-2005',0430,1300.50);
INSERT INTO fl_schedule VALUES ('A5-3376','13-apr-2005',2030,'13-apr-2005',2150,220.98);
INSERT INTO fl_schedule VALUES ('FX-2351','14-apr-2005',0810,'14-apr-2005',0900,208.98);
INSERT INTO fl_schedule VALUES ('AF-23','14-apr-2005',1020,'15-apr-2005',1210,320.70);
INSERT INTO fl_schedule VALUES ('B6-474','14-apr-2005',1710,'14-apr-2005',2120,261.56);
INSERT INTO fl_schedule VALUES ('G7-6205','22-apr-2005',1725,'22-apr-2005',1850,202.34);
INSERT INTO fl_schedule VALUES ('VA-6551','14-apr-2005',2230,'16-apr-2005',0610,1278.56);
INSERT INTO fl_schedule VALUES ('9E-3851','15-apr-2005',1035,'15-apr-2005',1140,120.40);
INSERT INTO fl_schedule VALUES ('HA-1','15-apr-2005',1110,'15-apr-2005',1445,375.23);
INSERT INTO fl_schedule VALUES ('BA-178','15-apr-2005',1140,'16-apr-2005',1020,250.50);
INSERT INTO fl_schedule VALUES ('SQ-11','15-apr-2005',1230,'16-apr-2005',2055,780.99);
INSERT INTO fl_schedule VALUES ('JJ-2482','15-apr-2005',1230,'15-apr-2005',1540,235.98);
INSERT INTO fl_schedule VALUES ('MQ-4477','15-apr-2005',1510,'15-apr-2005',1600,180.56);
INSERT INTO fl_schedule VALUES ('A5-3246','15-apr-2005',1810,'15-apr-2005',1900,202.45);
INSERT INTO fl_schedule VALUES ('RP-5018','15-apr-2005',2100,'15-apr-2005',2155,225.45);
INSERT INTO fl_schedule VALUES ('WS-5060','16-apr-2005',0930,'16-apr-2005',1042,227.60);
INSERT INTO fl_schedule VALUES ('WN-484','16-apr-2005',0940,'16-apr-2005',1110,220.98);
INSERT INTO fl_schedule VALUES ('WN-434','16-apr-2005',1410,'16-apr-2005',1530,225.10);
INSERT INTO fl_schedule VALUES ('MH-93','17-apr-2005',0440,'18-apr-2005',1315,783.30);
INSERT INTO fl_schedule VALUES ('G7-3664','17-apr-2005',0725,'17-apr-2005',0815,112.45);
INSERT INTO fl_schedule VALUES ('CX-7520','17-apr-2005',0730,'17-apr-2005',0840,225.43);
INSERT INTO fl_schedule VALUES ('AF-11','17-apr-2005',1340,'18-apr-2005',1530,320.70);
INSERT INTO fl_schedule VALUES ('9E-3622','17-apr-2005',1655,'17-apr-2005',1750,118.40);
INSERT INTO fl_schedule VALUES ('EV-5134','17-apr-2005',2135,'17-apr-2005',2240,202.34);
INSERT INTO fl_schedule VALUES ('B6-482','18-apr-2005',0330,'18-apr-2005',0740,261.56);
INSERT INTO fl_schedule VALUES ('DL-3402','18-apr-2005',1140,'18-apr-2005',1220,116.50);
INSERT INTO fl_schedule VALUES ('IB-4618','18-apr-2005',1310,'19-apr-2005',1150,250.50);
INSERT INTO fl_schedule VALUES ('UA-1428','18-apr-2005',1420,'18-apr-2005',1740,425.38);
INSERT INTO fl_schedule VALUES ('MQ-4565','18-apr-2005',1810,'18-apr-2005',1900,180.56);
INSERT INTO fl_schedule VALUES ('JJ-7456','19-apr-2005',0930,'19-apr-2005',1240,235.98);
INSERT INTO fl_schedule VALUES ('WN-484','19-apr-2005',1000,'19-apr-2005',1120,220.98);
INSERT INTO fl_schedule VALUES ('QF-3045','19-apr-2005',1320,'19-apr-2005',1440,227.60);
INSERT INTO fl_schedule VALUES ('WS-5060','20-apr-2005',0930,'20-apr-2005',1042,227.60);
INSERT INTO fl_schedule VALUES ('RJ-7056','20-apr-2005',1810,'21-apr-2005',2020,320.70);
INSERT INTO fl_schedule VALUES ('FX-2351','21-apr-2005',0810,'21-apr-2005',0900,208.98);
INSERT INTO fl_schedule VALUES ('AF-23','21-apr-2005',1020,'22-apr-2005',1210,320.70);
INSERT INTO fl_schedule VALUES ('VS-26','21-apr-2005',1340,'22-apr-2005',1230,250.50);
INSERT INTO fl_schedule VALUES ('VA-6551','21-apr-2005',2230,'23-apr-2005',0610,1278.56);
INSERT INTO fl_schedule VALUES ('G7-3664','22-apr-2005',0535,'22-apr-2005',0610,112.45);
INSERT INTO fl_schedule VALUES ('CX-7520','22-apr-2005',0730,'22-apr-2005',0840,225.43);
INSERT INTO fl_schedule VALUES ('SN-8814','22-apr-2005',1030,'22-apr-2005',1335,245);
INSERT INTO fl_schedule VALUES ('WN-484','22-apr-2005',1200,'22-apr-2005',1325,220.98);
INSERT INTO fl_schedule VALUES ('JJ-2482','22-apr-2005',1230,'22-apr-2005',1540,235.98);
INSERT INTO fl_schedule VALUES ('WN-434','22-apr-2005',1540,'22-apr-2005',1700,225.10);
INSERT INTO fl_schedule VALUES ('B6-474','22-apr-2005',1710,'22-apr-2005',2120,261.56);
INSERT INTO fl_schedule VALUES ('A5-3246','22-apr-2005',1810,'22-apr-2005',1900,202.45);
INSERT INTO fl_schedule values('AF-12','22-apr-05',1245,'22-apr-05',1850,450.25);

--**************************END OF INSERT****************************
