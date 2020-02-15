DROP TABLE Classes;

CREATE TABLE Classes(
class VARCHAR2(30),
type CHAR(2) CONSTRAINT type_c CHECK(type='bb' OR type='bc'),
country VARCHAR2(20),
numGuns NUMBER(3),
bore NUMBER(3),
displacement NUMBER(7));

INSERT INTO Classes(class,type,country,numGuns,bore,displacement)
VALUES('Bismark',
'bb',
'Germany',
8,
14,
32000);

INSERT INTO Classes(class,type,country,numGuns,bore,displacement)
VALUES('Iowa',
'bb',
'USA',
9,
16,
46000);

INSERT INTO Classes 
VALUES('North Carolina',
'bb',
'USA',
9,
15,
37000);

INSERT INTO Classes 
VALUES('Kongs',
'bc',
'Japan',
8,
15,
42000);

INSERT INTO Classes 
VALUES('Revenge',
'bb',
'Gt.Britain',
8,
15,
29000);

INSERT INTO Classes 
VALUES('Renown',
'bc',
'Gt.Britain',
6,
15,
32000);

SELECT * FROM Classes;

SAVEPOINT S1;

UPDATE Classes
SET displacement=45000
WHERE class='Bismark';

UPDATE Classes
SET displacement=1.1*displacement
Where(bore>=15 OR (type='bb' AND numGuns>=9));

DELETE FROM classes
WHERE class='kongs';

SELECT * FROM Classes;

ROLLBACK TO S1;

COMMIT;