-- Database: Departmental Store

-- DROP DATABASE "Departmental Store";

CREATE DATABASE "Departmental Store"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	-- Creating all tables here
	
-- Creating categories table
create table Category(
	Category_Id serial primary key,
	C_Name varchar(30)
);	
-- Creating products table
create table Product(
	Product_Id serial primary key,
	P_Name varchar(30),
	Product_Code char(30) unique,
	Manufacturer varchar(15),
	Expiry_Date date ,
	Instock boolean,
	Category_Id int references Category(Category_Id)
);
-- Creating product revenue table
create table Product_Revenue(
	Product_Revenue serial primary key,
	Product_Id int references Product(Product_Id),
	Month varchar(10),
	Cost_Price int,
	Selling_Price int
);
-- Creating enum type for gender
create type gender as Enum('M','F');
-- Creating staff's table
create table Staff(
	Staff_Id serial primary key,
	S_Name varchar(30),
	Role varchar(30),
	Gender gender,
	Age int ,
	Phone_Number varchar(20)
);
-- Creating supplier's table
create table Supplier(
	Supplier_Id serial primary key,
	Supplier_Name varchar(30),
	Gender gender,
	S_Age int,
	S_Phone_Number varchar(20),
	S_City varchar(20),
	S_State varchar(20),
	S_Gmail varchar(30)
);
-- Creating product order table
create table Product_Order(
	Product_Order_Id serial primary key,
	Order_Date date,
	Quantity int
);
-- Creating supplier product order table(junction table of products ,suppliers and product order)
create table Supplier_Product_Order(
	Product_Id int references Product(Product_Id),
	Product_Order_Id int references Product_Order(Product_Order_Id),
	Supplier_Id int references Supplier(Supplier_Id),
	primary key(Product_Id,Product_Order_Id,Supplier_Id)
);
-- Creating inventory table
create table Inventory(
    Product_Id int primary key references Product(Product_Id),
 	Product_Quantity int 
);

    -- Inserting Data into tables
	
	
-- Inserting data into staff's table
insert into  Category(C_Name)
values ('Chocolate'),('Book'),('Dairy'),('Cosmetic');

-- Inseting data into products table
insert into Product(P_Name,Product_Code,Manufacturer,Expiry_Date,Instock,Category_Id)
values ('Dairy milk','Drmk','Cadbury','2022-12-12',false,1),
('Nestley','Nech','Nestley','2021-12-12',true,1),
('Angular','Angl','bpb','2025-2-1',true,2),
('XII maths','mths','ncert','2029-06-01',false,2),
('Milk','mlk1','Amul','2021-05-19',false,3),
('Yogurt','yg12','Mother dairy','2021-05-30',true,3),
('Bangles','bng1','seeta','2030-10-30',false,4),
('Ear Rings','erng','ram','2026-11-15',true,4);

-- Inserting data into product revenue table
insert into Product_Revenue(Product_Id,Month,Cost_Price,Selling_Price)
values (8,'april',20,25),(8,'may',19,30),(7,'may',120,150),(6,'may',21,25),(5,'may',22,27),(5,'april',19,23),
(4,'may',90,110),(3,'may',300,356),(2,'may',8,10),(1,'may',9,10);

-- Inserting data into inventory table
insert into Inventory (Product_Id,Product_Quantity)
values (1,0),(2,11),(3,26),(4,0),(5,0),(6,15),(7,0),(8,5);

-- Inserting data into staff's table
insert into Staff(S_Name,Role,Gender,Age,Phone_Number)
values ('Alex','Sales','M',23,'9876543210'),
('Natasha','Sales','F',21,'9876543211'),
('Emma','Sales','F',23,'9876543212'),
('Parker','Sales','M',22,'9876543213'),
('Abhimanyu','Manager','M',27,'9876543214'),
('Gauri','Manager','F',26,'9876543215'),
('Ram Prasad','Help Desk','M',32,'9876543216'),
('Rehan','Security','M',27,'9876543217'),
('Hema','Security','F',27,'9876543218'),
('Pralay','Reception','M',27,'9876543219'),
('Divya','Reception','F',27,'9876543220'),
('Abhishesh','Senior Manager','M',27,'9876543221');

-- Inserting data into suppliers table
insert into Supplier(Supplier_Name,Gender,S_Age,S_Phone_Number,S_City,S_State,S_Gmail)
values ('Peter','M',30,'7875767972','kanpur','uttar pradesh','peter7872@gamil.com'),
('Kylie','F',20,'7874447972','jabalpur','madhya paradesh','kylie7844@gmail.com'),
('Pushpa','F',25,'7875777772','balco','chattisghar','pushpa7877@gmail.com'),
('Udit','M',27,'7875761111','patna','bihar','udit664421@gmail.com');

-- Inserting data into product order table
insert into Product_Order(Order_Date,Quantity)
values ('2021-01-11',10),('2021-05-15',1),('2021-03-17',3),('2020-01-11',2),
('2021-05-11',9),('2021-05-12',6),('2021-05-13',4),('2020-11-17',2),
('2021-05-14',7),('2021-02-15',20),('2021-03-12',3),('2020-10-30',1);

--Inserting data into supplier product order table
insert into Supplier_Product_Order(Product_Id,Product_Order_Id,Supplier_Id)
values (1,6,3),(2,7,2),(3,5,1),(4,8,3),(5,4,4),(2,9,4),(6,3,1),(7,12,2),(8,2,3),(4,1,2),(3,10,1),(1,11,4);




  -- To display all tables
  
select * from Product;
select * from Supplier_Product_Order;
select * from Product_Order;
select * from Supplier;
select * from Staff;
select * from Inventory;
select * from Product_Revenue;
select * from Category;


  -- Assignment 2 Querires
  
--(1. Query Staff using name or phone number or both)
  --a 
  select * from Staff where S_Name in('Alex','Emma');
  --b
  select * from Staff where S_Name like 'H__a' and Phone_Number = '9876543218';
  
--(2. Query Staff using their Role)
  select * from Staff where Role like 'M%r';

--(3. Query Product based on - a. Name b. Category c. InStock, OutOfStock d. SP less than, greater than or between)
  --a
  select * from Product where P_Name like 'Ne%';
  --b
  select * from Product where Category_Id = 3;
  --c.1
  select * from Product where Instock = true;
  --c.2
  select * from Product where Instock = false;
  
--(4. Number of Products out of stock)
  select count(*) as No_Of_Product_outofstack from products where Instock = false;

--(5. Number of Products within a category)
  select c.Category_Id, count(distinct p.Product_Id) as No_Of_Product from Product p
  inner join Category c on
  c.Category_Id=p.Category_Id
  group by c.Category_Id;
  
--(6. Product-Categories listed in descending with highest number of products to the lowest number of products)
  insert into Product(P_Name,Product_Code,Manufacturer,Expiry_Date,Instock,Category_Id)
  values ('Chocolates ball','froc','ferrero rocher','2023-02-20',true,1),
  ('Buttermilk','bmlk','parag','2021-05-21',true,3);
  
  select c.Category_Id,c.C_Name,count(distinct p.Product_Id) as No_Of_Product from Product p
  inner join Category c on
  c.Category_Id=p.Category_Id
  group by c.Category_Id
  order by No_Of_Product desc;
  
--(7. List of Suppliers - a. Name b. Phone c. Email d. City or State)
  --a
  select * from Supplier where Supplier_Name ='Pushpa';
  --b
  select * from Supplier where S_Phone_Number = '7875761111';
  --c
  select * from Supplier where S_Gmail ='kylie7844@gmail.com';
  --d
  select * from Supplier where S_City = 'patna' or S_State ='uttar pradesh';
  
--8(List of Product with different suppliers, with the recent date of supply and the amount supplied on 
   --the most recent occasion. Here this can also be filtered based on -
   -- a. Product Name b. Supplier Name c. Product Code d. Supplied after a particular date 
   -- e. Supplied before a particular date f. Product has inventory more than or less than a given qty)  
  --a
  select p.P_Name from Product p inner join Supplier_Product_Order spo on
  p.Product_Id = spo.Product_Id inner join Product_order po on
  po.Product_Order_Id = spo.Product_Order_id
  where po.Order_Date > '2021-05-01';
  --b
  select s.Supplier_Name , s.S_Age from Supplier s 
  inner join Supplier_Product_Order spo
  on s.Supplier_Id = spo.Supplier_Id
  inner join Product_Order po on
  spo.Product_Order_Id = po.Product_Order_Id
  where po.Order_Date > '2021-04-30';
  --c
  select p.Product_Code from Product p 
  inner join Supplier_Product_Order spo on
  spo.Product_Id=p.Product_Id inner join Product_Order po on
  spo.Product_Order_Id = po.Product_Order_Id
  where po.Order_Date > '2021-04-30';
  --d
  select p.P_Name , s.Supplier_Name from Product p 
  inner join Supplier_product_order spo on
  spo.Product_Id=p.Product_Id inner join Product_Order po
  on spo.Product_Order_Id = po.Product_Order_Id inner join Supplier s
  on s.Supplier_Id = spo.Supplier_Id
  where po.Order_Date > '2020-01-01';
  --e
  select p.P_Name , s.Supplier_Name from Product p 
  inner join Supplier_Product_Order spo on
  spo.Product_Id=p.Product_Id inner join Product_Order po
  on spo.Product_Order_Id = po.Product_Order_Id inner join Supplier s
  on s.Supplier_Id = spo.Supplier_Id
  where Order_Date < '2021-04-30';
  --f.1
  select p.P_Name from Inventory i inner join Product p
  on p.Product_Id=i.Product_Id
  where i.Product_Quantity >2;
  --f.2
  select p.P_Name from Inventory i inner join Product p
  on p.Product_Id=i.Product_Id
  where i.Product_Quantity <10;
  --f.3
  select p.P_Name from Inventory i inner join Product p
  on p.Product_Id=i.Product_Id
  where i.Product_Quantity =26;

