-- day1 where-comparison,logical,membership
create table Customers (
customer_id int,
first_name varchar(30),
last_name varchar(30),
age int,
country varchar(20));

insert into Customers values( 1,"John","Doe",31,"USA"),
( 2,"Robert","Luna",22,"USA"),
( 3,"David","Robinson",22,"UK"),
( 4,"John","Reinhardt",25,"UK"),
( 5,"Betty","Doe",28,"UAE");

create table Orders (
order_id int,
item varchar(30),
amount int,
customer_id int);

insert into Orders values(1,"Keyboard",400,4),
(2,"Mouse",300,4),
(3,"Monitor",12000,3),
(4,"Keyboard",400,1),
(5,"Mousepad",250,2);

create table Shippings (
shipping_id int,
status varchar(30),
customer int);

insert into Shippings values(1,"Pending",2),
(2,"Pending",4),
(3,"Delivered",3),
(4,"Pending",5),
(5,"Delivered",1);

select * from Customers;
select * from Orders;
select distinct item from Orders;
select count(distinct item) from Orders;
select * from Shippings;
-- ----------------------------------------------------------------------------------------
-- to print firstname john who has age >30
select first_name,age from Customers where age>30;
-- to print customer name who has age <=25
select first_name,age from Customers where age<=25;
-- to print the customer who has age >=25 and from country usa and uk
select first_name,age from Customers where age>=25 and (country = "USA" or country= "UK");
-- to print all the items in ordertable except keyboard
SELECT item FROM Orders WHERE item NOT IN ("Keyboard");
SELECT item FROM Orders WHERE NOT item ="Keyboard";
-- to print amount that is from 300 to 1000
SELECT amount FROM Orders WHERE amount BETWEEN 300 and 1000;
SELECT amount FROM Orders WHERE amount>=300 and amount <=1000;
-- to print only the pending shipping
SELECT shipping_id,status FROM Shippings WHERE status="Pending";

-- day2 -patternmatching-[like,contains,-%],placeholder[_],limit-[how many rows will print..restriction],[offset-skip the no.of rows],orderby-sorting, window function ,round().,[temporary storage not in db...-inline operations ]..
-- inline calculation
-- order of execution : (FROM → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT)

-- task: to  print customers last_name that starts with r
select last_name 
from Customers 
where last_name like "r%";
-- ----------------------------------------------------------------------------------------
-- to print items that start with m in orders table
select 
item from Orders 
where item like 'm%';
-- ----------------------------------------------------------------------------------------
-- to print 1st highestamount in order table
select amount as 1stHighestSalary 
from Orders 
order by amount desc 
limit 1;

-- ,total cost in customer_purchase table should be <=8 in farmersmarket db 
select *,quantity*cost_to_customer_per_qty as total_cost from customer_purchases;
select *,round(quantity*cost_to_customer_per_qty,2) as total_cost 
from customer_purchases
where quantity * cost_to_customer_per_qty <=8;


-- 29/9/25
-- Get all the products available in the market.
use farmers_market;
select * from product;
-- List down 10 rows of farmer’s market vendor booth assignments, displaying the 
-- market date, vendor ID, and booth number from the vendor_booth_assignments 
-- table.
select market_date,vendor_id,booth_number 
from vendor_booth_assignments 
limit 10;
-- Question: In the customer purchases, we have quantity and cost per qty separate, 
-- query the total amount that the customer has paid along with date, customer id, 
-- vendor_id, qty, cost per qty and the total amt.?
select * from customer_purchases;

select market_date, customer_id, vendor_id, quantity, cost_to_customer_per_qty,round(quantity*cost_to_customer_per_qty,2) as total_amount
from customer_purchases;

--  We want to merge each customer’s name into a single column that contains the first name, then a space, and then the last name.
select * from customer;
select concat(customer_first_name," ",customer_last_name) as customer_name from customer;

--  Extract all the product names that are part of product category 1
select product_name from product where product_category_id =1;

--  Print a report of everything customer_id 4 has ever purchased at the farmer’s market, sorted by market date, vendor ID, and product ID.
select customer_id, vendor_id, product_id ,market_date 
from customer_purchases 
where customer_id =4 
order by market_date, vendor_id ,product_id; 

select * from customer_purchases;

select customer_id, vendor_id, product_id ,market_date,round(quantity*cost_to_customer_per_qty,2) as total_amount 
from customer_purchases 
where customer_id =4 
order by market_date, vendor_id ,product_id; 

-- Get all the product info for products with id between 3 and 8 
-- (not inclusive) and product with id 10.

select * from product;
select * from product 
where product_id>3 and product_id<8;

select * from product 
where (product_id > 3 and product_id < 8) or product_id =10;

-- Details of all the purchases made by customer_id 4 at vendor_id 7, along with the total_amt.
select * from customer_purchases;
select *,(quantity*cost_to_customer_per_qty) as total_amount 
from customer_purchases
where customer_id =4 and vendor_id =7;

--  Find the customer detail with the first name of “Carlos” or the last name of “Diaz”.
select * from customer;
select * from customer where customer_first_name="Carlos" or customer_last_name="Diaz";

--  If you wanted to find out what booths vendor 2 was assigned to, on or before (less than or equal to) April 20, 2019
select * from vendor_booth_assignments;
select * from vendor_booth_assignments 
where vendor_id= 2 and market_date <="2019-04-20";

select * from vendor_booth_assignments 
where vendor_id= 3 and market_date <="2019-04-20";
