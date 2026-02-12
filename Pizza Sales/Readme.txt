Project Overview

This project analyzes pizza sales data using Microsoft SQL Server.
The objective is to explore sales performance, customer ordering behavior, and product trends using relational database concepts

 Dataset Structure

The database consists of four related tables:

1️. Orders:
   
order_id
order_date
order_time

2️. Order_Details

order_details_id
order_id
pizza_id
quantity

3️. Pizzas

pizza_id
pizza_type_id
size
price

4️. Pizza_Types
pizza_type_id
name
category
ingredients

Relationships:

Orders → Order_Details (1 to many)
Pizzas → Order_Details (1 to many)
Pizza_Types → Pizzas (1 to many)


Project Objectives

Calculate total revenue
Identify top-selling pizzas
Analyze revenue by category
Determine peak sales hours
Identified the most popular pizza sizes
Evaluate order quantity patterns

SQL Concepts Used

INNER JOIN
GROUP BY & HAVING
Aggregate Functions (SUM, COUNT, AVG)
Subqueries
Date & Time analysis
Sorting & ranking logic

 Key Insights

Identified the highest revenue-generating pizza types
Determined the most popular pizza sizes
Found peak ordering hours
Analyzed revenue contribution by category

 Skills Demonstrated

Relational database understanding
Business-focused data analysis
Query optimization
Insight extraction from structured data
