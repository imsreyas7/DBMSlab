CREATE OR REPLACE PROCEDURE find_net(e_id IN Employee.id % TYPE, basic_pay in Employee.basic % TYPE) IS

BEGIN
	UPDATE Employee
	SET basic = basic_pay,
	net = 1.64*basic_pay
	WHERE id = e_id;

	COMMIT;
END;
/ 