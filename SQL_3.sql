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