# Below written are specific tasks and queries

#-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT pizza_types.name,pizza_types.category,SUM(order_details.quantity*pizzas.price) AS Revenue
FROM
pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
			JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name, pizza_types.category 
ORDER BY Revenue DESC 
LIMIT 3;

-- But this query gives only first 3 responses whereas i want first three of each category. New adjusted query below :

SELECT*FROM
(SELECT name,category, RANK() OVER(PARTITION BY category ORDER BY REVENUE DESC)AS RN
FROM
(SELECT pizza_types.name,pizza_types.category,SUM(order_details.quantity*pizzas.price) AS Revenue
FROM
pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
			JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name, pizza_types.category 
ORDER BY Revenue DESC) AS AA) AS BB
WHERE RN <= 3;

-- What did i learn.

-- The use of partition function.
-- How to rank some set of data to use it in comparision purposes.
-- Putting up multiple subqueries.