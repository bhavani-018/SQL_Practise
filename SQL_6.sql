-- 15-10-25 
-- window function
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
