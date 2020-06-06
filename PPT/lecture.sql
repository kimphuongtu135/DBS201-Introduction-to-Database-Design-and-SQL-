-- -------------------
-- Name: Kim Phuong Tu
-- ID#: 148886179
-- Date: Sep 10th, 2019
-- DBS201 Lab 01
-- -------------------


	
 
 -- SELECT FROM multiple table
 
-- -----------------------------------------------------
 SELECT orderNumber, orderDate, orders.customerNumber,	
		customerName, contactFirstName, contactLastName
	FROM orders, customers 
    WHERE orders.customerNumber = customers.customerNumber
    ORDER BY customerNumber DESC, orderDate DESC;
-- ----------------------------------------------------
  SELECT orderNumber, orderDate, orders.customerNumber,	
		customerName, contactFirstName, contactLastName
	FROM orders, customers 
    WHERE orders.customerNumber = customers.customerNumber
		AND orderDate >= '2005-01-01'
    ORDER BY customerNumber DESC, orderDate DESC;
    
   -- -------------------------------------------------
   SELECT   customerName,
			productName
	FROM  customers, orders, orderdetails, products 
    WHERE  customers.customerNumber = orders.customerNumber 
		AND orders.orderNumber = orderdetails.orderNumber
        AND orderdetails.productCode = products.productCode;
        
SELECT DISTINCT  customerName,
				productName
	FROM  customers, orders, orderdetails, products 
    WHERE  customers.customerNumber = orders.customerNumber 
		AND orders.orderNumber = orderdetails.orderNumber
        AND orderdetails.productCode = products.productCode;
    
    SELECT city FROM customers;
    SELECT DISTINCT city FROM customers;
    
CREATE VIEW vwCustomersOrderedProducts AS (
    SELECT DISTINCT  customerName, productName
	FROM  customers, orders, orderdetails, products 
    WHERE  customers.customerNumber = orders.customerNumber 
		AND orders.orderNumber = orderdetails.orderNumber
        AND orderdetails.productCode = products.productCode
    
);
-- Run view it means basing on the time we SQL
-- it saves only string ( no data)

SELECT * FROM vwCustomersOrderedProducts; 

DROP TABLE customers;
SELECT * FROM products 
	WHERE productName 
    LIKE '%Co%' OR '%cO%' OR '%co%' OR '%CO%';
    
   SELECT * FROM customers
	WHERE lower(contactFIrstName)
    LIKE 's%e%'; 


-- ----------------------- SEP 26, 2019
-- coutinued JOINS example
-- list all orders for each customers giving the customer name
 SELECT c.customerNumber,customerName, orderNumber orderDate,status
	FROM customers c JOIN orders o ON c.customerNumber=o.customerNumber
    ORDER BY c.customerNumber, orderDate DESC; 
    
    -- by default this is an INNER JOIN and therefore only records that
    -- have a match in the other table (both directions)alter
    -- we want to see ALL order in case the customer reference was lost

SELECT c.customerNumber,customerName, orderNumber orderDate,status
	FROM customers c RIGHT JOIN orders o ON c.customerNumber=o.customerNumber
    ORDER BY c.customerNumber, orderDate DESC;
    
    SELECT c.customerNumber,customerName, orderNumber orderDate,status
	FROM orders o LEFT JOIN customers c ON c.customerNumber=o.customerNumber
    ORDER BY c.customerNumber, orderDate DESC;
    
    -- What if we want to see ALL customers and ALL orders regardless
    -- FULL show both sides
    -- FULL just return match, and if not just return one column show no match
    -- CROSS will match and return everything
    SELECT c.customerNumber,customerName, orderNumber orderDate,status
	FROM orders o FULL JOIN customers c ON c.customerNumber=o.customerNumber
    ORDER BY c.customerNumber, orderDate DESC;
    
    
    /* NEW TOPIC
     DDL data Definition Language : chaning the structural object in data
     Constraints
		There are 7 base constrains
			Primary Key: unique identifier
            Foreign Key: relationship with PK
            Validation (Check): Data ranges, limit or permiited value
            Default Value: if null the use this value
     Data Dictionary----table
	Basic Data Types:
		Integers
        Decimal (precision,scale) // precision is how many spot you need for scale EXAMPLE 99.99 precision will be 5, -99.99 will be 6
     
    */
    
    -- Create a table
    CREATE TABLE w5_Teams(
    teamID		tinyint 	 primary key ,   -- don't need up to 255	
	teamName	varchar(20)  not null,
    shirtColor	varchar(15)	,				-- this is not required , can have null data 
    startDate	date
    );
    
    CREATE TABLE w5_players(
    playerID 	int,
    firstName	varchar(25) not null,
    lastName	varchar(30) not null,
    email 		varchar(100) not null unique,
    phoneNumber	bigint	not null check(phoneNumber BETWEEN 20000000000 AND 999999999),
    PRIMARY KEY (playerID)
    );
    
    CREATE TABLE w5_rosters(
    rosterID	int		primary key,
    teamID		tinyint	,				-- when you have foreigner key, it has to be identical with the table it belongs to
	playerID	int,
    shirtNumber	tinyint check(shirtNumber BETWEEN 0 AND 99),
    CONSTRAINT roster_team_fk	FOREIGN KEY (teamID) REFERENCES w5_Teams(teamID)
   );
   
   ALTER TABLE w5_roasters
	ADD CONSTRAINT roster_players_fk FOREIGN KEY (playerID)
									REFERENCES w5_players(playID);
    
    
    
    