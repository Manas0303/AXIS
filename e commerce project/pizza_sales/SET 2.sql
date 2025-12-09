# Below written are specific tasks and queries


#-- 1.Join the necessary tables to find the total quantity of each pizza category ordered. 

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS Quantity1
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Quantity1 DESC;


#-- 2.Determine the distribution of orders by hour of the day. 


SELECT 
    HOUR(orders.order_time) AS Distri_hour,
    COUNT(order_id) AS No_of_orders
FROM												# SELECT hour(column_name) is the syntax which is used.
    orders											# GROUP BY HOUR(column name)  with a combo of this
GROUP BY HOUR(orders.order_time)
ORDER BY Distri_hour ASC;


#-- 3.Join relevant tables to find the category-wise distribution of pizzas. (how many types of pizza in each category)

# trick question, no joining required

SELECT count(name) AS Types_pizza,category
FROM pizza_types
GROUP BY category;


#-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.
					-- (use of subquery)

SELECT round(AVG(Pizzas_per_day),0) FROM                    
	(SELECT sum(order_details.quantity) AS Pizzas_per_day,orders.order_date AS DATE_
	FROM order_details JOIN orders
	ON order_details.order_id = orders.order_id
	GROUP BY orders.order_date) 
AS order_quantity;

/* I used this syntax before, it worked but no need to make it complex. The above syntax is short and sweet.
						(For selecting dates, hours etc)
SELECT sum(order_details.quantity) AS Pizzas_per_day,DATE(orders.order_date) AS DATE_
FROM order_details JOIN orders
ON order_details.order_id = orders.order_id
GROUP BY DATE (orders.order_date);
*/


#-- 5.Determine the top 3 most ordered pizza types based on revenue. 

SELECT pizza_types.name,sum(order_details.quantity*pizzas.price) AS Aggr_price
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id =  pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id =  pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Aggr_price DESC LIMIT 3;

-- A combination of all the functions used above and easy use of multiple join with group by.


