CREATE OR REPLACE trigger range_dist_compare
BEFORE INSERT OR UPDATE ON flights
FOR EACH ROW
DECLARE
	dist routes.distance % TYPE;
	range aircraft.cruisingrange % TYPE;

BEGIN
	SELECT air.cruisingrange INTO range FROM aircraft air WHERE air.aid = :NEW.aid;
	SELECT rou.distance INTO dist FROM routes rou WHERE rou.routeID = :NEW.rID;
	
	If range < dist
	Then
		raise_application_error(-20005,'ERROR : Aircraft is valid only when cruising range of flight is more than the distance of the route taken.');
	End If;
END;
/

REM The cruising range og Boeing 727 is 1504

REM correct insertion
INSERT INTO routes VALUES('PU100','Phoenix','Utah',1500);
INSERT INTO flights VALUES ('8P-2457','PU100',15);

REM Insert Violation
INSERT INTO routes VALUES('BU100','Boston','Utah',2570);
INSERT INTO flights VALUES ('UB-9776','BU100',15);

REM update violation
UPdate flights set aid =15 WHERE rID = 'LH106';

DROP trigger range_dist_compare;