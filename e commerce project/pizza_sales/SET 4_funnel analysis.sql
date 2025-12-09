-- So if i have to proceed with my current project which is on pizza sales by adding funnel analysis to it:

/*

1. Funnel Conversion: Orders → Payments → Deliveries

Problem: Track how many orders were placed, how many were successfully paid, and how many were delivered. Calculate the conversion percentage at each step.

SELECT 'Orders Placed' AS step, COUNT(DISTINCT order_id) AS total
FROM orders
UNION ALL
SELECT 'Orders Paid', COUNT(DISTINCT order_id)
FROM orders
WHERE status = 'Paid'
UNION ALL
SELECT 'Orders Delivered', COUNT(DISTINCT order_id)
FROM orders
WHERE status = 'Delivered';


2. Drop-off by Pizza Category in Funnel

Problem: For each pizza category, show how many pizzas were ordered vs. how many were actually delivered (conversion % by category).

SELECT pt.category,
       SUM(od.quantity) AS ordered_qty,
       SUM(CASE WHEN o.status = 'Delivered' THEN od.quantity ELSE 0 END) AS delivered_qty,
       ROUND(SUM(CASE WHEN o.status = 'Delivered' THEN od.quantity ELSE 0 END) * 100.0 /
             SUM(od.quantity), 2) AS conversion_rate
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
JOIN orders o ON o.order_id = od.order_id
GROUP BY pt.category;


3. Time-to-Conversion Funnel (Order Placed → Delivered)

Problem: Find the average delivery time per pizza category, i.e., how long it takes from placing the order to final delivery.

SELECT pt.category,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE, o.order_time, o.delivery_time)), 2) AS avg_delivery_time_minutes
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
JOIN orders o ON o.order_id = od.order_id
WHERE o.status = 'Delivered'
GROUP BY pt.category
ORDER BY avg_delivery_time_minutes;


4. Revenue Funnel by Order Size

Problem: Segment orders into Small (< $20), Medium ($20–$50), Large ($50+) and calculate how much revenue each segment contributes to the total funnel.

SELECT 
   CASE 
       WHEN SUM(p.price * od.quantity) < 20 THEN 'Small Orders (<$20)'
       WHEN SUM(p.price * od.quantity) BETWEEN 20 AND 50 THEN 'Medium Orders ($20-$50)'
       ELSE 'Large Orders (>$50)'
   END AS order_segment,
   COUNT(DISTINCT o.order_id) AS num_orders,
   ROUND(SUM(p.price * od.quantity),2) AS total_revenue,
   ROUND(SUM(p.price * od.quantity) * 100.0 / 
         (SELECT SUM(p2.price * od2.quantity)
          FROM pizzas p2
          JOIN order_details od2 ON p2.pizza_id = od2.pizza_id), 2) AS percent_of_total
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON p.pizza_id = od.pizza_id
GROUP BY order_segment
ORDER BY total_revenue DESC;

*/
