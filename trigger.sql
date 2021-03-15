CREATE OR REPLACE TRIGGER befdate
BEFORE INSERT OR UPDATE ON fl_schedule
FOR EACH ROW
BEGIN
	if :NEW.arrives < :OLD.departs or :NEW.departs > :OLD.arrives or :NEW.arrives < :NEW.departs 
	Then
	If Inserting or Updating then
		raise_application_error(-20003,'ERROR : Date of arrival should not be before the date of departure');
	End If;
	Else
		dbms_output.put_line('Inserted');
	End If;
End;
/
REM insertion violation
INSERT INTO fl_schedule VALUES ('BA-178','13-apr-2005',0730,'12-apr-2005',0840,225.43);
REM proper insertion
INSERT INTO fl_schedule VALUES ('BA-178','12-apr-2005',0730,'13-apr-2005',0840,225.43);
SELECT * FROM fl_schedule where flno = 'BA-178';
REM proper update
UPDATE fl_schedule SET arrives = '14-APR-2005' WHERE flno = 'BA-178' AND departs = '12-APR-2005';
REM update violation
UPDATE fl_schedule SET arrives = '11-APR-2005' WHERE flno = 'BA-178' AND departs = '12-APR-2005';

DROP trigger befdate;


