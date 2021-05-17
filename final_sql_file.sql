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
create table categories(
	category_id serial primary key,
	c_name varchar(30)
);	
-- Creating products table
create table products(
	Product_id serial primary key,
	p_name varchar(30),
	Product_code char(30) unique,
	Manufacturer varchar(15),
	expiry_date date ,
	Instock boolean,
	category_id int references categories(category_id)
);
-- Creating product revenue table
create table products_revenue(
	product_revenue serial primary key,
	product_id int references products(product_id),
	Month varchar(10),
	Cost_price int,
	Selling_price int
);
-- Creating enum type for gender
create type gender as Enum('M','F');
-- Creating staff's table
create table staff(
	staff_id serial primary key,
	s_name varchar(30),
	Role varchar(30),
	Gender gender,
	Age int ,
	Phone_Number varchar(20)
);
-- Creating supplier's table
create table suppliers(
	supplier_id serial primary key,
	supplier_name varchar(30),
	gender gender,
	s_age int,
	s_phone_number varchar(20),
	s_city varchar(20),
	s_state varchar(20),
	s_gmail varchar(30)
);
-- Creating product order table
create table product_orders(
	product_order_id serial primary key,
	order_date date,
	quantity int
);
-- Creating supplier product order table(junction table of products ,suppliers and product order)
create table supplier_product_order(
	product_id int references products(product_id),
	product_order_id int references product_orders(product_order_id),
	supplier_id int references suppliers(supplier_id),
	primary key(product_id,product_order_id,supplier_id)
);
-- Creating inventory table
create table inventory(
    product_id int primary key references products(product_id),
 	product_quantity int 
);

    -- Inserting Data into tables
	
	
-- Inserting data into staff's table
insert into  categories(c_name)
values ('Chocolate'),('Book'),('Dairy'),('Cosmetic');

-- Inseting data into products table
insert into products(p_name,Product_code,Manufacturer,expiry_date,Instock,category_id)
values ('Dairy milk','Drmk','Cadbury','2022-12-12',false,1),
('Nestley','Nech','Nestley','2021-12-12',true,1),
('Angular','Angl','bpb','2025-2-1',true,2),
('XII maths','mths','ncert','2029-06-01',false,2),
('Milk','mlk1','Amul','2021-05-19',false,3),
('Yogurt','yg12','Mother dairy','2021-05-30',true,3),
('Bangles','bng1','seeta','2030-10-30',false,4),
('Ear Rings','erng','ram','2026-11-15',true,4);

-- Inserting data into product revenue table
insert into products_revenue(product_id,Month,Cost_price,Selling_price)
values (8,'april',20,25),(8,'may',19,30),(7,'may',120,150),(6,'may',21,25),(5,'may',22,27),(5,'april',19,23),
(4,'may',90,110),(3,'may',300,356),(2,'may',8,10),(1,'may',9,10);

-- Inserting data into inventory table
insert into inventory (product_id,product_quantity)
values (1,0),(2,11),(3,26),(4,0),(5,0),(6,15),(7,0),(8,5);

-- Inserting data into staff's table
insert into staff(s_name,Role,Gender,Age,Phone_Number)
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
insert into suppliers(supplier_name,gender,s_age,s_phone_number,s_city,s_state,s_gmail)
values ('Peter','M',30,'7875767972','kanpur','uttar pradesh','peter7872@gamil.com'),
('Kylie','F',20,'7874447972','jabalpur','madhya paradesh','kylie7844@gmail.com'),
('Pushpa','F',25,'7875777772','balco','chattisghar','pushpa7877@gmail.com'),
('Udit','M',27,'7875761111','patna','bihar','udit664421@gmail.com');

-- Inserting data into product order table
insert into product_orders(order_date,quantity)
values ('2021-01-11',10),('2021-05-15',1),('2021-03-17',3),('2020-01-11',2),
('2021-05-11',9),('2021-05-12',6),('2021-05-13',4),('2020-11-17',2),
('2021-05-14',7),('2021-02-15',20),('2021-03-12',3),('2020-10-30',1);

--Inserting data into supplier product order table
insert into supplier_product_order(product_id,product_order_id,supplier_id)
values (1,6,3),(2,7,2),(3,5,1),(4,8,3),(5,4,4),(2,9,4),(6,3,1),(7,12,2),(8,2,3),(4,1,2),(3,10,1),(1,11,4);




  -- To display all tables
  
select * from products;
select * from supplier_product_order;
select * from product_orders;
select * from suppliers;
select * from staff;
select * from inventory;
select * from products_revenue;
select * from categories;


  -- Assignment 2 Querires
  
--(1. Query Staff using name or phone number or both)
  --a 
  select * from staff where s_name in('Alex','Emma');
  --b
  select * from staff where s_name = 'Hema' and Phone_Number = '9876543218';
  
--(2. Query Staff using their Role)
  select * from staff where Role = 'Manager';

--(3. Query Product based on - a. Name b. Category c. InStock, OutOfStock d. SP less than, greater than or between)
  --a
  select * from products where p_name = 'Nestley';
  --b
  select * from products where category_id = 3;
  --c.1
  select * from products where Instock = true;
  --c.2
  select * from products where Instock = false;
  
--(4. Number of Products out of stock)
  select count(*) as No_Of_Product_outofstack from products where Instock = false;

--(5. Number of Products within a category)
  select c.category_id, count(distinct p.product_id) as No_Of_Products from products p
  inner join categories c on
  c.category_id=p.category_id
  group by c.category_id;
  
--(6. Product-Categories listed in descending with highest number of products to the lowest number of products)
  insert into products(p_name,Product_code,Manufacturer,expiry_date,Instock,category_id)
  values ('Chocolates ball','froc','ferrero rocher','2023-02-20',true,1),
  ('Buttermilk','bmlk','parag','2021-05-21',true,3);
  
  select c.category_id,c.c_name,count(distinct p.product_id) as No_Of_Products from products p
  inner join categories c on
  c.category_id=p.category_id
  group by c.category_id
  order by No_Of_Products desc;
  
--(7. List of Suppliers - a. Name b. Phone c. Email d. City or State)
  --a
  select * from suppliers where supplier_name ='Pushpa';
  --b
  select * from suppliers where s_phone_number = '7875761111';
  --c
  select * from suppliers where s_gmail ='kylie7844@gmail.com';
  --d
  select * from suppliers where s_city = 'patna' or s_state ='uttar pradesh';
  
--8(List of Product with different suppliers, with the recent date of supply and the amount supplied on 
   --the most recent occasion. Here this can also be filtered based on -
   -- a. Product Name b. Supplier Name c. Product Code d. Supplied after a particular date 
   -- e. Supplied before a particular date f. Product has inventory more than or less than a given qty)  
  --a
  select p.p_name from products p inner join supplier_product_order spo on
  p.product_id = spo.product_id inner join product_orders po on
  po.product_order_id = spo.product_order_id
  where po.order_date > '2021-05-01';
  --b
  select s.supplier_name , s.s_age from suppliers s 
  inner join supplier_product_order spo
  on s.supplier_id = spo.supplier_id
  inner join product_orders po on
  spo.product_order_id = po.product_order_id
  where po.order_date > '2021-04-30';
  --c
  select * from inventory;
  select p.product_code from products p 
  inner join supplier_product_order spo on
  spo.product_id=p.product_id inner join product_orders po on
  spo.product_order_id = po.product_order_id
  where po.order_date > '2021-04-30';
  --d
  select p.p_name from products p 
  inner join supplier_product_order spo on
  spo.product_id=p.product_id inner join product_orders po
  on spo.product_order_id = po.product_order_id
  where po.order_date > '2020-01-01';
  --e
  select p.p_name from products p 
  inner join supplier_product_order spo on
  spo.product_id=p.product_id inner join product_orders po
  on spo.product_order_id = po.product_order_id
  where order_date < '2021-04-30';
  --f.1
  select p.p_name from inventory i inner join products p
  on p.product_id=i.product_id
  where i.product_quantity >2;
  --f.2
  select p.p_name from inventory i inner join products p
  on p.product_id=i.product_id
  where i.product_quantity <10;
  --f.3
  select p.p_name from inventory i inner join products p
  on p.product_id=i.product_id
  where i.product_quantity =26;

