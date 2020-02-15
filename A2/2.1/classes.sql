DROP TABLE Classes;

CREATE TABLE Classes(
class VARCHAR2(20) CONSTRAINT pk PRIMARY KEY,
type VARCHAR2(2),
country VARCHAR2(20),
numguns NUMBER(3),
bore NUMBER(3),
displacement NUMBER(7)
);

INSERT INTO classes(class, type, country, numguns, bore, displacement) VALUES(
	'Bismark', 'bb', 'Germany', 8, 14, 32000
	);


INSERT INTO classes(class, type, country, numguns, bore, displacement) VALUES(
	'Iowa', 'bb', 'USA', 9, 16, 46000
	);



INSERT INTO classes VALUES(
	'Kongo', 'bc', 'Japan', 8, 15, 42000
	);

INSERT INTO classes VALUES(
	'North Carolina', 'bb', 'USA', 9, 16, 37000
	);

INSERT INTO classes VALUES(
	'Revenge', 'bb', 'Gt. Britain', 8, 15, 29000
	);

INSERT INTO classes VALUES(
	'Renown', 'bc', 'Gt. Britain', 6, 15, 32000
	);

SELECT * FROM Classes;

SAVEPOINT B1;

UPDATE classes SET displacement=34000 WHERE class='Bismark';

SELECT * FROM classes;

UPDATE classes SET displacement=displacement*1.1 WHERE numguns>8 OR bore>14;

SELECT * FROM classes;


DELETE FROM classes WHERE class='Kongo';

SELECT * FROM classes;

ROLLBACK TO B1;

SELECT * FROM classes;


COMMIT;


rem ********************************************************************************************

