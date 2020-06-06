/*
Name: Kim Phuong Tu	
ID#: 148886179
Date: Sep 26th, 2019
Purpose: DBS201 Lab 4 - FALL 2019
*/


-- -----------------------------------------------------------------------------------------------------------------------
-- Q1 	For all employees in France, display employee number, first name, last name, city, phone number and postal code
SELECT 
    employeeNumber, 
    firstName,
    lastName,
    city,
    phone,
    postalCode
FROM
    employees,
    offices
WHERE
    employees.officeCode = offices.officeCode
        AND UPPER(country) = 'FRANCE';

-- -----------------------------------------------------------------------------------------------------------------------
-- Q2a 	Create a view (vwCustomer_Order) to list all orders with the following data for all customers:
		-- Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order
DROP VIEW vwCustomerOrder;  -- just in case you make a mistake, then you can drop it to recreate it.
CREATE VIEW vwCustomerOrder AS (
    SELECT DISTINCT  c.customerNumber, o.orderNumber, orderDate, p.productName,p.quantityInStock,p.buyPrice
	FROM  customers AS c, orders AS o ,products AS p, orderdetails AS ord
    WHERE  c.customerNumber = o.customerNumber 
		AND o.orderNumber = ord.orderNumber
        AND ord.productCode = p.productCode
    
);
            
-- Q2b 	Write a statement to view the results of the view just created.        

		SELECT * FROM db_kptu.vwCustomerOrder;
-- -----------------------------------------------------------------------------------------------------------------------
-- Q3 	Using vwCustomerOrder (just created) display the information for customer number 124.  
		-- Sort the output based on order number and then order line number.

SELECT vw.*, o.orderLineNumber
FROM db_kptu.vwCustomerOrder AS vw JOIN orderdetails AS o
ON vw.orderNumber= o.orderNumber
WHERE vw.customerNumber='124'
ORDER BY orderNumber, orderLineNumber ;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q4	Display customer number, first name, last name, phone, and credit limits for all customers who do not have any orders.

SELECT c.customerNumber, contactFirstName, contactLastName, phone, creditLimit
FROM customers AS c
LEFT OUTER JOIN orders AS o
ON c.customerNumber= o.customerNumber
WHERE o.customerNumber IS NULL;

 

-- -----------------------------------------------------------------------------------------------------------------------
-- Q5	Create a view (vwEmployeeManager) to display all information of employees and the name and the last name of 
        -- their managers if there is any manager that the employee reports to. 


CREATE VIEW vwEmployeeManager AS (
    SELECT  e.employeeNumber,
			e.lastName,
			e.firstName,
			e.extension,
			e.email,
			e.officeCode,
			e.reportsTo,
			e.jobTitle,
			em.firstName AS 'managerFirstName',
			em.lastName AS 'managerLastName'
	FROM  employees AS e JOIN employees AS em
    ON  em.employeeNumber = e.reportsTo
	
    
);
-- -----------------------------------------------------------------------------------------------------------------------
-- Q6	Modify the employee_manager view so the view returns employee information for ALL employees who have a manager or not. 
		-- Do not DROP and recreate the view – modify it. (Google is your friend).
ALTER VIEW vwEmployeeManager AS (
    SELECT  e.employeeNumber,
			e.lastName,
			e.firstName,
			e.extension,
			e.email,
			e.officeCode,
			e.reportsTo,
			e.jobTitle,
			em.firstName AS 'managerFirstName',
			em.lastName AS 'managerLastName'
	FROM  employees AS e LEFT JOIN employees AS em
    ON  em.employeeNumber = e.reportsTo
	
    
);
-- -----------------------------------------------------------------------------------------------------------------------
-- Q7 	Drop both the 2 new views just created in the previous questions

DROP VIEW vwCustomerOrder, vwEmployeeManager;