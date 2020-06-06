-- --------------------
-- Name: Kim Phuong Tu
-- ID#: 148886179
-- Date: Sep 10th, 2019
-- DBS201 Lab01
-- --------------------


-- Q1: How many tables have been created? List the name ofcreated tables.
-- Q1 Answer:
/*
There is 8 tables that haven been created
1. customers
2. employees
3. offices
4. orderdetails
5. orders
6. payments
7. productlines
8. products
*/

-- Q2: How many rows arer selected from table customers?
-- Q2 Answer:
/*
There is 122 rows are selected from table customers.
*/

-- Q3:	What SQL statement is executed in the SQL tab after selecting Select Rows- Limit 1000. Write the statement in the space provided below.
-- Q3 Answer:
/*
SELECT * FROM db_kptu.customers limit 1000;
*/

-- Q4: How many columns does the customers table have? List the column names.
-- Q4 Answer:
/*
There is 13 columns in the customers table
1. customerNumber
2. customerName
3. contactLastName
4. contactFirstName
5. phone
6. addressLine1
7. addressLine2
8. city
9. state
10. postalcodeemployees
11. country
12. saleRepEmployeeNumber
13. creditLimit
*/


-- Q5: What is the value of each column in the first row in table customers? Write the column name and the column value.
-- Q5 Anwer:
/*
1. customerNumber   103
2. customerName     Atelier graphique
3. contactLastName  Schmitt 
4. contactFirstName Carine 
5. phone            40.32.2555
6. addressLine1     54, rue Royale
7. addressLine2     Null
8. city             Nantes
9. state            Null
10. postalcode      44000
11. country         France
12. saleRepEmployeeNumber  1370
13. creditLimit     21000.00
*/

-- Q6: Wrtie the number of rows and columns for the rest of tables in your schema.
-- Q6 Answer:
/*
Table Name            Rows           Columns
employees             23                8
offices               7                 9
orderdetails          1000              5
orders                326               7
payments              273               4
productlines          7                 4
products              110               9
*/

-- Q7: List the column names and types for table employees
-- Q7 Answer:
/*
Column Name                             Type
employeeNumber                          INT(11)
lastName                                VARCHAR(50)
firstName                               VARCHAR(50)
extension                               VARCHAR(10)
email                                   VARCHAR(100)
officeCode                              VARCHAR(10)
reportsTo                               INT(11)
jobTitle                                VARCHAR(50)
*/

-- Q8: What is the result of the statement exeecution?
-- Q8 Answer:
/*
There is a new table with 6 rows and 6 columns. This table has field, type, null, key, default, extra with the valid value .
*/
