/*
Set pizza_db as Default to make it easier to write scripts
*/
select *
from pizza_sales;


# Total Revenue KPI Requirement
select SUM(total_price) as total_revenue
from pizza_sales;


# Average Order Value
select SUM(total_price) / count(distinct(order_id)) as avg_order_val
from pizza_sales;


# Total Pizzas Sold
select sum(quantity) as total_sold
from pizza_sales;


# Total Orders: The total number of orders placed
select count(distinct(order_id)) as orders_placed
from pizza_sales;


# Average Pizzas Per Order
select cast(
cast(sum(quantity) as decimal(10,2)) /
cast(count(distinct(order_id)) as decimal(10,2))
as decimal(10,2))
as avg_per_order
from pizza_sales;


# Hourly Trend for Total Pizzas Sold
select hour(order_time) as hourly_order, sum(quantity)
from pizza_sales
group by hourly_order
order by hourly_order;


# Weekly Trend for Total Orders
select week(str_to_date(order_date,'%d-%m-%Y'),3) as `week`,
	year(str_to_date(order_date,'%d-%m-%Y')) as order_year,
	count(distinct(order_id)) as order_count
from pizza_sales
group by `week`, order_year
order by `week`, order_year;


# Percentage of Sales by Pizza Category
select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as ratio_sales
from pizza_sales
group by pizza_category;


# Percentage of Sales by Pizza Size
select pizza_size as size, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as ratio_size
from pizza_sales
group by pizza_size
order by ratio_size DESC;