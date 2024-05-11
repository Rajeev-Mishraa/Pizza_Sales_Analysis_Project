Use pizzahut

Select * from pizzas
Select * from pizza_types2
Select * from orders
Select * from order_details

---------------------  Intermediary Questions -----------------------

-- Q.1 Join the necessary tables to find the total quantity of each pizza category ordered.
Select pizza_types2.category, SUM(order_details.quantity) AS total_quantity From pizza_types2 
JOIN pizzas ON pizza_types2.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
Group by pizza_types2.category Order by total_quantity Desc

-- Q.2 Determine the distribution of orders by hour of the day.
Select DATEPART(hour, order_time) AS order_hours, Count(order_id) As num_of_orders From orders
Group by DATEPART(hour, order_time) Order by num_of_orders Desc

-- Q.3 Join relevant tables to find the category-wise distribution of pizzas.
Select category, COUNT(name) As num_of_pizzas From pizza_types2 Group by  category 
Order by num_of_pizzas Desc

-- Q.4 Group the orders by date and calculate the average number of pizzas ordered per day.
Select Avg(quantity_sum) As avg_pizza_ordered 
From (Select orders.date, SUM(order_details.quantity) As quantity_sum 
From orders JOIN order_details 
ON orders.order_id = order_details.order_id Group by orders.date) AS order_quantity

-- Q.5 Determine the top 5 most ordered pizza types based on revenue.
Select Top 5 pizza_types2.name, Round(SUM(order_details.quantity * pizzas.price),2) as total_sales From order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types2 ON pizzas.pizza_type_id = pizza_types2.pizza_type_id 
Group by pizza_types2.name  order by total_sales desc








