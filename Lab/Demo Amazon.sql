-- Week 5 Lecture Demo
-- ----------------------


CREATE TABLE d5_categories(
	categoryID			smallint		PRIMARY KEY,
    categoryName		varchar(15)		NOT NULL UNIQUE,
    isActive			bit				DEFAULT 1
    );
    

INSERT INTO d5_categories VALUES
(0, 'NOT ASSIGNED', 0),
(1, 'Furniture', 1),
(2, 'Electronics', 1),
(3, 'Fashion', 1);



-- Vendors

CREATE TABLE d5_vendors(
	vendorID 		int 		PRIMARY KEY,
    vendorName		varchar(50)	NOT NULL ,
	vendorAddress	varchar(50)			,
    rating			int			DEFAULT 0 ,					-- set whole value to 0
    numRatings		int			DEFAULT 0
);

INSERT INTO d5_vendors (vendorID, vendorName, vendorAddress)
VALUES 
		(1, 'Sony','Japan'),
		(2, 'Armani','Iitalian'),
        (3, 'laziboy','USA');
        
        
CREATE TABLE d5_products(
		productID		bigint		PRIMARY KEY,
        productSKU		varchar(16)	NOT NULL,
        productName		varchar(50)	NOT NULL,
        productDesc		varchar(500)		,
        sellingPrice	decimal(12,2) DEFAULT 0.00 	NOT NULL,					-- default value takes affect in insert statement,
																			-- if we change to update statement, if we set value to null, it will affect (NOT NULL won't allow it happens)
        vendorID		int				NOT NULL,
        categoryID 		smallint		DEFAULT 0,
        isActive		bit				DEFAULT 1,
        CONSTRAINT	product_vendor_fk	FOREIGN KEY (vendorID) REFERENCES d5_vendors(vendorID),
        CONSTRAINT product_category_fk	FOREIGN KEY (categoryID) REFERENCES d5_categories(categoryID)

);


INSERT INTO d5_products 
VALUES

		(1,'asdsdas','DVD','HD', 129.99,1,3,1);
        
        
ALTER TABLE d5_products
	ADD COLUMN cost		decimal(12,2)	NOT NULL;