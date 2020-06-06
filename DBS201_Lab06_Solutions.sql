-- --------------------------------
-- DBS201 - Lab 6 Fall 2019
-- Clint MacDonald
-- Solutions (One solution that is)
-- --------------------------------

-- Create Students Table
CREATE TABLE L6_Students (
	studentID 		BIGINT 			PRIMARY KEY,
    FName			VARCHAR(30) 	NOT NULL,
    LName			VARCHAR(30)		NOT NULL,
    Email			VARCHAR(50)		NOT NULL
    );

-- Create the list of items table
CREATE TABLE L6_markableItems (
	itemID 			INT				PRIMARY KEY,
    itemName		VARCHAR(30)		NOT NULL,
    MaxMarks		TINYINT			NOT NULL CHECK(MaxMarks BETWEEN 0 AND 255),
    CourseWeight	DECIMAL(6,3)	NOT NULL CHECK(CourseWeight BETWEEN 0.0 AND 100.0),
    IsIncluded		BIT				DEFAULT 1 NOT NULL
    );

-- create the junction table that links students to items and stores their grades
CREATE TABLE L6_Submissions (
	submissionID	INT				PRIMARY KEY		AUTO_INCREMENT, -- note: this means auto number field (not required)
    studentID		BIGINT,
    itemID			INT,
    gradeReceived	DECIMAL(6,2),
    DateTimeSub		DATETIME	DEFAULT NOW() NOT NULL,				-- note: this is putting in the current system date and time by default (not required)
    CONSTRAINT sub_stud_fk FOREIGN KEY (studentID) REFERENCES L6_Students(studentID),
    CONSTRAINT sub_item_fk FOREIGN KEY (itemID) REFERENCES L6_markableItems(itemID)
    );

-- insert data into the student table
INSERT INTO L6_Students VALUES
	(900111111, 'Student1', 'One', 'student.one@senecacollege.ca'),
	(900222222, 'Student2', 'Two', 'student.one@senecacollege.ca'),
	(900333333, 'Student3', 'Three', 'student.one@senecacollege.ca'),
	(900444444, 'Student4', 'Four', 'student.one@senecacollege.ca')
    ;

-- insert data into the items table
INSERT INTO L6_markableItems VALUES
	(1, 'Lab 01', 10, 3.0, 1),
	(2, 'Lab 02', 10, 3.0, 1),
	(3, 'Lab 03', 10, 3.0, 1),
	(4, 'Lab 04', 10, 3.0, 1),
	(5, 'Lab 05', 10, 3.0, 1),
	(6, 'Lab 06', 10, 3.0, 1),
	(7, 'Lab 07', 10, 3.0, 1),
	(8, 'Lab 08', 10, 3.0, 1),
	(9, 'Lab 09', 10, 3.0, 1),
	(10, 'Lab 10', 10, 3.0, 1),
	(11, 'Quiz 01', 10, 2.5, 1),
	(12, 'Quiz 02', 10, 2.5, 1),
	(13, 'Quiz 03', 10, 2.5, 1),
	(14, 'Quiz 04', 10, 2.5, 1),
	(15, 'Quiz 05', 10, 2.5, 1),
	(16, 'Quiz 06', 10, 2.5, 1),
	(17, 'Quiz 07', 10, 2.5, 1),
	(18, 'Quiz 08', 10, 2.5, 1),
	(19, 'Quiz 09', 10, 2.5, 1),
	(20, 'Quiz 10', 10, 2.5, 1),
	(21, 'Test 1', 100, 20, 1),
	(22, 'Project MS 1', 25, 6, 1),
	(23, 'Project MS 2', 25, 6, 1),
	(24, 'Project Final', 50, 13, 1)
    ;

/* Student marks are inserted below (After bonus questions), but here are the BONUS questions.  
Note: these were hard and required online research, so no worries if you did not get them. */
-- ------------------------------------------------
-- BONUS QUESTIONS
-- ------------------------------------------------
-- First Check that Markable Items add up to 100%
SELECT SUM(CourseWeight) AS TotalWeight FROM L6_markableItems;

-- Task 4 (BONUS)
SELECT ROUND(SUM(gradeReceived / MaxMarks * CourseWeight), 2) AS Mark, Stud.studentID, CONCAT(FName, ' ', LName) AS Student
	FROM L6_Students Stud LEFT JOIN L6_Submissions Sub USING (studentID)
		LEFT JOIN L6_markableItems I USING (itemID)
	GROUP BY Stud.studentID, FName, LName;

-- TASK 5 (BONUS)
CREATE OR REPLACE VIEW vwStudentGrades AS (
	SELECT ROUND(SUM(gradeReceived / MaxMarks * CourseWeight), 2) AS Mark, Stud.studentID, CONCAT(FName, ' ', LName) AS Student
	FROM L6_Students Stud LEFT JOIN L6_Submissions Sub USING (studentID)
		LEFT JOIN L6_markableItems I USING (itemID)
	GROUP BY Stud.studentID, FName, LName
    );
-- Use a SELECT statement to output the results.
SELECT * FROM vwStudentGrades ORDER BY Mark DESC;


-- ----------------------------------------
-- INSERTION OF STUDENT MARKS
-- ----------------------------------------

-- Student 1
INSERT INTO L6_Submissions VALUES
	(NULL, 900111111, 1, 9, NOW()),
	(NULL, 900111111, 2, 9.5, NOW()),
	(NULL, 900111111, 3, 10, NOW()),
	(NULL, 900111111, 4, 10, NOW()),
	(NULL, 900111111, 5, 8.5, NOW()),
	(NULL, 900111111, 6, 9.25, NOW()),
	(NULL, 900111111, 7, 10, NOW()),
	(NULL, 900111111, 8, 9, NOW()),
	(NULL, 900111111, 9, 10, NOW()),
	(NULL, 900111111, 10, 7, NOW()),
	(NULL, 900111111, 11, 9, NOW()),
	(NULL, 900111111, 12, 7.5, NOW()),
	(NULL, 900111111, 13, 10, NOW()),
	(NULL, 900111111, 14, 6, NOW()),
	(NULL, 900111111, 15, 8.5, NOW()),
	(NULL, 900111111, 16, 7.25, NOW()),
	(NULL, 900111111, 17, 8, NOW()),
	(NULL, 900111111, 18, 9, NOW()),
	(NULL, 900111111, 19, 9.5, NOW()),
	(NULL, 900111111, 20, 7, NOW()),
	(NULL, 900111111, 21, 87.5, NOW()),
	(NULL, 900111111, 22, 22, NOW()),
	(NULL, 900111111, 23, 20, NOW()),
	(NULL, 900111111, 24, 42, NOW())
    ;

-- Student 2
INSERT INTO L6_Submissions VALUES
	(NULL, 900222222, 1, 9, NOW()),
	(NULL, 900222222, 2, 9.5, NOW()),
	(NULL, 900222222, 3, 10, NOW()),
	(NULL, 900222222, 4, 10, NOW()),
	(NULL, 900222222, 5,10, NOW()),
	(NULL, 900222222, 6, 9.25, NOW()),
	(NULL, 900222222, 7, 10, NOW()),
	(NULL, 900222222, 8, 10, NOW()),
	(NULL, 900222222, 9, 10, NOW()),
	(NULL, 900222222, 10, 10, NOW()),
	(NULL, 900222222, 11, 9, NOW()),
	(NULL, 900222222, 12, 9, NOW()),
	(NULL, 900222222, 13, 10, NOW()),
	(NULL, 900222222, 14, 8, NOW()),
	(NULL, 900222222, 15, 8.5, NOW()),
	(NULL, 900222222, 16, 9, NOW()),
	(NULL, 900222222, 17, 10, NOW()),
	(NULL, 900222222, 18, 9, NOW()),
	(NULL, 900222222, 19, 10, NOW()),
	(NULL, 900222222, 20, 7, NOW()),
	(NULL, 900222222, 21, 100, NOW()),
	(NULL, 900222222, 22, 25, NOW()),
	(NULL, 900222222, 23, 24.5, NOW()),
	(NULL, 900222222, 24, 48, NOW())
    ;
DELETE FROM L6_Submissions WHERE studentID = 900222222;
-- Student 3
INSERT INTO L6_Submissions VALUES
	(NULL, 900333333, 1, 9, NOW()),
	(NULL, 900333333, 2, 9.5, NOW()),
	(NULL, 900333333, 3, 10, NOW()),
	(NULL, 900333333, 4, 10, NOW()),
	(NULL, 900333333, 5, 8.5, NOW()),
	(NULL, 900333333, 6, 9.25, NOW()),
	(NULL, 900333333, 7, 10, NOW()),
	(NULL, 900333333, 8, 9, NOW()),
	(NULL, 900333333, 9, 10, NOW()),
	(NULL, 900333333, 10, 7, NOW()),
	(NULL, 900333333, 11, 9, NOW()),
	(NULL, 900333333, 12, 7.5, NOW()),
	(NULL, 900333333, 13, 10, NOW()),
	(NULL, 900333333, 14, 6, NOW()),
	(NULL, 900333333, 15, 8.5, NOW()),
	(NULL, 900333333, 16, 7.25, NOW()),
	(NULL, 900333333, 17, 8, NOW()),
	(NULL, 900333333, 18, 9, NOW()),
	(NULL, 900333333, 19, 9.5, NOW()),
	(NULL, 900333333, 20, 7, NOW()),
	(NULL, 900333333, 21, 74.2, NOW()),
	(NULL, 900333333, 22, 21, NOW()),
	(NULL, 900333333, 23, 19, NOW()),
	(NULL, 900333333, 24, 35, NOW())
    ;

-- Student 4
INSERT INTO L6_Submissions VALUES
	(NULL, 900444444, 1, 9, NOW()),
	(NULL, 900444444, 2, 9.5, NOW()),
	(NULL, 900444444, 3, 10, NOW()),
	(NULL, 900444444, 4, 10, NOW()),
	(NULL, 900444444, 5, 8.5, NOW()),
	(NULL, 900444444, 6, 9.25, NOW()),
	(NULL, 900444444, 7, 10, NOW()),
	(NULL, 900444444, 8, 9, NOW()),
	(NULL, 900444444, 9, 10, NOW()),
	(NULL, 900444444, 10, 7, NOW()),
	(NULL, 900444444, 11, 9, NOW()),
	(NULL, 900444444, 12, 7.5, NOW()),
	(NULL, 900444444, 13, 10, NOW()),
	(NULL, 900444444, 14, 6, NOW()),
	(NULL, 900444444, 15, 8.5, NOW()),
	(NULL, 900444444, 16, 7.25, NOW()),
	(NULL, 900444444, 17, 8, NOW()),
	(NULL, 900444444, 18, 9, NOW()),
	(NULL, 900444444, 19, 9.5, NOW()),
	(NULL, 900444444, 20, 7, NOW()),
	(NULL, 900444444, 21, 66.66, NOW()),
	(NULL, 900444444, 22, 21.5, NOW()),
	(NULL, 900444444, 23, 24, NOW()),
	(NULL, 900444444, 24, 42.5, NOW())
    ;

-- Clean Up afterwards to delete everything
DELETE FROM L6_Submissions;
DROP TABLE L6_Submissions;

    