# Below written are specific tasks and queries

#-- 2.Analyze the cumulative revenue generated over time. 

SELECT order_date,round(sum((order_details.quantity*pizzas.price)),0) AS Tot_revenue
FROM 
order_details 
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN orders ON orders.order_id = order_details.order_id
GROUP BY orders.order_date;

-- now i have got revenues per day, but it felt simple so i am gonna modify it to gove me revenue per month.

SELECT 
    MONTH(order_date),
    ROUND(SUM((order_details.quantity * pizzas.price)),
            0) AS Tot_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    orders ON orders.order_id = order_details.order_id
GROUP BY MONTH(orders.order_date);

