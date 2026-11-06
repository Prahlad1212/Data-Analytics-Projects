CREATE DATABASE PIZZADB;
USE PIZZADB;
Select * from pizza_sales;

##KPI's
#total revenue 
Select sum(total_price) as Total_Revenue from pizza_sales;
#average order value
Select SUM(total_price)/ COUNT(DISTINCT ORDER_ID )AS AVERAGE_ORDER_VALUE FROM PIZZA_SALES;
# Total Pizza Sold
Select sum(quantity) as Total_Pizza_Sold from pizza_sales;
#Total Order Placed
Select count(distinct order_id)as Total_Order_Placed from pizza_sales;
# Average Pizza Per Order
Select Round(Sum(quantity)/count(distinct order_id),2) as Average_pizza_per_Order from pizza_sales;

##Information for the charts
# day wise total order
Select dayname(order_date) as order_day, count(distinct order_id) as Total_orders from pizza_sales 
group by dayname(order_date);
# month wise total orders
SELECT 
    MONTHNAME(order_date) AS order_month,
    COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY Total_orders desc;
# percentage of sales by pizza category
SELECT 
    pizza_category,
    ROUND(
        SUM(total_price) * 100 /
        (SELECT SUM(total_price)
         FROM pizza_sales
         WHERE MONTH(order_date) = 1),
    2) AS Total_Sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;
#percentage of sales by pizza size
SELECT 
    pizza_size,
    ROUND(
        SUM(total_price) * 100 /
        (SELECT SUM(total_price)
         FROM pizza_sales
        ),
    2) AS Total_Sales
FROM pizza_sales
GROUP BY pizza_size
order by Total_sales desc;
# top 5 pizza seller
Select pizza_name,round(sum(total_price),2) as Total_revenue from pizza_sales 
group by pizza_name 
order by Total_revenue desc
limit 5;
#bottom 5 pizza
Select pizza_name,round(sum(total_price),2) as Total_revenue from pizza_sales 
group by pizza_name 
order by Total_revenue 
limit 5;
#top 5 pizza by quantity
Select pizza_name,sum(quantity) as Total_quantity from pizza_sales 
group by pizza_name 
order by Total_quantity desc
limit 5;
#bottom 5 pizza by quantity
Select pizza_name,sum(quantity) as Total_quantity from pizza_sales 
group by pizza_name 
order by Total_quantity
limit 5;