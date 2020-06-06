/*
Name: 
ID#: 
Date: Sep 28th, 2019
Purpose: DBS201 Lab 4 - FALL 2019
*/


-- -----------------------------------------------------------------------------------------------------------------------
-- Q1 	For all employees in France, display employee number, first name, last name, city, phone number and postal code
SELECT 
    employeeNumber, firstName, lastName, city, phone, postalCode
FROM
    employees AS E, offices AS O
WHERE
    E.officeCode = O.officeCode
        AND LOWER(country) = 'france';

-- -----------------------------------------------------------------------------------------------------------------------
-- Q2a 	Create a view (vwCustomer_Order) to list all orders with the following data for all customers:
		-- Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order
DROP VIEW vwCustomerOrder;  -- just in case you make a mistake, then you can drop it to recreate it.
CREATE VIEW vwCustomerOrder AS (
    SELECT   C.customerNumber, OS.orderNumber, orderDate, PR.productName, PR.quantityInStock, PR.buyPrice
	FROM  customers AS C, orders AS OS ,products AS PR, orderdetails AS OD
    WHERE  C.customerNumber = OS.customerNumber 
		AND OS.orderNumber = OD.orderNumber
        AND OD.productCode = PR.productCode
    
);
            
-- Q2b 	Write a statement to view the results of the view just created.        

		SELECT *
        FROM db_lliang44.vwCustomerOrder;
-- -----------------------------------------------------------------------------------------------------------------------
-- Q3 	Using vwCustomerOrder (just created) display the information for customer number 124.  
		-- Sort the output based on order number and then order line number.

SELECT VW.*, OD.orderLineNumber
FROM db_lliang44.vwCustomerOrder AS VW  INNER JOIN orderdetails AS OD
ON VW.orderNumber= OD.orderNumber
WHERE VW.customerNumber= '124'
ORDER BY VW.orderNumber, OD.orderLineNumber ;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q4	Display customer number, first name, last name, phone, and credit limits for all customers who do not have any orders.

SELECT C.customerNumber, C.contactFirstName, C.contactLastName, C.phone, C.creditLimit
FROM customers AS C LEFT OUTER JOIN orders AS OD
ON C.customerNumber= OD.customerNumber
WHERE OD.customerNumber IS NULL;

 

-- -----------------------------------------------------------------------------------------------------------------------
-- Q5	Create a view (vwEmployeeManager) to display all information of employees and the name and the last name of 
        -- their managers if there is any manager that the employee reports to. 


CREATE VIEW vwEmployeeManager AS 
    SELECT  E.employeeNumber, E.lastName, E.firstName, E.extension, E.email, E.officeCode, E.reportsTo, E.jobTitle,
			EF.firstName AS managerFirstName,
			EF.lastName AS managerLastName
	FROM  employees AS E JOIN employees AS EF
    ON  E.reportsTo = EF.employeeNumber 
	
    
;
-- -----------------------------------------------------------------------------------------------------------------------
-- Q6	Modify the employee_manager view so the view returns employee information for ALL employees who have a manager or not. 
		-- Do not DROP and recreate the view – modify it. (Google is your friend).

	ALTER VIEW vwEmployeeManager AS 
    SELECT  E.employeeNumber, E.lastName, E.firstName, E.extension, E.email, E.officeCode, E.reportsTo, E.jobTitle,
			EF.firstName AS managerFirstName,
			EF.lastName AS managerLastName
	FROM  employees AS E LEFT OUTER JOIN employees AS EF
    ON  E.reportsTo = EF.employeeNumber 
	
    
;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q7 	Drop both the 2 new views just created in the previous questions

DROP VIEW vwCustomerOrder, vwEmployeeManager;