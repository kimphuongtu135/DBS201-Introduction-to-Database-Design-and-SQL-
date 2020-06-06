/*
Name: Clint MacDonald
ID#: 900######
Date: Sept 25, 2019
Purpose: DBS201 Lab 5 - FALL 2019 SOLUTIONS
*/
-- -----------------------------------------------------------------------------------------------------------------------
-- Q1 Create table as shown on lab handout
CREATE TABLE L5_movies (
	Id 			int 			Primary Key,
    title 		varchar(35)		not null,
    year		int				not null,
    director	int				not null,
    score		decimal(3,2) 	check(score between 0 AND 5)
	);

CREATE TABLE L5_actors (
	Id			int				Primary Key,
    firstName	varchar(20)		not null,
    lastName	varchar(30)		not null
    );
    
CREATE TABLE L5_castings (
	movieID		int, 
	actorID		int,
    Primary Key (movieID, actorID)
    );
    
CREATE TABLE L5_directors (
	Id			int,
    firstName	varchar(20)		not null,
    lastName	varchar(30)		not null,
    Primary Key (Id)
    );
    
-- -----------------------------------------------------------------------------------------------------------------------
-- Q2
ALTER TABLE L5_movies
	ADD CONSTRAINT movie_directors_fk FOREIGN KEY (director) REFERENCES L5_directors(Id);

-- -----------------------------------------------------------------------------------------------------------------------
-- Q3
ALTER TABLE L5_movies
	ADD CONSTRAINT moviename_unq UNIQUE (title);

-- -----------------------------------------------------------------------------------------------------------------------
-- Q4
INSERT INTO L5_directors (Id, firstName, lastName)
	VALUES 	(1010, 'Rob', 'Minkoff'),
			(1020, 'Bill', 'Condon'),
			(1050, 'Josh', 'Cooley'),
            (2010, 'Brad', 'Bird'),
            (3020, 'Lake', 'Bell')
            ;

INSERT INTO L5_movies (Id, title, year, director, score)
	VALUES	(100, 'The Lion King', 2019, 3020, 3.50),
			(200, 'Beauty and the Beast', 2017, 1050, 4.20),
            (300, 'Toy Story 4', 2019, 1020, 4.50),
            (400, 'Mission Impossible', 2018, 2010, 5.00),
            (500, 'The Secret Life of Pets', 2016, 1010, 3.90)
            ;
    
-- -----------------------------------------------------------------------------------------------------------------------
-- Q5
DROP TABLE L5_castings, L5_movies, L5_actors, L5_directors;

-- -----------------------------------------------------------------------------------------------------------------------
-- Q6 
CREATE TABLE employee2 (
	employeeNumber	int				Primary Key,
    lastName		varchar(50)		not null,
    firstname		varchar(50)		not null,
    extension		varchar(10)		not null,
    email			varchar(100)	not null,
    officeCode		varchar(10)		not null,
    reportsTo		int,
    jobTitle		varchar(50)		not null
    );

-- -----------------------------------------------------------------------------------------------------------------------
-- Q7
ALTER TABLE employee2 
	ADD COLUMN username varchar(16);

-- -----------------------------------------------------------------------------------------------------------------------
-- Q8
INSERT INTO employee2 (SELECT *, NULL FROM employees);

-- -----------------------------------------------------------------------------------------------------------------------
-- Q9
UPDATE employee2 SET firstname = 'Clint', lastname='MacDonald' 
	WHERE employeeNumber = 1002;
    
-- -----------------------------------------------------------------------------------------------------------------------
-- Q10
UPDATE employee2 SET username = lower(concat(substr(firstname, 1, 1), lastname));
    
 -- -----------------------------------------------------------------------------------------------------------------------
-- Q11
DELETE FROM employee2
	WHERE OfficeCode = 4;
    
 -- -----------------------------------------------------------------------------------------------------------------------
-- Q12
DROP TABLE employee2;
