SELECT * FROM pizza_types;
SELECT * FROM orders;
SELECT * FROM pizzas;
SELECT * FROM order_details;



-- Basic:
-- Retrieve the total number of orders placed.
	SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM orders;

-- Calculate the total revenue generated from pizza sales.
	SELECT ROUND(SUM(oi.quantity * p.price), 2) AS Total_Revenue FROM order_details oi
	JOIN pizzas p ON oi.pizza_id = p.pizza_id 
	
-- Identify the highest-priced pizza.
	SELECT * FROM pizzas
	WHERE price = (SELECT MAX(price) FROM pizzas)

-- Identify the most common pizza size ordered.
	SELECT TOP 1 COUNT(order_id) AS Total_Orders, p.size FROM order_details oi
	JOIN pizzas p ON
	oi.pizza_id = p.pizza_id
	group by p.size
	ORDER BY Total_Orders DESC

-- List the top 5 most ordered pizza types along with their quantities.
	SELECT TOP 5 pt.pizza_type_id, pt.name, SUM(oi.quantity) Total_Qty FROM order_details oi
	JOIN pizzas p ON oi.pizza_id = p.pizza_id
	JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
	GROUP BY pt.pizza_type_id, pt.name
	ORDER BY Total_Qty desc
	
-- 	Intermediate:

-- Join the necessary tables to find the total quantity of each pizza category ordered.
	SELECT pt.category, SUM(oi.quantity) AS Total_Qty FROM order_details oi
	JOIN pizzas p ON oi.pizza_id = p.pizza_id
	JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
	GROUP BY pt.category
	ORDER BY Total_Qty DESC

-- Determine the distribution of orders by hour of the day.
	SELECT 
	DATEPART(HOUR, time) as Hour_oF_Day,
	COUNT(order_id) AS Total_Orders
	FROM orders
	GROUP BY DATEPART(HOUR, time)
	ORDER BY Hour_oF_Day

-- Join relevant tables to find the category-wise distribution of pizzas.
	SELECT category, COUNT(pizza_type_id) FROM pizza_types
	GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
	
	SELECT ROUND(AVG(Qty), 0), order_Date FROM 
	(
	SELECT
	o.date as order_Date,
	SUM(od.quantity) as Qty
	FROM order_details od
	JOIN orders o
	ON od.order_id = o.order_id
	GROUP BY o.date
	) AS order_Qty;
	
-- Determine the top 3 most ordered pizza types based on revenue.
	SELECT TOP 3 pt.pizza_type_id, pt.name, SUM(oi.quantity) as Total_Qty, SUM(oi.quantity * p.price) as Total_Revenue
	FROM order_details oi
	JOIN pizzas p ON oi.pizza_id = p.pizza_id
	JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
	GROUP BY pt.pizza_type_id, pt.name
	ORDER BY Total_Revenue desc



	SELECT * FROM orders

-- 	Advanced:
-- Calculate the percentage contribution of each pizza category type to total revenue.

	SELECT pt.category, ROUND(SUM(od.quantity * p.price) / 
				(SELECT SUM(od.quantity * p.price) FROM order_details od
				join pizzas p on od.pizza_id = p.pizza_id
	) * 100,2) as [Rev%]
	FROM order_details od
	JOIN pizzas p
	ON od.pizza_id = p.pizza_id
	join pizza_types pt
	ON p.pizza_type_id = pt.pizza_type_id
	group by pt.category
	ORDER BY [Rev%] DESC

-- Analyze the cumulative revenue generated over time.

	SELECT date, 
	round(SUM(Revenue) OVER(ORDER BY date),2) as Cum_Total
	from
	(
	SELECT o.date, SUM(od.quantity * p.price) AS Revenue 
	FROM order_details od
	join orders o
	on od.order_id = o.order_id
	join pizzas p 
	on od.pizza_id = p.pizza_id
	group by o.date
	) as sales

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT category, name, revenue from
		(SELECT category, name, revenue, 
		RANK() OVER(PARTITION BY category ORDER BY revenue DESC) as rn
		from
			(SELECT pt.category, pt.name, SUM(od.quantity * p.price) AS revenue
			from order_details od
			join pizzas p
			on od.pizza_id = p.pizza_id
			join pizza_types pt
			on p.pizza_type_id = pt.pizza_type_id
			GROUP BY pt.category, pt.name)
		AS a) 
	AS b
where rn <= 3;



