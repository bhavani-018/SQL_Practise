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

