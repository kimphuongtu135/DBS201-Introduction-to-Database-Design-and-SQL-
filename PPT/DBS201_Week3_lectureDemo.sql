/*
Name: Clint MacDonald
ID#: 900######
Date: Sept 19, 2019
Purpose: DBS201 Week 3 Lecture - SQL DML 
*/

SELECT * FROM customers;

SELECT * FROM customers
	WHERE City = 'Stavern';
    
SELECT * FROM customers
	ORDER BY contactLastName, contactFirstName;
    
SELECT customerName, contactFirstName, contactLastName, city
	FROM customers
    WHERE upper(city) = 'LONDON';
    
SELECT customerName, contactFirstName, contactLastName, city
	FROM customers
    WHERE lower(city) = 'london';  
    
SELECT customerName, contactFirstName, contactLastName, city
	FROM customers
    WHERE lower(city) = 'london' OR upper(city) = 'PARIS'; 
    
-- SELECT from multiple tables
SELECT 	orderNumber, 
		orderDate, 
		orders.customerNumber, 
		customerName, 
        contactFirstName, 
        contactlastName
	FROM orders, customers
    WHERE orders.customerNumber = customers.customerNumber
    ORDER BY customerNumber DESC, orderDate DESC;
    
-- ------------------------------------------
SELECT 	orderNumber, orderDate, 
		orders.customerNumber, 
		customerName, contactFirstName,contactlastName
	FROM orders, customers
    WHERE orders.customerNumber = customers.customerNumber
		AND orderDate >= '2005-01-01'
    ORDER BY customerNumber DESC, orderDate DESC;
    
SELECT customerName, productName
	FROM customers, orders, orderdetails, products
    WHERE customers.customerNumber = orders.customerNumber
			AND orders.orderNumber = orderdetails.orderNumber
            AND orderdetails.productCode = products.productCode;
            
SELECT DISTINCT customerName, productName
	FROM customers, orders, orderdetails, products
    WHERE customers.customerNumber = orders.customerNumber
			AND orders.orderNumber = orderdetails.orderNumber
            AND orderdetails.productCode = products.productCode;
            
SELECT city FROM customers;
SELECT DISTINCT city FROM customers;

CREATE VIEW vwCustomersOrderedProducts AS 
	SELECT DISTINCT customerName, productName
		FROM customers, orders, orderdetails, products
		WHERE customers.customerNumber = orders.customerNumber
			AND orders.orderNumber = orderdetails.orderNumber
            AND orderdetails.productCode = products.productCode
;

SELECT * FROM vwCustomersOrderedProducts;

DROP TABLE customers;