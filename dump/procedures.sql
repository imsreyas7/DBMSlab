REM ********************************************************************
REM	     UCS 1412 - DATABASE LAB | IV SEMESTER
REM	     EX : 6	PL/SQL - STORED PROCEDURES & FUNCTIONS
REM	                                  - Sreyas V 18 5001 162 CSE - C
REM ********************************************************************

REM	1. Write a stored function to display the total number of pizzas ordered by the given 
REM	order number.

CREATE OR REPLACE FUNCTION no_orders
(order_id IN orders.order_no % TYPE)
RETURN NUMBER IS

    no_of_orders NUMBER(4);

    CURSOR order_details IS
        SELECT SUM(qty)
        FROM order_list 
        WHERE order_no = order_id;
    
BEGIN

    no_of_orders := 0;
    OPEN order_details;

    FETCH order_details INTO no_of_orders;

    IF order_details % NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Order ID: '|| order_id ||' does not exist');
    END IF;

    CLOSE order_details;
    RETURN no_of_orders;

END;
/

SELECT  no_orders(o.order_no) AS no_orders  
FROM    orders o 
WHERE   order_no = 'OP100';

SELECT  qty
FROM    order_list 
WHERE   order_no = 'OP100';

SELECT  SUM(qty)
FROM    order_list
WHERE   order_no = 'OP100';

REM	2. Write a PL/SQL block to calculate the total amount, discount and billable amount 
REM	(Amount to be paid) as given below:
REM	For total amount > 2000 and total amount < 5000:  Discount=5% 
REM	For total amount > 5000 and total amount < 10000:  Discount=10% 
REM	For total amount > 10000:  Discount=20% 
REM	Calculate the billable amount (after the discount) and update the same in orders table.
REM	Bill Amount = Total – Discount.

CREATE OR REPLACE PROCEDURE calc_bill
(order_id IN orders.order_no % TYPE, 
total OUT orders.total_amt % TYPE) AS

    disc orders.discount % TYPE;
    disc_amt orders.total_amt % TYPE;
    billed_amt orders.bill_amt % TYPE;
    

    CURSOR order_finder IS
        SELECT  SUM(qty * unit_price)
        FROM    pizza, order_list
        WHERE   order_list.pizza_id = pizza.pizza_id
        AND     order_no = order_id;
    
    BEGIN
    
        total := 0;
        OPEN order_finder;
        
        FETCH order_finder INTO total;
        
        IF total IS NOT NULL THEN
        
            IF total > 10000 THEN
                disc := 0.20;
            ELSIF total > 5000 THEN
                disc := 0.10;
            ELSIF total > 2000 THEN
                disc := 0.05;
            ELSE
                disc := 0.0;
            END IF;
    
            disc_amt := disc * total;
            billed_amt := total - disc_amt;

            UPDATE orders
            SET total_amt = total,
                discount = disc,
                bill_amt = billed_amt
            WHERE order_no = order_id;

            DBMS_OUTPUT.PUT_LINE('Total Amount ' || LPAD(': $', 10) || total);
            DBMS_OUTPUT.PUT_LINE('Discount '|| LPAD(': ', 13) || (disc * 100) || '%');
            DBMS_OUTPUT.PUT_LINE('Discount Amount '|| LPAD(': $', 7) || disc_amt);
            DBMS_OUTPUT.PUT_LINE('Billable Amount '|| LPAD(': $', 7) || billed_amt);
        
            CLOSE order_finder;
        
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Order Number ' || order_id || ' does not exist.');
        END IF;
END;
/

DECLARE
    order_id VARCHAR2(10);
    total orders.total_amt % TYPE;
BEGIN
    order_id := '&order_id';
    calc_bill(order_id, total);
END;
/

SELECT  * 
FROM    orders
WHERE   order_no = 'OP100';

REM	3. For the given order number, write a PL/SQL block to print the order as shown below:
REM	Hint: Use the PL/SQL blocks created in 1 and 2. 

CREATE OR REPLACE PROCEDURE print_bill
(order_id IN orders.order_no % TYPE) AS

    order_no orders.order_no % TYPE;
    order_date orders.order_date % TYPE;
    cust_name customer.cust_name % TYPE;
    phone customer.phone % TYPE;
    pizza_type pizza.pizza_type % TYPE;
    qty order_list.qty % TYPE;
    unit_price pizza.unit_price % TYPE;
    total orders.total_amt % TYPE;
    s_no NUMBER(3);
    amount NUMBER(7);

    CURSOR order_details IS
        SELECT order_no, order_date, cust_name, phone
        FROM orders, customer
        WHERE orders.cust_id = customer.cust_id
        AND order_no = order_id;
    
    CURSOR pizza_details IS
        SELECT pizza_type, qty, unit_price
        FROM pizza, order_list
        WHERE pizza.pizza_id = order_list.pizza_id
        AND order_no = order_id;
    
BEGIN

    s_no := 0;
    OPEN order_details;

    FETCH order_details INTO order_no, order_date, cust_name, phone;
    
    IF order_details % FOUND THEN
        DBMS_OUTPUT.PUT_LINE('**************************************************************');
        DBMS_OUTPUT.PUT_LINE('Order Number: '|| order_no || LPAD('Customer Name: ', 20) || cust_name);
        DBMS_OUTPUT.PUT_LINE('Order Date : '|| order_date || CHR(9) || 'Phone: ' || phone);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');
        CLOSE order_details;
	
        DBMS_OUTPUT.PUT_LINE('S.No. ' || CHR(9) || 'Pizza Type' || CHR(9) || 'Qty.' || CHR(9) || 'Price' || CHR(9) || 'Amount');

        FOR record in pizza_details LOOP
            s_no := s_no + 1;
            amount := record.qty * record.unit_price;
            DBMS_OUTPUT.PUT_LINE(RPAD(s_no, 5) || CHR(9) || RPAD(record.pizza_type, 16) || LPAD(record.qty, 4) || LPAD(record.unit_price, 9) || LPAD(amount, 9));
        END LOOP;
    
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Total : ' || LPAD(no_orders(order_id), 20));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');
        
        calc_bill(order_id, total);
    
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Great Offers! Discount up to 25% on DIWALI Festival Day...');
        DBMS_OUTPUT.PUT_LINE('**************************************************************');
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('Order ID: ' || order_id || ' does not exist.');
    END IF;
END;
/

DECLARE
	order_id VARCHAR2(5);
BEGIN
	order_id := '&order_id';
	print_bill(order_id);	
END;
/

REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************