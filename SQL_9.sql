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
