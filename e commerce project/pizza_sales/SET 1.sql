# Below written are specific tasks and queries

# Set 1 (BASIC) 

-- 1.Retrieve the total number of orders placed. 

select count(order_id) as total_orders from orders;


-- 2.Calculate the total revenue generated from pizza sales. 

SELECT sum(price) as total_revenue from pizzas;			# This is valid since all quantities = 1 but it is invalid otherwise.alter

		# More viable query with quantity calculation.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),2) 
    AS total_sales
FROM
    order_details
JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
    
-- 3.Identify the highest-priced pizza. 

SELECT pizza_types.name,pizzas.price
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id			 # Join should be 'on' the common column as done here	
ORDER BY pizzas.price DESC LIMIT 1;							 # If limit not added it will print all the rows


/* Just wanted to try how can i put unique vvalues as without limit pizza types are repeating, below is the query

SELECT DISTINCT pizza_types.name, pizzas.price,pizzas.pizza_type_id,pizzas.size
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id			 
ORDER BY pizzas.price DESC;					

# The result concludes that the types are not repeating and it is a combo of type and size of pizza. */


-- 4.Identify the most common pizza size ordered. 

SELECT pizzas.size, count(order_details.order_details_id) AS Most_ordered
FROM pizzas JOIN order_details
on pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size ORDER BY Most_ordered DESC;

/* 		Display the joined table to understand logic of above query

SELECT pizzas.pizza_id,pizzas.size,order_details.quantity	 
FROM pizzas JOIN order_details
on pizzas.pizza_id = order_details.pizza_id;

*/

-- 5.List the top 5 most ordered pizza types along with their quantities. 

SELECT pizza_types.name, sum(order_details.quantity) AS Most_ordered
FROM pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details 													# Here we had to perform a triple join as no common columns were present
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name ORDER BY Most_ordered DESC LIMIT 5;