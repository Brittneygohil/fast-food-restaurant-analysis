create table restaurants(
restaurant_id INT PRIMARY KEY,
name VARCHAR(50),
location VARCHAR(50),
opening_year INT
);

create table menu_items(
item_id INT PRIMARY KEY,
restaurant_id INT REFERENCES restaurants(restaurant_id),
item_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(6,2)
);

CREATE TABLE customers(
customer_id INT PRIMARY KEY,
full_name VARCHAR(100),
gender VARCHAR(10),
age INT,
city VARCHAR(50)
);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT REFERENCES customers(customer_id),
item_id INT REFERENCES menu_items(item_id),
order_date DATE,
quantity INT,
total_amount DECIMAL(8,2)
);