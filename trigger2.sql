CREATE OR REPLACE TRIGGER cx7520_days
BEFORE INSERT OR UPDATE on fl_schedule
FOR EACH ROW 
DECLARE
	schedule CHAR(10);
CURSOR day_check is SELECT TO_CHAR (:NEW.departs,'DAY') FROM DUAL;
BEGIN
	OPEN day_check;
	FETCH day_check INTO schedule;
	IF (schedule not in ('TUESDAY','FRIDAY','SUNDAY') AND :NEW.flno='cx-7520')
	Then
		raise_application_error(-20004,'error: The flight cx-7520 is scheduled only on Tuesdays, Fridays and Sundays.');
	End if;
end;
/

REM correct insertion
INSERT INTO fl_schedule VALUES ('CX-7520','24-apr-20',0730,'25-apr-20',0840,225.43);

REM insertion violation
INSERT INTO fl_schedule VALUES ('CX-7520','25-apr-20',0730,'25-apr-20',0840,225.43);

REM correct update
UPDATE fl_schedule SET departs = '06-MAR-20' WHERE flno = 'CX-7520' AND departs = '12-APR-2005';

REM update violation
UPDATE fl_schedule SET departs = '04-MAR-20' WHERE flno = 'CX-7520' AND departs = '24-APR-20';

DROP trigger cx7520_days;