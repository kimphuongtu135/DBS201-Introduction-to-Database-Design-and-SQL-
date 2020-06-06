/*
What is data modelling?
		model in IT is the procedure follow it get something.
		Step to follow to get back database
4 Goals(create database)
	Store data
    Easy to use
    Suitable
    Do not store calculated data
Why ERDs?
	circle is 0
    line is 1
    
    Right to LEft
    For each employee how many department
    one is only one 2 lines
    => for each employee is only one to one departmment
    
    Left to right
    For each department has how many employee
    Range:zero to many
    
    We put FK department_code in EMPLOYEE => each employee belongs to only one department
    UMI diagram
    
Entity
	Singular : no space (single word, if want more than 1 word have to use space)

PRIMARY KEY
	bold 
Fields
	Bold=required
    
EXAMPLE 2
	ZERO OR ONE
    
RIGHT TO LEFT
    For each employee has zero or 1 deparment
LEFT TO RIGHT
	
EXAMPLE 3
	ZERO,ONE OR MANY
    
LEFT TO RIGHT
	for each department has zero one or many 
   
DATA MODELLING PROCESS
	
    1)identify entity(table)
	2) identify attribute (column file or attribute)
	3) specify unique indentifiers
		Primary key, candidate key
        Make Ck instead of PK (CK helps to" Imma gonna come back to fix it later")
        Just write PK when you know exactly that is PK
    4)Establish Relationships
	5)Define relationship optionality and cardinality
		line, cirlce and the fence
        cardinality means how many
        cardinality diagram has to be very specific
	6) Eliminate many to many
		zero and fence for both sides of tale
        If you see that => delete it, have to add junction table
		have to have Entity in the middle called trip
    7) Name Relationships
		name relationship when we know name of FK
        Name when do SQL part
	8)Normalize the database
		where to make sure field match dependent
        example mark depend on assginment and student
        student table, assignment table
        you cannot have something depend on two tables
        data depend on both things => we put it in junctin table
	9) data type
		do at the end 
	
    
    
*/