SET SERVEROUTPUT ON;

REM 1. Check whether the given pizza type is available. If not display appropriate message.

DECLARE
	ptype pizza.pizza_type % TYPE;
	p_id pizza.pizza_id % TYPE;
	pizza_type pizza.pizza_type % TYPE;
	u_price pizza.unit_price % TYPE;
    
    CURSOR p_select IS
		SELECT *
		FROM pizza
		WHERE pizza_type = ptype;

BEGIN
	ptype := '&ptype';
    
	OPEN p_select;
    
    FETCH p_select INTO p_id, pizza_type, u_price;

	IF p_select%ROWCOUNT = 0 THEN
		DBMS_OUTPUT.PUT_LINE('Pizza type: '||ptype||' is not available.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Pizza type: '||ptype||' is available.');
	END IF;

	CLOSE p_select;
END;
/

REM 2. For the given customer name and a range of order date, find whether a customer had
REM placed any order, if so display the number of orders placed by the customer along 
REM with the order number(s).

DECLARE
	no_of_orders NUMBER(3);
    order_id CHAR(5);
    c_name customer.cust_name % TYPE;
    start_date DATE;
    end_date DATE;
    
    CURSOR order_select IS
		SELECT order_no
		FROM orders, customer
		WHERE order_date BETWEEN start_date AND end_date
        AND customer.cust_id = orders.cust_id
        AND cust_name = c_name;

BEGIN
	c_name := '&c_name';
	start_date := '&start_date';
	end_date := '&end_date';
    
	OPEN order_select;
    
    FETCH order_select INTO order_id;
    
	IF order_select%FOUND = False THEN
		DBMS_OUTPUT.PUT_LINE('Customer '||c_name||' has not done any orders in this time period.');
	ELSE
        DBMS_OUTPUT.PUT_LINE('Orders:');
        WHILE order_select%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(order_id);
            FETCH order_select INTO order_id;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Customer '||c_name||' has done '||order_select%ROWCOUNT||' orders in this time period.');
        
	END IF;

	CLOSE order_select;
END;
/

REM 3. Display the customer name along with the details of pizza type and its quantity 
REM ordered for the given order number. Also find the total quantity ordered for the given
REM order number as shown below:

DECLARE
	no_of_orders NUMBER(3);
    order_id CHAR(5);
    c_name customer.cust_name % TYPE;
    p_type pizza.pizza_type % TYPE;
    qty order_list.qty % TYPE;
    
    CURSOR order_details IS
		SELECT pizza_type, qty
		FROM pizza, order_list
		WHERE order_no = order_id
        AND pizza.pizza_id = order_list.pizza_id;
    
    CURSOR person_details IS
        SELECT cust_name
        FROM customer, orders
        WHERE orders.cust_id = customer.cust_id
        AND orders.order_no = order_id;

BEGIN
	order_id := '&order_id';
    
    OPEN person_details;
    OPEN order_details;
    
    FETCH person_details INTO c_name;
    FETCH order_details INTO p_type, qty;
    
	IF person_details%FOUND = False THEN
		DBMS_OUTPUT.PUT_LINE('Specified order does not exist.');
	ELSE
        DBMS_OUTPUT.PUT_LINE('Customer Name: '||c_name||'.');
        DBMS_OUTPUT.PUT_LINE('Has ordered the following Pizza: ');
        DBMS_OUTPUT.PUT_LINE(RPAD('PIZZA TYPE', 13)||RPAD('QTY.', 4));
        WHILE order_details%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(p_type, 13)||RPAD(qty, 4));
            FETCH order_details INTO p_type, qty;
        END LOOP;
        
	END IF;

	CLOSE person_details;
	CLOSE order_details;
END;
/

REM 4. Display the total number of orders that contains one pizza type, two pizza type and 
REM so on.

DECLARE
	ptype_count NUMBER(3);
    counter NUMBER(3);
    max_count NUMBER(4);
    order_no orders.order_no % TYPE;
    
    CURSOR total_types IS
		SELECT COUNT(DISTINCT pizza_type)
		FROM pizza;
    
    CURSOR type_counter IS
        SELECT order_no
        FROM order_list
        GROUP BY order_no
        HAVING COUNT(order_no) = counter;

BEGIN
	counter := 0;
    OPEN total_types;
    
    FETCH total_types INTO max_count;
    
	IF max_count = 0 THEN
		DBMS_OUTPUT.PUT_LINE('Table: Pizza is Empty.');
	ELSE
        DBMS_OUTPUT.PUT_LINE('Number of Orders that contain: ');
        FOR COUNT IN 1..max_count LOOP
            ptype_count := 0;
            counter := counter + 1;
            OPEN type_counter;
            FETCH type_counter INTO order_no;
            WHILE type_counter%FOUND LOOP
                ptype_count := ptype_count + 1;
                FETCH type_counter INTO order_no;
            END LOOP;
            CLOSE type_counter;
            
            DBMS_OUTPUT.PUT_LINE(counter||' Pizza Type(s): '||ptype_count);
        END LOOP;
	END IF;

    CLOSE total_types;
END;
/

REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************


