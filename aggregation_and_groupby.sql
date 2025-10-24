--AGGREGATION & GROUP BY
--count number of order per restaurant

SELECT r.name AS restaurant, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN menu_items m ON o.item_id =m.item_id
JOIN restaurants r ON m.restaurant_id =r.restaurant_id
GROUP BY r.name
ORDER BY total_orders DESC;

--find total sales per restaurant
SELECT r.name AS restaurant, SUM(o.total_amount) AS total_sales
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY r.name
ORDER BY total_sales DESC;

--Average order value per city
SELECT c.city, ROUND(AVG(o.total_amount),2)AS avg_order_value
FROM orders o
JOIN customers c USING (customer_id)
GROUP BY c.city;

--level 3 - subqueries and Ranking
--finding the highest-spending customer overall

SELECT full_name, SUM(total_amount) AS total_spent
FROM customers c
JOIN orders o USING (customer_id)
GROUP BY full_name
ORDER BY total_spent DESC
LIMIT 1;

---find the second-highest total sales restaurant

SELECT name, total_sales FROM(
SELECT r.name, SUM(o.total_amount)AS total_sales,
	RANK() OVER (ORDER BY SUM (o.total_amount) DESC)AS rank 
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY r.name
)ranked 
WHERE rank =2;
