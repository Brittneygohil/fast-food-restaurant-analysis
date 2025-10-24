-RFM ANALYSIS( recency, frequency, monetory value) model to classify customers.
WITH rfm AS(
SELECT c.customer_id,
c.full_name,
MAX(o.order_date) AS last_order,
COUNT(o.order_id) AS frequency,
SUM(o.total_amount) AS monetary
FROM customers c
JOIN orders o USING (customer_id)
GROUP BY c.customer_id,c.full_name
)
SELECT full_name,
CURRENT_DATE - last_order AS recency_days,
frequency,
ROUND(monetary, 2) AS total_spent,
CASE
WHEN monetary > 150 THEN 'High Value'
WHEN monetary BETWEEN 80 AND 150 THEN 'Medium Value'
ELSE 'Low Value'
END AS customer_segment
FROM rfm
ORDER BY total_spent DESC

---Dynamic KPI Summary -using CASE for flexibility
SELECT 
COUNT(DISTINCT customer_id) AS total_customers,
COUNT(DISTINCT order_id) AS total_orders,
ROUND(SUM(total_amount), 2) AS total_revenue,
ROUND(AVG(total_amount), 2) AS avg_order_value,
SUM(CASE WHEN total_amount > 20 THEN 1 ELSE 0 END) AS high_value_orders
FROM orders;