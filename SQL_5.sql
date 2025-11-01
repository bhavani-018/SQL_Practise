-- 11-10-25-joins

select e.employee_id,e.manager_id from employees as e
join departments as d
on e.manager_id=d.manager_id;
-- 14-10-25
-- union- col should be same for 2 table,data type shoul be same ....print only unique rows (non-duplicate rows)
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

select * from sales;
select s.product_id,s.year as first_year,s.quantity,s.price
from sales s
join 
(select product_id,MIN(year) as first_year
from sales
group by product_id) as demo 
on s.product_id=demo.product_id
and s.year=demo.first_year;