Use pizzahut

Select * from pizzas
Select * from pizza_types2
Select * from orders
Select * from order_details

--------------------- Advance Questions -----------------------

-- Q.1 Calculate the percentage contribution of each pizza type to total revenue.
Select pizza_types2.category , ROUND(SUM(order_details.quantity * pizzas.price) * 100 /
(Select SUM(order_details.quantity * pizzas.price) From order_details JOIN pizzas 
ON order_details.pizza_id = pizzas.pizza_id),2) AS revenue From order_details 
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types2 ON pizza_types2.pizza_type_id = pizzas.pizza_type_id
Group by pizza_types2.category Order by revenue Desc

-- Q.2 Analyze the cumulative revenue generated over time.
Select date ,ROUND(SUM(revenue) Over(Order by date),2) As cum_revenue From
(Select orders.date, SUM(order_details.quantity * pizzas.price) AS revenue From orders 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id 
Group by orders.date) AS sales

-- Q.3 Determine the top 3 most ordered pizza types based on revenue for each pizza category.
Select category ,name, revenue From
(Select category, name, revenue, Rank() Over(Partition by category Order by revenue Desc) as rank_num From 
(Select pizza_types2.category, pizza_types2.name, ROUND(SUM(order_details.quantity * pizzas.price),2) AS revenue 
From pizza_types2 JOIN pizzas ON pizza_types2.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
Group by pizza_types2.name , pizza_types2.category) as a) as b Where rank_num <=3












