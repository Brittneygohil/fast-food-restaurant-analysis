ant_id = r.restaurant_id
WHERE r.name = 'Chick-fil-A';

SELECT m.item_name, m.price
FROM menu_items m
JOIN restaurants r ON m.restaurant_id = r.restaurant_id
WHERE r.name = 'Harvey''s';

SELECT m.item_name, m.price
FROM menu_items m
JOIN restaurants r ON m.restaurant_id =r.restaurant_id
WHERE r.name = 'McDonald''s';

--get all customers from Oshawa
SELECT full_name, age
FROM customers
WHERE city= 'Oshawa';

--find orders placed before/after july 1st,2025

SELECT order_id, order_date,total_amount
FROM orders
WHERE order_date > '2025-07-01'
ORDER BY order_date;

SELECT order_id, order_date, total_amount
FROM orders
WHERE order_date < '2025-07-01'
ORDER BY order_date;