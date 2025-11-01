
use learning;
show tables;
create table student(
id int,
student_name varchar(25),
department varchar(30),
year_of_joining int
);
insert into student values
(1,'joey','acting',2002),
(2,'monica','cooking',2003),
(3,'chandler','coding',2004),
(4,'rachel','fashioning',2005)
;

SET SQL_SAFE_UPDATES=0;

update student set year_of_joining=2002 where id=4;

SELECT * FROM student;
delete from student where id=4;


-- day1 where-comparison,logical,membership
-- day2 -patternmatching-[like,contains,-%],placeholder[_],limit-[how many rows will print..restriction],[offset-skip the no.of rows],orderby-sorting, window function ,round().,[temporary storage not in db...-inline operations ]..
-- inline calculationcustomer_purchases
-- order of execution : (FROM → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → LIMIT)
-- task: to  print customers last_name that starts with r,
-- to print items that start with m in orders table ,
-- to print 1st highestamount in order table,
-- to print 3rd highest amount in order table... -- 
-- ,total cost in customer_purchase table should be <=8 in farmersmarket db 

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
-- ----------------------------------------------------------------------------------------
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


-- ----------------------------------------------------------------------------------------
-- to print 3rd highest amount in order table
select amount as 3rd_Highest_Salary 
from Orders 
order by amount desc 
limit 1 offset 2;

select amount from
(select amount,
dense_rank() over(order by amount desc) as rank_
from orders) as demo
where rank_=3;

-- ----------------------------------------------------------------------------------------
-- ,total cost in customer_purchase table should be <=8 in farmersmarket db 
select *,quantity*cost_to_customer_per_qty as total_cost from customer_purchases;
select *,round(quantity*cost_to_customer_per_qty,2) as total_cost 
from customer_purchases
where quantity * cost_to_customer_per_qty <=8;

-- ********************************************************************************************************************
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
select *,(quantity*cost_to_customer_per_qty) as total_amount from customer_purchases where customer_id =4 and vendor_id =7;

--  Find the customer detail with the first name of “Carlos” or the last name of “Diaz”.
select * from customer;
select * from customer where customer_first_name="Carlos" or customer_last_name="Diaz";

--  If you wanted to find out what booths vendor 2 was assigned to, on or before (less than or equal to) April 20, 2019
select * from vendor_booth_assignments;
select * from vendor_booth_assignments 
where vendor_id= 2 and market_date <="2019-04-20";

select * from vendor_booth_assignments 
where vendor_id= 3 and market_date <="2019-04-20";

-- ********************************************************************************************************************
-- 30-9-25 -case conditional statement to use if else logic-to categorize,is null, trim-remove unwanted space -front nd back,subqueries
-- purchase detail on snow, purchase details on spring,col-customer_purchases-market_date_info,customer_purchases
-- fresh nu iruka product purchase pana customer details
SELECT * FROM farmers_market.market_date_info;

select market_date,market_rain_flag, 
case 
when market_rain_flag = 0 then "rainy" 
when market_rain_flag = 1 then "not rainy"
end as category
from market_date_info;
-- ----------------------------------------------------------------------------------------
select * from customer_purchases where market_date in
(select market_date from market_date_info where market_snow_flag ='1');
select * from market_date_info where market_snow_flag =1;
-- --------------------------------------------------------------------------------------------------------
select * from customer_purchases where market_date in
(select market_date from market_date_info where market_season="spring");
-- --------------------------------------------------------------------------------------------------------
select * from product_category;

select * from customer where customer_id in
(select customer_id from customer_purchases where product_id in
(select product_id from product where product_category_id in
(select product_category_id from product_category where product_category_name like "%fresh%")));

-- -----------------------------------------------------------------------------------------------------------
-- 8/10/25 
-- Qn 1: Select the number of employees in each department 
-- (you only need to show the department code and the number 
-- of employees).

select * from employees;

select 
department_id, count(*) as no_of_employees
from employees
group by department_id;

-- Qn 2: Select the names of departments with more than 
-- two employees.

select department_name
from departments
where department_id in
(select department_id from employees
group by department_id
having count(employee_id)>2);

-- 3.In descending order, list the frequency count of employee 
-- last names, i.e., how many employees share each last name.
select * from employees
where last_name like 'King';

select 
last_name ,count(*) as frequency_count
from employees
group by last_name
order by frequency_count desc;

-- Qn 5: Display number of employees, 
-- total salary paid to employees work in each department.

select 
department_id, count(employee_id)as no_of_employees,sum(salary) as total_salary
from employees
group by department_id; 

-- 6.Display the department code, total salary paid to employees
-- group by department_id and manager_id=103.

select 
department_id, count(employee_id)as no_of_employees,sum(salary) as total_salary
from employees
where manager_id=103
group by department_id ; 

select 
department_id, count(employee_id)as no_of_employees,sum(salary) as total_salary
from employees
group by department_id,manager_id
having manager_id =103; 

select * from employees where manager_id =103;

select salary from employees;
select salary from employees where salary>8000;

-- 4
select salary*12 as annual_salary,count(*) as employee_with_same_salary
from employees
group by salary
having salary*12>80000
order by salary;

select salary*12 as annual_salary,count(*) as employee_with_same_salary
from employees
where salary*12>80000
group by salary*12
order by salary*12 asc;


-- 9/10/2025

-- having clause-[where-table level filter],
-- [having-filter when using with the result of group by record]
 
-- 12-10-2025
-- top 5 customers based on  no.of order wise

select
customer_id,count(product_id) as no_of_products
from customer_purchases
group by customer_id
order by no_of_products desc
limit 5;

-- top 5 customers based on totalno of sales customer wise
select 
customer_id,sum(quantity*cost_to_customer_per_qty) as total_sales 
from customer_purchases
group by customer_id
order by total_sales desc
limit 5;

-- oru oru product evlo  no.of sales aagiruku
select 
product_id,count(product_id) as no_of_sales
from customer_purchases
group by product_id;

-- oru oru date la yum evlo no.of sales aagirukumu...
select
market_date,count(product_id) as no_of_sales
from customer_purchases
group by market_date;

select * from customer_purchases;
select * from customer;

create table candidate (candidate_id int,
						skill varchar(50));

insert into candidate (candidate_id, skill) 
values (100,"Python"),
(100,"Tableu"),
(100,"MySQL"),
(101,"R"),
(101,"Tableau"),
(101,"Java"),
(102,"PowerBi"),
(102,"MySQL");

insert into candidate (candidate_id,skill) values (102,"Python");
insert into candidate (candidate_id,skill) values (102,"Tableu");
insert into candidate (candidate_id,skill) values (102,"MySQL");
set sql_safe_updates=0;

Delete from candidate
where candidate_id=102;

select * from candidate;
-- We want to find candidates who are proficient in 'Python', 'Tableau', and 'MySQL'.
-- Write a query to list the candidates who possess all three required skills for the job. Sort the output by candidate_id in ascending order.
select distinct candidate_id from
(select candidate_id,count(skill) over(partition by candidate_id) as count_ from candidate
where skill in ("Python","Tableu","MySQL")) as demo
where count_=3;

select candidate_id
from candidate 
where skill in ("Python","Tableu","MySQL")
group by candidate_id
having count(skill)=3;

select candidate_id from candidate where skill in ("Python","Tableu","MySQL");

-- 11-10-25-joins

select e.employee_id,e.manager_id from employees as e
join departments as d
on e.manager_id=d.manager_id;
-- 14-10-25
-- union-rows or col should be same for 2 table,data type shoul be same ....print only unique rows (non-duplicate rows)
-- union all -print duplicates 
-- full join ..left join union right join

select * from employees;
select * from departments;
select * from employees as ep
left join department as dp
on ep.department_id=dp.department_id
union 
select * from employees as ep
right join department as dp
on ep.department_id=dp.department_id;

-- cross join 
select * from employees
cross join departments;

-- self join - to calcuate col wise we use self join becoz we cant do row wise calc

select * from employees as e
join employees as m
on e.manager_id=m.employee_id
where e.salary>m.salary;

select e.first_name
from employees as e
join employees as m
on e.manager_id=m.employee_id
where e.salary>m.salary;


-- 15-10-25 

select 
*,
avg(salary) over() as avg_salary 
from employees;

select * from
(select * from
(select 
*,
avg(salary) over() as avg_salary 
from employees) as demo
where salary < avg_salary) as demo1;


with demo as(
select 
*,
avg(salary) over() as avg_salary 
from employees
)
select * from demo
where salary < avg_salary;



select 
*,
sum(salary) over(partition by departent_id) as avg_salary 
from employees;

select 
departent_id,sum(salary)
from employee
group by departent_id;

-- 16-10-25 windows functions important
-- [order by] range betwen unbounded preceding (selected row and above rows) and current row -duplicate values considered as not unique
-- rows between 1 preceding and 1 following -consider duplicate value as unique so calculate all
-- rows()-not optimised-just print the no.of rows,rank()-not optimised-print the rank but skips the rank no if duplicate value found,dense_rank()-optimised print correct rank value

-- task - 3rd highest sales aana product id
select * from customer_purchases;

with demo as
(select product_id,quantity*cost_to_customer_per_qty as total_sales,
dense_rank() over(order by (quantity*cost_to_customer_per_qty) desc) as rank_
from customer_purchases)
select * from demo
where rank_=3;


-- 1. Find each employee’s salary as a percentage of the total salary in their department

select * from employees;

select
salary,sum(salary),avg(salary)
from employees
group by salary;

select department_id,
(salary*100.00)/sum(salary) over(partition by department_id) as employee_salary_perc
from employees;


-- > (salary * 100.0 / SUM(salary) OVER(PARTITION BY department))
select * from departments;
select * from employees;
-- 2. Show each employee’s salary along with the difference between their salary and the average salary of their department.
-- > (salary - AVG(salary) OVER(PARTITION BY department))

select 
salary,(salary-AVG(salary) 
over(partition by department_id)) as employee_salary
from employees;

-- 3. For each employee, display their salary along with the overall maximum salary in the company and maximum salary in their department.
-- > (MAX(salary) OVER(), MAX(salary) OVER(PARTITION BY department))

select 
employee_id,salary,department_id,
MAX(salary) over() as overall_max_salary,
MAX(salary) over(partition by department_id) as max_salary_department
from employees;

-- 4. For each department, calculate the minimum and maximum salary, and display them for every employee in that department.
-- > (MIN(salary) OVER(PARTITION BY department), MAX(salary) OVER(PARTITION BY department))
select employee_id,department_id,
MIN(salary) over(partition by department_id) as min_salary,
MAX(salary) over(partition by department_id) as max_salary
from employees;

-- 5. For each employee, show their salary along with the total salary of all employees hired in the same year.
-- > (SUM(salary) OVER(PARTITION BY YEAR(hire_date)))

select employee_id,salary,year(hire_date),
sum(salary) over(partition by year(hire_date)) as total_salary
from employees;


-- 6. Find each employee’s salary compared with the company average and department average.
select * from employees;
select employee_id,department_id,salary,
avg(salary) over() as company_average,
avg(salary) over(partition by department_id) as department_average
from employees;

-- > (AVG(salary) OVER(), AVG(salary) OVER(PARTITION BY department))

-- 7. For each employee, show the gap between the maximum salary in the company and their salary, as well as the gap between the maximum salary in their department and their salary.

with demo as
(select salary,
max(salary) over() as max_salary
from employees)
select *,(max_salary-salary) as gap from demo;

select employee_id,department_id,salary,
max(salary) over()-salary as gap_in_company,
max(salary) over(partition by department_id) as gap_in_department
from employees;


-- > (MAX(salary) OVER() - salary, MAX(salary) OVER(PARTITION BY department) - salary)


-- 23/10/2025 -date function
-- year(),month(),day(),weekday(),weekofyear(),use extract in bigquery ...quarter(),current_date(),now()-both date and time,current_time(),
-- date_add(col_name,interval 5 day),date_sub(col_name,interval -5 day),datediff(),group by orer by ...to find year wisesales, month wise sales,day wise sales 

select current_date();
select current_time();
select now();
select curdate();

select hire_date from employees;

select hire_date,year(hire_date) from employees;
select hire_date,month(hire_date) from employees;
select hire_date,day(hire_date) from employees;

select hire_date,monthname(hire_date) from employees;
select hire_date,dayname(hire_date) from employees;

select hire_date,week(hire_date) from employees; -- no.of week
select hire_date,weekday(hire_date) from employees; -- mon-1/tues-2/wed-3/

select hire_date,extract(year from hire_date) from employees;
select hire_date,extract(month from hire_date) as month_ from employees;

select hire_date,date_add(hire_date, interval 1 day) from employees;

select hire_date,date_add(hire_date, interval 1 day) from employees;
select hire_date,datediff("1987-06-25", hire_date) from employees;

SELECT * FROM farmers_market.customer_purchases;

select
year(market_date) as year_,sum(quantity*cost_to_customer_per_qty) as sales 
from customer_purchases
group by year_;

select
month(market_date) as month_,sum(quantity*cost_to_customer_per_qty) as sales 
from customer_purchases
group by month_
order by month_;

with demo as(
select
* ,year(market_date) as year_,quantity * cost_to_customer_per_qty as sales
from customer_purchases
)
select 
year_,sum(sales) as total_sales
from demo
group by year_;

-- window functions[.lead,lag,nth_value,dense_rank,first_value.]
-- 27-10-2025
-- first_value -prints the first row value and create a another new row
-- nth value(col_name,n),ifnull()
-- ntile(3)-just group col with given number..

-- 29-10-25
-- ddl,constraints

-- 30-10-2025 - important%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- on delete cascade - to delete primary key when it is foreign key in another table
-- tcl-savepoint,rollback
-- savepoint follows order 1 2 3
-- rollback switch back to  2 means it wont come to 3 it again works for 1
-- commit save the previous query and ti allow rollback after commit-removes savepoint
-- advanced subquery(where,join,from,select)
-- task
-- product_id,product_name that product evlo sales aagiruku,last order for that product,product category name

select * from customer_purchases;
select * from product_category;
select * from product;

select demo1.product_id, demo1.product_name,demo1.total_sales,demo1.last_ordered_date,c.product_category_name
from product_category c
join
(select demo.product_id,p.product_name,demo.total_sales,demo.last_ordered_date,p.product_category_id from product p
join
(select distinct product_id,
sum(quantity*cost_to_customer_per_qty) over(partition by product_id) as total_sales,
max(market_date) over(partition by product_id) as last_ordered_date
from customer_purchases) as demo
on p.product_id=demo.product_id) as demo1
on c.product_Category_id = demo1.product_category_id;


select demo.product_id,p.product_name,demo.total_sales,demo.last_ordered_date,p.product_category_id from product p
join
(select distinct product_id,
sum(quantity*cost_to_customer_per_qty) over(partition by product_id) as total_sales,
max(market_date) over(partition by product_id) as last_ordered_date
from customer_purchases) as demo
on p.product_id=demo.product_id;

-- 31.10.25
-- advance cte -standalone ,nested cte is better than subquery 
-- virtual table max 5 only allowed

