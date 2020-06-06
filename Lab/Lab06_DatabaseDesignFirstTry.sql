-- -------------------------------
-- DBS201 - Week 6 - Lab 6
-- Introduction to Design and the Associated DDL
-- StudentName: Kim Phuong Tu
-- StudentId: 148886179
-- Date: Oct 13, 2019
-- Semester: Fall 2019
-- -------------------------------

/*
In this lab you are going to design and create a mini database.  This will not be a full database,
but a small part of a larger database.  You will be creating a data base to help the professor keep track 
of your marks in this class.  

You will need to tracks students (Just basic information for the class only).  You will need to track the 
markable items (tests, labs, quizzes, assignments) and their percentage of the final mark, then record each students mark for each markable item.  

Tasks
1) Create the appropriate tables, fields, field types and sizes, and required constraints (your choice)
2) Insert your student information and that of 3 of your classmates. (Fake data is okay)
3) Insert marks for all markable items for those 4 students
4) Create a Query (Select) that calculates the final mark for each student
5) Create a View that stores the above query.alter

HINTS: 
1) Use the course outline for the mark breakdown
2) draw the tables with circles and lines on paper to determine their relationships
3) Use your experience so far as to what fields are required.
4) ASK QUESTIONS 
*/

-- 1) Create the appropriate tables, fields, field types and sizes, and required constraints (your choice)
-- Answer:

CREATE TABLE L6_STUDENTS(
StudentID				int			 			PRIMARY KEY ,
FirstName				varchar (20)			NOT NULL DEFAULT '',
LastName				varchar(20)				NOT NULL DEFAULT ''
);


CREATE TABLE L6_ITEMS(
ItemsID					tinyint			 		PRIMARY KEY ,
ItemsName				varchar (20)			NOT NULL DEFAULT ''	,
Percentage				decimal(4,2)			DEFAULT 0 NOT NULL	
);


CREATE TABLE L6_MARKS(
MarkID					int			 		PRIMARY KEY ,
Marks					decimal(4,2)			DEFAULT 0 NOT NULL CHECK( Marks>0 AND Marks<100),
outOf					tinyint					NOT NULL DEFAULT 100,
ItemsID					tinyint					NOT NULL ,
StudentID				int					NOT NULL ,
CONSTRAINT markstudentID_fk FOREIGN KEY (StudentID) REFERENCES L6_STUDENTS (StudentID),
CONSTRAINT markitem_fk FOREIGN KEY (ItemsID) REFERENCES L6_ITEMS(ItemsID)
);



-- 2) Insert your student information and that of 3 of your classmates. (Fake data is okay)
-- Answer

INSERT INTO L6_STUDENTS
VALUES      
			(148886179,'Kim Phuong','Tu'),
            (512341994,'Lucy','Pk'),
            (612061998,'Elisa','Ng'),
            (213051997,'Nghia','An');

INSERT INTO L6_ITEMS
VALUES 
			(1,'Quiz01', 2.5),
            (2,'Quiz02', 2.5),
            (3,'Quiz03', 2.5),
            (4,'Quiz04', 2.5),
            (5,'Quiz05', 2.5),
            (6,'Quiz06', 2.5),
            (7,'Quiz07', 2.5),
            (8,'Quiz08', 2.5),
            (9,'Quiz09', 2.5),
            (10,'Quiz10', 2.5),
            (11,'Lab01', 3.0),
			(12,'Lab01', 3.0),
			(13,'Lab01', 3.0),
			(14,'Lab01', 3.0),  
			(15,'Lab01', 3.0),
			(16,'Lab01', 3.0),
			(17,'Lab01', 3.0),
			(18,'Lab01', 3.0),
			(19,'Lab01', 3.0),
			(20,'Lab01', 3.0),
			(21,'Milestones1',12.5),
			(22,'Milestones2',12.5),
            (23,'Test',20);


-- 3) Insert marks for all markable items for those 4 students
-- Answer 

INSERT INTO L6_MARKS
VALUES 
			(1,17,20,1,148886179),
            (2,12,20,2,148886179),
            (3,15,20,3,148886179),
            (4,16,20,4,148886179),
            (5,13,20,5,148886179),
            (6,20,20,6,148886179),
            (7,19,20,7,148886179),
            (8,16,20,8,148886179),
            (9,17,20,9,148886179),
            (10,15,20,10,148886179),
            (11,80,100,11,148886179),
            (12,70,100,12,148886179),
            (13,76,100,13,148886179),
            (14,88,100,14,148886179),
            (15,90,100,15,148886179),
            (16,92,100,16,148886179),
            (17,93,100,17,148886179),
            (18,87,100,18,148886179),
            (19,67,100,19,148886179),
            (20,79,100,20,148886179),
            (21,93,100,21,148886179),
            (22,97,100,22,148886179),
			(23,45,50,23,148886179),
            (24,15,20,1,512341994),
            (25,17,20,2,512341994),
            (26,18,20,3,512341994),
            (27,20,20,4,512341994),
            (28,20,20,5,512341994),
            (29,20,20,6,512341994),
            (30,19,20,7,512341994),
            (31,16,20,8,512341994),
            (32,17,20,9,512341994),
            (33,18,20,10,512341994),
            (34,80,100,11,512341994),
            (35,75,100,12,512341994),
            (36,76,100,13,512341994),
            (37,84,100,14,512341994),
            (38,92,100,15,512341994),
            (39,92,100,16,512341994),
            (40,91,100,17,512341994),
            (41,87,100,18,512341994),
            (42,90,100,19,512341994),
            (43,79,100,20,512341994),
            (44,93,100,21,512341994),
            (45,97,100,22,512341994),
			(46,48,50,23,512341994),
			(47,18,20,1,612061998),
            (48,20,20,2,612061998),
            (49,18,20,3,612061998),
            (50,14,20,4,612061998),
            (51,15,20,5,612061998),
            (52,20,20,6,612061998),
            (53,19,20,7,612061998),
            (54,16,20,8,612061998),
            (55,17,20,9,612061998),
            (56,19,20,10,612061998),
            (57,88,100,11,612061998),
            (58,75,100,12,612061998),
            (59,71,100,13,612061998),
            (60,84,100,14,612061998),
            (61,92,100,15,612061998),
            (62,67,100,16,612061998),
            (63,91,100,17,612061998),
            (64,87,100,18,612061998),
            (65,89,100,19,612061998),
            (66,79,100,20,612061998),
            (67,91,100,21,612061998),
            (68,94,100,22,612061998),
			(69,40,50,23,612061998),
			(70,13,20,1,213051997),
            (71,11,20,2,213051997),
            (72,15,20,3,213051997),
            (73,14,20,4,213051997),
            (74,15,20,5,213051997),
            (75,20,20,6,213051997),
            (76,19,20,7,213051997),
            (77,16,20,8,213051997),
            (78,12,20,9,213051997),
            (79,19,20,10,213051997),
            (80,67,100,11,213051997),
            (81,75,100,12,213051997),
            (82,54,100,13,213051997),
            (83,44,100,14,213051997),
            (84,92,100,15,213051997),
            (85,89,100,16,213051997),
            (86,91,100,17,213051997),
            (87,87,100,18,213051997),
            (88,77,100,19,213051997),
            (89,79,100,20,213051997),
            (90,78,100,21,213051997),
            (91,56,100,22,213051997),
			(92,37,50,23,213051997);
            
		
 -- 4) Create a Query (Select) that calculates the final mark for each student
 -- Answer
 
 SELECT s.StudentID,
		s.FirstName,
        s.LastName,
 FORMAT (SUM(((m.Marks/m.outOf)*i.Percentage)/100),2) as 'rawScore',
 FORMAT	(SUM(i.Percentage),1) as 'Percent',
 FORMAT	(SUM(((m.Marks/m.outOf)*i.Percentage)/100)*(SUM(i.Percentage)),2) as 'Final'
  FROM 
			L6_STUDENTS AS s JOIN L6_MARKS AS m 
								ON s.StudentId=m.StudentID
						JOIN L6_ITEMS AS i 
								ON m.ItemsID=i.ItemsID
GROUP BY (s.StudentID);
 


-- 5) Create a View that stores the above query.alter
-- Answer:

CREATE VIEW L6_FINALSCORE (
	StudentID,
	FirstName,
	LastName,
	rawScore,
    Percentage,
    FinalScore
    )
    AS
    SELECT s.StudentID,
		s.FirstName,
        s.LastName,
 FORMAT (SUM(((m.Marks/m.outOf)*i.Percentage)/100),2) as 'rawScore',
 FORMAT	(SUM(i.Percentage),1) as 'Percent',
 FORMAT	(SUM(((m.Marks/m.outOf)*i.Percentage)/100)*(SUM(i.Percentage)),2) as 'Final'
  FROM 
			L6_STUDENTS AS s JOIN L6_MARKS AS m 
								ON s.StudentId=m.StudentID
						JOIN L6_ITEMS AS i 
								ON m.ItemsID=i.ItemsID
GROUP BY (s.StudentID);

  DROP VIEW L6_FINALSCORE;
  DROP TABLE L6_MARKS; 
  DROP TABLE L6_ITEMS; 
  DROP TABLE L6_STUDENTS; 