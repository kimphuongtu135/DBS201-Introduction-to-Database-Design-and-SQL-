-- --------------------
-- Name: Kim Phuong Tu
-- ID#: 148886179
-- Date: Oct 1st, 2019
-- DBS201 Lab05
-- --------------------


-- PART A (DDL):

-- Q1: Create table the following tables and their given constraints:
-- Q1 Answer:
CREATE TABLE L5_MOVIES (
  id 			int			 NOT NULL,
  title	 		varchar(35)  NOT NULL,
  year 			int		     NOT NULL,
  Director 		int     	 NOT NULL,
  score 		decimal(3,2) NOT NULL,
  CHECK			 (score BETWEEN 0 AND 5),
  PRIMARY KEY (id)
  );
 
  
 
CREATE TABLE L5_ACTORS (
  id 			int			 NOT NULL,
  firstName	 	varchar(20)  NOT NULL,
  lastName	 	varchar(30)  NOT NULL,
  PRIMARY KEY (id)
  );
  
  
  CREATE TABLE L5_CASTINGS (
  movieid 		int			 NOT NULL,
  actorid 		int			 NOT NULL,
  PRIMARY KEY (movieid,actorid),
  	FOREIGN KEY (movieid) REFERENCES L5_MOVIES(id),
   	FOREIGN KEY (actorid) REFERENCES L5_ACTORS(id) 
  );
  
  
  CREATE TABLE L5_DIRECTORS (
  id 			int			 NOT NULL,
  name		 	varchar(20)  NOT NULL,
  Lastname	 	varchar(30)  NOT NULL,
  PRIMARY KEY (id)
  );
  
  
-- Q2: Modify the movies table to create a foreign key constraint that refers to table directors. 
-- Q2 Answer:
 ALTER TABLE L5_MOVIES
	ADD CONSTRAINT id_fk 	FOREIGN KEY (Director)
									REFERENCES L5_DIRECTORS(id);
                                   
                                    
-- Q3: Modify the movies table to create a new constraint so the uniqueness of the movie title is guaranteed. 
-- Q3 Answer:
 ALTER TABLE L5_MOVIES
	ADD CONSTRAINT UQ_movietitle UNIQUE (title);
    
-- Q4: Write insert statements to add the following data to table directors and movies.
-- Q4 Answer:
INSERT INTO L5_DIRECTORS
VALUES 
		('1010', 'Rob', 'Minkoff'),
        ('1020', 'Bill', 'Condon'),
		('1050', 'Josh', 'Cooley'),
		('2010', 'Brad', 'Bird'),
		('3020', 'Lake', 'Bell');
        
        
        
INSERT INTO L5_MOVIES
VALUES 
		('100', 'The Lion King', '2019', '3020','3.50'),
        ('200', 'Beauty and the Beast', '2017', '1050','4.20'),	
        ('300', 'Toy Story 4', '2019', '1020','4.50'),
        ('400', 'Mission Impossible', '2018', '2010','5.00'),
        ('500', 'The Secret Life of Pets', '2016', '1010','3.90');
        
        
-- Q5: Write a SQL statement to remove all above tables. Is the order of tables important when removing? Why? 
-- Q5 Answer:
 DROP TABLE 			L5_CASTINGS,
						L5_ACTORS,
						L5_MOVIES,
						L5_DIRECTORS;
            
-- The order of tables is very important when removing because some data play as foreigner key in another table. It helps to link two tables together. Hence, we should delete the table keeping the primary key first, later on we can detele the remain table because it holds primary key from the previous table as foreigner key.


-- PART B (DML):

-- Q6:Create a new empty table employee2 exactly the same as table employees.
-- Q6 Answer:

CREATE TABLE employee2
AS(
SELECT * 
FROM employees
WHERE 1=0);

-- Q7: Modify table employee2 and add a new column username to this table. The value of this column is not required and does not have to be unique.
-- Q7 Answer:

ALTER TABLE employee2 
  
 ADD COLUMN username	varchar(30)	 ;
  
-- Q8:Insert all student data from the employees table into your new table employee2. 
-- Q8 Answer:
  INSERT INTO employee2(employeeNumber, lastName, firstName,extension,email,officeCode, reportsTo,jobTitle)
  SELECT *
  FROM employees;
  
-- Q9: In table employee2, write a SQL statement to change the first name and the last name of employee with ID 1002 to your name.  
-- Q9 Answer:  
  UPDATE employee2
  SET firstName='Kim Phuong',
	  lastName='Tu'
  WHERE employeeNumber=1002;
  
-- Q10:In table employee2, generate the email address for column username for each student by concatenating the first character of employee’s first name and the employee’s last name. For instance, the username of employee Peter Stone will be pstone. NOTE: the username is in all lower case letters
-- Q10 Answer:
SET SQL_SAFE_UPDATES=0;

UPDATE employee2 e
SET username= lower(CONCAT(SUBSTR(e.firstName,1,1),e.lastName));


-- Q11:In table employee2, remove all employees with office code 4. 
-- Q11 Answer: 
DELETE FROM employee2  
 WHERE officeCode= 4 ; 
  
-- Q12: Modify table employee2 and add a new column username to this table. The value of this column is not required and does not have to be unique.
-- Q12 Answer:
 DROP TABLE employee2;
  
  
