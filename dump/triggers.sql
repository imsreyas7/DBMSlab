CREATE OR REPLACE TRIGGER arr_dept_check 
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW 
WHEN (NEW.departs > NEW.arrives)
DECLARE
    ex_custom EXCEPTION;
BEGIN 
    RAISE ex_custom;
EXCEPTION
    WHEN ex_custom THEN
        RAISE_APPLICATION_ERROR(-20001,'Check arrival and departure dates'); 
END; 
/

CREATE OR REPLACE TRIGGER fl_check 
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW 
WHEN (EXTRACT(day FROM NEW.departs) NOT IN ('tue','fri','sun'))
DECLARE
    ex_custom EXCEPTION;
BEGIN 
    RAISE ex_custom;
EXCEPTION
    WHEN ex_custom THEN
        RAISE_APPLICATION_ERROR(-20001,'CHECK day of operation for CX­7520');
END; 
/

CREATE OR REPLACE TRIGGER dist_check 
BEFORE INSERT OR UPDATE ON flights
FOR EACH ROW
DECLARE
    CURSOR crus IS
    SELECT cruisingrange FROM aircraft WHERE aircraft.aid = :NEW.aid;
    CURSOR dist IS
    SELECT distance FROM routes WHERE routes.routeID = :NEW.rID;
    ex_custom EXCEPTION;
    d1 NUMBER;
    d2 NUMBER;
BEGIN
    OPEN crus;
    FETCH crus INTO d1;
    OPEN dist;
    FETCH dist INTO d2;
    IF d1 < d2 THEN
        RAISE ex_custom;
    END IF;
EXCEPTION
    WHEN ex_custom THEN
        RAISE_APPLICATION_ERROR(-20001,'CHECK cruising range if flight');
END; 
/