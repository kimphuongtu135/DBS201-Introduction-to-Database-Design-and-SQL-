-- Name: Kim Phuong Tu
-- Student ID : 148886179
-- Quiz 5 in lab



CREATE TABLE ACTORS(
ActorID				int			 			PRIMARY KEY ,
LName				varchar (20)			NOT NULL,
FName				varchar(20)				NOT NULL,
DateOfBirth			date							,
BirthCountry		varchar(3)						,
	CONSTRAINT countriees_fk	FOREIGN KEY (BirthCountry)	REFERENCES COUNTRIES(CountryCode)			
);

CREATE table COUNTRIES(
CountryCode				varchar(3)	PRIMARY KEY,
CountryName				char(20)	NOT NULL	
);