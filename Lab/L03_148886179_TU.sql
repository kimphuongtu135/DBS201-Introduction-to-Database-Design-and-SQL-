-- -------------------
-- Name: Kim Phuong Tu
-- ID#: 148886179
-- Date: Sep 17th, 2019
-- DBS201 Lab 03
-- -------------------

-- Q1: Display the information of all offices.
-- Q1 Answer:

/*
SELECT * FROM offices;
*/

-- Q2: Display the employee number all employees whose office code is officeCode is 1.
-- Q2 Answer:

/*
SELECT employeeNumber
	FROM employees 
    WHERE officeCode = 1;
*/


-- Q3: Display the customer number, customer name, contact first name and contact last name, and phone for all customers in Paris.
-- Q3 Answer:

/*
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
	FROM customers 
	WHERE upper(city) = 'PARIS';
*/

-- Q4: Display the customer number for customers who have payments
-- Q4 Answer:

/*
SELECT customerNumber
	FROM payments;
	
*/

-- Q5: List customer numbers, check number, and amount for customers whose payment amount is not in the range of $30,000 to $65,000. Sort the output by top payments amount first.
-- Q5 Answer:


/*
SELECT customerNumber, checkNumber, amount 
 FROM  payments 
 WHERE  amount 
 NOT BETWEEN 30000 AND 65000 
 ORDER BY amount;
 
*/

-- Q6: Display the order information for all orders that are cancelled. 
-- Q6 Answer:

/*
SELECT * FROM orders 
	WHERE upper (status) ='CANCELLED';
*/


-- Q7: Display the information of all products with string ‘co’ in their product name. (c and o can be lower or upper case).
-- Q7 Answer:

/*
 SELECT * FROM products 
	WHERE lower(productName)
    LIKE '%co%';
*/

-- Q8: Display all customers whose contact first name starts with letter s (both lowercase and uppercase) and includes letter e (both lowercase and uppercase).
-- Q8 Answer:

/*
 SELECT * FROM customers
	WHERE lower(contactFIrstName)
    LIKE 's%e%'; 
*/

