--JOINS AND DATE ANALYSIS
---show all orders with restaurant, item, and customer info

SELECT o.order_id, r.name AS restaurant, m.item_name,c.full_name, o.order_date, o.total_amount
FROM orders o
JOIN customers c USING (customer_id)
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
ORDER BY o.order_date;

--find daily total revenue across all restaurants
SELECT order_date, SUM(total_amount) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- top 3 selling menu items pr restaurant

SELECT name AS restaurant,
item_name,
SUM(quantity)as total_sold
from orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY name, item_name
ORDER BY name, total_sold DESC;

--to see just the top 3 per restaurant:
SELECT restaurant, item_name, total_sold
FROM(
SELECT r.name AS restaurant,
m.item_name,
SUM (o.quantity) AS total_sold,
RANK() OVER(PARTITION BY r.name ORDER BY SUM(o.quantity)DESC)AS rk
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY r.name, m.item_name
) ranked
WHERE rk <=3

--monthly revenue trend
SELECT TO_CHAR(order_date, 'YYYY-MM')AS month,
ROUND(SUM(total_amount),2) AS total_revenue
FROM orders
GROUP BY TO_CHAR(order_date,'YYYY-MM')
ORDER BY month;
