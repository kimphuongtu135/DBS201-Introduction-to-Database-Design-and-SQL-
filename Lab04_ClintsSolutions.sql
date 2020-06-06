/*
Name: Clint MacDonald
ID#: 900######
Date: Sept 23, 2019
Purpose: DBS201 Lab 4 - FALL 2019 SOLUTIONS
*/
-- -----------------------------------------------------------------------------------------------------------------------
-- Q1 	For all employees in France, display employee number, first name, last name, city, phone number and postal code
SELECT employeeNumber, firstname, lastname, city, phone || ' x' || extension AS WorkPhone, postalcode
	FROM employees, offices
    WHERE employees.officeCode = offices.officeCode AND lower(country) = 'france';

-- -----------------------------------------------------------------------------------------------------------------------
-- Q2a 	Create a view (vwCustomer_Order) to list all orders with the following data for all customers:
		-- Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order
DROP VIEW vwCustomerOrder;  -- just in case i make a mistake, then I can drop it to recreate it.

-- Solution using SIMPLE Joins
CREATE VIEW vwCustomerOrder AS
	SELECT c.CustomerNumber, o.orderNumber, orderDate, productName, quantityOrdered, priceEach
		FROM orders o, orderdetails od, products p, customers c
        WHERE o.ordernumber = od.ordernumber 
			AND od.productCode = p.productCode
            AND c.customerNumber = o.customerNumber;
        
	-- ALTERNATE AND BETTER SOLUTION using INNER JOINS    
CREATE VIEW vwCustomerOrder AS
	SELECT c.CustomerNumber, o.orderNumber, orderDate, productName, quantityOrdered, priceEach
		FROM orders o JOIN orderdetails od USING (ordernumber) 
			JOIN products p USING (productCode)
            JOIN customers c USING (customerNumber);
            
-- Q2b 	Write a statement to view the results of the view just created.        
SELECT * FROM vwCustomerOrder;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q3 	Using vwCustomerOrder (just created) display the information for customer number 124.  
		-- Sort the output based on order number and then order line number.

-- solution using SIMPLE join
SELECT customerNumber, orderLineNumber, v.orderNumber
	FROM vwCustomerOrder v, orderdetails od
    WHERE v.orderNumber = od.orderNumber 
        AND customerNumber = 124
    ORDER BY orderNumber, orderLineNumber;
    

    	-- ALTERNATE AND BETTER SOLUTION USING INNER JOIN
SELECT DISTINCT customerNumber, orderLineNumber, v.orderNumber
	FROM vwCustomerOrder v INNER JOIN orderdetails od ON v.orderNumber = od.orderNumber 
	WHERE customerNumber = 124
    ORDER BY orderNumber, orderLineNumber;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q4	Display customer number, first name, last name, phone, and credit limits for all customers who do not have any orders.
SELECT 	customerNumber,
		contactfirstname,
		contactLastName, 
        phone,
        creditlimit
	FROM customers LEFT JOIN orders USING (customerNumber) 
    WHERE orders.customerNumber IS NULL;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q5	Create a view (vwEmployeeManager) to display all information of employees and the name and the last name of 
		-- their managers if there is any manager that the employee reports to. 
CREATE VIEW vwEmployeeManager AS
	SELECT 	e.employeeNumber, e.lastname, e.firstname, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle,
			em.firstname AS managerFirst, em.lastname AS managerLast
		FROM employees AS e, employees AS em 
        WHERE e.reportsTo = em.employeeNumber;
SELECT * FROM vwEmployeeManager;

	-- ALTERNATIVE AND BETTER SOLUTION USING INNER JOINS
CREATE VIEW vwEmployeeManager AS
	SELECT 	e.employeeNumber, e.lastname, e.firstname, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle,
			em.firstname AS managerFirst, em.lastname AS managerLast
		FROM employees AS e INNER JOIN employees AS em ON e.reportsTo = em.employeeNumber;
SELECT * FROM vwEmployeeManager;
-- -----------------------------------------------------------------------------------------------------------------------
-- Q6	Modify the employee_manager view so the view returns employee information for ALL employees who have a manager or not. 
		-- Do not DROP and recreate the view – modify it. (Google is your friend).
CREATE OR REPLACE VIEW vwEmployeeManager AS
	SELECT 	e.employeeNumber, e.lastname, e.firstname, e.extension, e.email, e.officeCode, e.reportsTo, e.jobTitle,
			em.firstname AS managerFirst, em.lastname AS managerLast
		FROM employees AS e LEFT JOIN employees AS em ON e.reportsTo = em.employeeNumber;
SELECT * FROM vwEmployeeManager;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q7 	Drop both the 2 new views just created in the previous questions
DROP VIEW vwEmployeeManager;
DROP VIEW vwCustomerOrder
