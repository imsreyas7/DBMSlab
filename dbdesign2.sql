REM ************************************************************************************************************************************************************
REM M.Sriram
REM 18 5001 168
REM Department of Computer Science & Engg
REM SSN College of Engineering
REM UCS1412: Database Lab
REM Assignment 9A: Database Design using Normal Forms
REM ************************************************************************************************************************************************************

REM ===========================================================================================================================================================
REM Creating a table in 1 NF
REM COMPANY(empid, name, address, bdate, sex, salary, dno, dname, mgr_id, pno, pname, pdno, hrs)
REM ===========================================================================================================================================================

REM Primary Key : (empid, pid)

DROP TABLE COMPANY;

CREATE TABLE COMPANY(
    empid NUMBER,
    name VARCHAR(20),
    address VARCHAR(40),
    bdate DATE,
    sex CHAR(1),
    salary NUMBER,
    dno NUMBER,
    dname VARCHAR(20),
    mgr_id NUMBER,
    pno NUMBER,
    pname VARCHAR(20),
    pdno NUMBER,
    hrs NUMBER,
    CONSTRAINT company_pk PRIMARY KEY (empid, pno)
);


REM ******* TABLE POPULATION ********

INSERT INTO COMPANY VALUES(123456789,'John Smith','731 Fondren, Houston TX','09-jan-1965','M',30000,5,'Research',333445555,1,'ProductX',5,32);
INSERT INTO COMPANY VALUES(123456789,'John Smith','731 Fondren, Houston TX','09-jan-1965','M',30000,5,'Research',333445555,2,'ProductY',5,8);
INSERT INTO COMPANY VALUES(333445555,'Franklin Wong','638 Voss, Houston TX','08-dec-1955','M',40000,5,'Research',333445555,2,'ProductY',5,10);
INSERT INTO COMPANY VALUES(333445555,'Franklin Wong','638 Voss, Houston TX','08-dec-1955','M',40000,5,'Research',333445555,3,'ProductZ',5,10);
INSERT INTO COMPANY VALUES(333445555,'Franklin Wong','638 Voss, Houston TX','08-dec-1955','M',40000,5,'Research',333445555,10,'Computerization',4,10);
INSERT INTO COMPANY VALUES(333445555,'Franklin Wong','638 Voss, Houston TX','08-dec-1955','M',40000,5,'Research',333445555,20,'Reorganization',1,10);
INSERT INTO COMPANY VALUES(999887777,'Alicia Zelaya','3321 Castle, Spring TX','19-jan-1968','F',25000,4,'Administration',987654321,30,'Newbenefits',4,30);
INSERT INTO COMPANY VALUES(999887777,'Alicia Zelaya','3321 Castle, Spring TX','19-jan-1968','F',25000,4,'Administration',987654321,10,'Computerization',4,10);
INSERT INTO COMPANY VALUES(987654321,'Jennifer Wallace','291 Berry, Bellaire TX','20-jun-1941','F',43000,4,'Administration',987654321,30,'Newbenefits',4,20);
INSERT INTO COMPANY VALUES(987654321,'Jennifer Wallace','291 Berry, Bellaire TX','20-jun-1941','F',43000,4,'Administration',987654321,20,'Reorganization',4,10);
INSERT INTO COMPANY VALUES(666884444,'Ramesh Narayan','975 Fire Oak, Humble TX','15-sep-1962','M',38000,5,'Research',333445555,3,'ProductZ',5,40);
INSERT INTO COMPANY VALUES(453453453,'Joyce English','5631 Rice, Houston TX','31-jul-1972','F',25000,5,'Research',333445555,1,'ProductX',5,20);
INSERT INTO COMPANY VALUES(453453453,'Joyce English','5631 Rice, Houston TX','31-jul-1972','F',25000,5,'Research',333445555,2,'ProductY',5,20);
INSERT INTO COMPANY VALUES(987987987,'Ahmed Jabbar','980 Dallas, Houston TX','29-mar-1969','M',25000,4,'Administration',987654321,10,'Computerization',4,35);
INSERT INTO COMPANY VALUES(987987987,'Ahmed Jabbar','980 Dallas, Houston TX','29-mar-1969','M',25000,4,'Administration',987654321,30,'Newbenefits',4,5);
INSERT INTO COMPANY VALUES(888665555,'James Borg','450 Stone, Houston TX','10-nov-1937','M',55000,1,'Headquarters',888665555,20,'Reorganization',1,NULL);

REM ===========================================================================================================================================================
REM Creating a tables in  3NF
REM EMPLOYEES(empid, name, address, bdate, sex, salary) PRIMARY KEY: empid
REM PROJECT(pno, pname, pdno) PRIMARY KEY: pno
REM DEPARTMENT(dno, dname, mgr_id) PRIMARY KEY: dno
REM HOURS(empid, pno, hrs) PRIMARY KEY: (empid, pno)
REM ===========================================================================================================================================================

DROP TABLE DEPARTMENTS;
DROP TABLE EMPLOYEES;
DROP TABLE PROJECT;
DROP TABLE WORKING_HOURS;

CREATE TABLE DEPARTMENTS(
    dno NUMBER,
    dname VARCHAR(20),
    mgr_id NUMBER,
    CONSTRAINT dept_pk1 PRIMARY KEY (dno)
);

CREATE TABLE EMPLOYEES(
    empid NUMBER,
    name VARCHAR(20),
    address VARCHAR(40),
    bdate DATE,
    sex CHAR(1),
    salary NUMBER,
    dno NUMBER,
    CONSTRAINT EMPLOYEES_pk PRIMARY KEY (empid),
    CONSTRAINT dept_fk FOREIGN KEY (dno) REFERENCES DEPARTMENTS(dno)
);

CREATE TABLE PROJECT(
    pno NUMBER,
    pname VARCHAR(20),
    pdno NUMBER,
    CONSTRAINT project_pk PRIMARY KEY (pno)
);

CREATE TABLE WORKING_HOURS(
    empid NUMBER,
    pno NUMBER,
    hrs NUMBER,
    CONSTRAINT hrs_pk PRIMARY KEY (empid, pno)
);

REM ******* TABLE POPULATION ********

INSERT INTO DEPARTMENTS VALUES(5,'Research',333445555);
INSERT INTO DEPARTMENTS VALUES(4,'Administration',987654321);
INSERT INTO DEPARTMENTS VALUES(1,'Headquarters',888665555);

INSERT INTO EMPLOYEES VALUES(123456789,'John Smith','731 Fondren, Houston TX','09-jan-1965','M',30000,5);
INSERT INTO EMPLOYEES VALUES(333445555,'Franklin Wong','638 Voss, Houston TX','08-dec-1955','M',40000,5);
INSERT INTO EMPLOYEES VALUES(999887777,'Alicia Zelaya','3321 Castle, Spring TX','19-jan-1968','F',25000,4);
INSERT INTO EMPLOYEES VALUES(987654321,'Jennifer Wallace','291 Berry, Bellaire TX','20-jun-1941','F',43000,4);
INSERT INTO EMPLOYEES VALUES(666884444,'Ramesh Narayan','975 Fire Oak, Humble TX','15-sep-1962','M',38000,5);
INSERT INTO EMPLOYEES VALUES(453453453,'Joyce English','5631 Rice, Houston TX','31-jul-1972','F',25000,5);
INSERT INTO EMPLOYEES VALUES(987987987,'Ahmed Jabbar','980 Dallas, Houston TX','29-mar-1969','M',25000,4);
INSERT INTO EMPLOYEES VALUES(888665555,'James Borg','450 Stone, Houston TX','10-nov-1937','M',55000,1);

INSERT INTO PROJECT VALUES(1,'ProductX',5);
INSERT INTO PROJECT VALUES(2,'ProductY',5);
INSERT INTO PROJECT VALUES(3,'ProductY',5);
INSERT INTO PROJECT VALUES(10,'Computerization',4);
INSERT INTO PROJECT VALUES(20,'Reorganization',4);
INSERT INTO PROJECT VALUES(30,'Newbenefits',1);

INSERT INTO WORKING_HOURS VALUES(123456789,1,32);
INSERT INTO WORKING_HOURS VALUES(123456789,2,8);
INSERT INTO WORKING_HOURS VALUES(333445555,2,10);
INSERT INTO WORKING_HOURS VALUES(333445555,3,10);
INSERT INTO WORKING_HOURS VALUES(333445555,10,10);
INSERT INTO WORKING_HOURS VALUES(333445555,20,10);
INSERT INTO WORKING_HOURS VALUES(999887777,30,30);
INSERT INTO WORKING_HOURS VALUES(999887777,10,10);
INSERT INTO WORKING_HOURS VALUES(987654321,30,20);
INSERT INTO WORKING_HOURS VALUES(987654321,20,10);
INSERT INTO WORKING_HOURS VALUES(666884444,3,40);
INSERT INTO WORKING_HOURS VALUES(453453453,1,20);
INSERT INTO WORKING_HOURS VALUES(453453453,2,20);
INSERT INTO WORKING_HOURS VALUES(987987987,10,35);
INSERT INTO WORKING_HOURS VALUES(987987987,30,5);
INSERT INTO WORKING_HOURS VALUES(888665555,20,NULL);

REM ===========================================================================================================================================================
REM **** VERIFYING LOSSLESS JOIN PROPERTY *****
REM ===========================================================================================================================================================

REM *** 1NF TABLE ***

SELECT * 
FROM COMPANY;

REM *** 3NF TABLES JOINED USING NATURAL JOIN ***

SELECT *
FROM EMPLOYEES
NATURAL JOIN WORKING_HOURS
NATURAL JOIN DEPARTMENTS
NATURAL JOIN PROJECT;
