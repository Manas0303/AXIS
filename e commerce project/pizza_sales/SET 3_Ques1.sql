# Below written are specific tasks and queries

#-- 1.Calculate the percentage contribution of each pizza category to total revenue. 

 SELECT 
    Pizza_TYPE, CONCAT(Percent_contri, ' %') AS Percent_contri
FROM
    (SELECT 
        pizza_types.category AS Pizza_TYPE,
            ROUND(ROUND(SUM(pizzas.price * order_details.quantity), 0) * 100 / 
				(SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price)) AS Total_price 
                FROM
                    pizza_types														-- Treat a subquery as the output a query gives, use it accordingly
                JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
                JOIN order_details ON order_details.pizza_id = pizzas.pizza_id), 2) AS Percent_contri
    FROM
        pizza_types
    JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category) AS Price_of_types;
    
# Below are tries and mistakes i made while figuring the query.

/*  Mistake_1

--- Initially hardcoded query in which the total revenue is put manually

SELECT Pizza_TYPE,CONCAT(Percent_contri, ' %') AS Percent_contri FROM
(SELECT pizza_types.category AS Pizza_TYPE,round(round(sum(pizzas.price*order_details.quantity),0) * 100 / 817858,2) AS Percent_contri
		FROM pizza_types JOIN pizzas 
		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
			JOIN order_details
			ON order_details.pizza_id = pizzas.pizza_id
	GROUP BY pizza_types.category)
    AS Price_of_types ;
    
*/
 
 
 /*  Mistake_2

Initial inefficient total revenue query which gave categorywise revenues

SELECT pizza_types.category, round(sum(order_details.quantity*pizzas.price)) AS Total_price
FROM pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;

*/

/*  Mistake_3

Revamped total revenue query

SELECT round(sum(order_details.quantity*pizzas.price)) AS Total_price
FROM pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id; 

*/

/* Lessons from above query

    -- . I learned here that while using a query the aliases are important, otherwise error is observed.
    -- . Revised how to use CONCAT function ..... 
					-- The CONCAT() function in SQL is used to combine two or more strings into one.
	-- . It is tricky to understand round function in complex codes ' (ROUND(number, decimal_places) ' is the basic syntax.
	-- . Using the subquery in efficient way
					-- Treat a subquery as the output a query gives, use it accordingly
	-- . There are many times a subquery is not required, deducing those makes the queries efficient.
    
*/

 
 
    
  