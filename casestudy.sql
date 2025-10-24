-----case study
----customer retention - who comes back?
SELECT c.full_name,
MIN (o.order_date) AS first_order,
MAX(o.order_date) AS  last_order,
COUNT(DISTINCT o.order_date) AS visit_days
FROM orders o
JOIN customers c USING (customer_id)
GROUP BY c.full_name
HAVING COUNT (DISTINCT o.order_date) > 1
ORDER BY visit_days DESC;

---Basket Analysis -Common Item Pairs
SELECT m1.item_name AS item_a,
m2.item_name AS item_b,
COUNT(*) AS times_bought_together
FROM orders o1
JOIN orders o2 ON o1.order_id <> o2.order_id
AND o1.customer_id = o2.customer_id
AND o1.order_date = o2.order_date
JOIN menu_items m1 ON o1.item_id = m1.item_id
JOIN menu_items m2 ON o2.item_id = m2.item_id
WHERE m1.item_name < m2.item_name
GROUP BY item_a, item_b
ORDER BY times_bought_together DESC
LIMIT 10;

SELECT customer_id, order_date, COUNT(*) AS items_bought
FROM orders
GROUP BY customer_id, order_date
HAVING COUNT(*) > 1;

---month over month revenue growth
WITH monthly_sales AS(
SELECT TO_CHAR(order_date,'YYYY-MM') AS month,
SUM (total_amount) AS total_sales
FROM orders
GROUP BY 1
)
SELECT month,
total_sales,
ROUND((total_sales - LAG (total_sales) OVER(ORDER BY month))
/ LAG(total_sales) OVER (ORDER BY month) * 100, 2) AS growth_pct
FROM monthly_sales;

---menu profitabilty
SELECT m.item_name,
ROUND(SUM (o.total_amount) - SUM(o.total_amount)*0.6,2) AS profit
FROM orders o
JOIN menu_items m USING (item_id)
GROUP BY m.item_name
ORDER BY profit DESC;


---CUSTOMER SEGMENTATION BY SPEND TIER
SELECT full_name,
SUM(total_amount) AS total_spent,
CASE
WHEN SUM (total_amount) >= 150 THEN 'High'
WHEN SUM(total_amount) BETWEEN 80 AND 149  THEN 'Medium'
ELSE 'Low'
END AS spend_tier
FROM customers c
JOIN orders o USING (customer_id)
GROUP BY full_name
ORDER BY total_spent DESC;