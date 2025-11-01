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

