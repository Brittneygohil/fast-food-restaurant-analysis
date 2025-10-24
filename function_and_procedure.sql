
----analytical views
--restaurant performance 
CREATE OR REPLACE VIEW restaurant_summary AS
SELECT
r.name AS restaurant,
COUNT (o.order_id) AS total_orders,
ROUND(SUM(o.total_amount), 2) AS total_revenue,
ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
GROUP BY r.name;

SELECT *FROM restaurant_summary ORDER BY total_revenue DESC;

--category wise revenue
CREATE OR REPLACE VIEW category_revenue AS
SELECT m.category,
ROUND (SUM(o.total_amount), 2) AS total_sales,
COUNT (o.order_id) AS total_orders
FROM orders o
JOIN menu_items m USING(item_id)
GROUP BY m.category
ORDER BY total_sales DESC;

SELECT *FROM category_revenue ORDER BY total_sales DESC;

---Customer loyalty snapshot
CREATE OR REPLACE VIEW customer_loyalty AS
SELECT c.full_name,
COUNT(o.order_id) AS total_orders,
ROUND (SUM(o.total_amount), 2) AS total_spent,
MAX(o.order_date) AS last_order,
CURRENT_DATE - MAX (o.order_date) AS days_since_last_order
FROM customers c
JOIN orders o USING (customer_id)
GROUP BY c.full_name
ORDER BY total_spent DESC;

SELECT *FROM customer_loyalty ORDER BY total_spent DESC;


---monthly revennue summary
CREATE MATERIALIZED VIEW monthly_revenue_summary AS
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
ROUND(SUM(total_amount), 2) AS total_revenue
FROM orders
GROUP BY 1
ORDER BY month;

REFRESH MATERIALIZED VIEW monthly_revenue_summary;
SELECT * FROM monthly_revenue_summary;

--city level sales snapshot
CREATE MATERIALIZED VIEW city_sales_summary AS
SELECT
c.city,
ROUND(SUM(o.total_amount),2) AS total_sales,
COUNT(DISTINCT c.customer_id) AS unique_customers,
ROUND(SUM(o.total_amount) / COUNT(DISTINCT c.customer_id),2) AS avg_spend_per_customer
FROM customers c
JOIN orders o USING (customer_id)
GROUP BY c.city
ORDER BY total_sales DESC;

REFRESH MATERIALIZED VIEW city_sales_summary;
SELECT * FROM city_sales_summary;


---monthly sales by restaurant-function
CREATE OR REPLACE FUNCTION get_monthly_sales(restaurant_name TEXT)
RETURNS TABLE(
month TEXT,
total_sales NUMERIC
)
AS $$
BEGIN 
RETURN QUERY
SELECT TO_CHAR (o.order_date, 'YYYY-MM') AS month,
SUM(o.total_amount) AS total_sales
FROM orders o
JOIN menu_items m USING (item_id)
JOIN restaurants r USING (restaurant_id)
WHERE r.name = restaurant_name
GROUP BY 1
ORDER BY 1;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_monthly_sales ('Chick-fil-A');


---FUNCTION:CUSTOMER SPEND REPORT

CREATE OR REPLACE FUNCTION get_customer_spend(city_name TEXT)
RETURNS TABLE(
customer_name TEXT,
total_spent NUMERIC,
avg_order_value NUMERIC
)
AS $$
BEGIN
RETURN QUERY
SELECT 
c.full_name:: TEXT,
SUM(o.total_amount),
AVG(o.total_amount)
FROM customers c
JOIN orders o USING (customer_id)
WHERE c.city = city_name
GROUP BY c.full_name
ORDER BY total_spent DESC;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_customer_spend('Oshawa');
