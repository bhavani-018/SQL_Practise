
create database practice;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

INSERT INTO products values (106,'Androidphone','Electronics',25.00);

INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);

select * from sales;

select * from Products;
-- Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024.
select sale_id,total_price from sales where sale_date='2024-01-03';

-- Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100.
select product_id,product_name from Products where unit_price>100;

-- Calculate the total revenue generated from all sales in the Sales table.
select sum(total_price) as revenue from sales;

-- Calculate the average unit_price of products in the Products table.
select avg(unit_price) as average from products;

-- Count Sales Per Day from the Sales table
select count(sale_date) as sales_per_day,sale_date from sales group by sale_date;

-- Retrieve product_name and unit_price from the Products table with the Highest Unit Price
select product_name,unit_price from products 
order by unit_price desc limit 1;

-- Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4
select sale_id, product_id, total_price from sales
where quantity_sold >4;

-- Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as 'YYYY-MM-DD'
select sale_id, date_format(sale_date,'%y-%m-%d') as date from sales;

