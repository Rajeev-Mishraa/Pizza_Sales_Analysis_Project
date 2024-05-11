Create database pizzahut
Use pizzahut
Select * from pizzas
Select * from pizza_types2
Select * from orders
Select * from order_details

-- To Check the data types of columns
Select * from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pizzas'

-----------  BASIS 5 QUESTIONS  -------------------------

-- Quest-1 Retrieve the total number of orders placed.
Select count(order_id) as total_orders from orders

-- Q.2 Calculate the total revenue generated from pizza sales.
Select round(sum(pizzas.price * order_details.quantity),2) As total_revenue from pizzas 
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id

-- Q.3 Identify the highest-priced pizza.
Select TOP 1 pizza_types2.name, pizzas.price from pizza_types2 
Join pizzas on pizza_types2.pizza_type_id = pizzas.pizza_type_id order by pizzas.price desc

-- Q.4 Identify the most common pizza size ordered.
Select pizzas.size, count(order_details.order_details_id) As order_count  from pizzas
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id group by pizzas.size
Order by order_count desc

-- Q.5 List the top 5 most ordered pizza types along with their quantities. (Used double JOIN)

Select TOP 5 pizza_types2.name, SUM(order_details.quantity) AS quantity_ordered From pizza_types2 
JOIN pizzas ON pizza_types2.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id 
Group by pizza_types2.name
Order by quantity_ordered Desc
