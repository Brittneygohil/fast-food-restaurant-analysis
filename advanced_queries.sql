--monthly revenue trend
SELECT TO_CHAR(order_date, 'YYYY-MM')AS month,
ROUND(SUM(total_amount),2) AS total_revenue
FROM orders
GROUP BY TO_CHAR(order_date,'YYYY-MM')
ORDER BY month;

--customer loyalty- for who ordered food most often

SELECT c.full_name,
COUNT(o.order_id) AS order_count,
SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o USING (customer_id)
GROUP BY c.full_name
ORDER BY order_count DESC
LIMIT 10;

--Restaurant with highest avg order value
SELECT r.name,
ROUND (AVG(o.total_amount),2) AS avg_order_value
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY r.name
ORDER BY avg_order_value DESC
LIMIT 1;

--Category-Wise Revenue Pr Restaurant
SELECT r.name AS restaurant,
m.category,
ROUND(SUM(o.total_amount),20)AS total_sales
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants  r USING (restaurant_id)
GROUP BY r.name, M.category
ORDER BY r.name, total_sales DESC;

--customer spending rank within each city
SELECT city,
full_name,
SUM(total_amount) AS total_spent,
RANK() OVER (PARTITION BY city ORDER BY SUM(total_amount)DESC)AS city_rank
FROM customers c
JOIN orders o USING (customer_id)
GROUP BY city, full_name
ORDER BY city, city_rank;

---find items never ordered
SELECT item_name
FROM menu_items
WHERE item_id NOT IN(SELECT DISTINCT item_id FROM orders);

--percentage contributation of each restaurant to total revenue

SELECT c.full_name,
COUNT (DISTINCT r.name) AS restaurant_count
FROM orders o
JOIN customers c USING (customer_id)
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY c.full_name
HAVING COUNT(DISTINCT r.name) > 1;

--find highest revenue day for each restaurant
SELECT restaurant,
order_date,
daily_sales
FROM( 
SELECT r.name AS restaurant,
o.order_date,
SUM(o.total_amount)AS daily_sales,
RANK() OVER (PARTITION BY r.name ORDER BY SUM(o.total_amount)DESC)AS rk
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY r.name, o.order_date
) ranked
WHERE rk = 1
ORDER BY restaurant;
