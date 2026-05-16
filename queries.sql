CREATE DATABASE retail_project_db;

USE retail_project_db;

CREATE TABLE retail_data (
    invoice_no VARCHAR(20),
    customer_id VARCHAR(20),
    gender VARCHAR(10),
    age INT,
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    payment_method VARCHAR(20),
    invoice_date DATE,
    shopping_mall VARCHAR(100)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_shopping_data.csv'
INTO TABLE retail_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@invoice_no, @customer_id, @gender, @age, @category, @quantity, @price, @payment_method, @invoice_date, @shopping_mall)
SET invoice_no = @invoice_no,
    customer_id = @customer_id,
    gender = @gender,
    age = @age,
    category = @category,
    quantity = @quantity,
    price = @price,
    payment_method = @payment_method,
    invoice_date = STR_TO_DATE(@invoice_date, '%d-%m-%Y'),
    shopping_mall = @shopping_mall;
    
SELECT COUNT(*) FROM retail_data;

SELECT SUM(quantity * price) AS total_sales
FROM retail_data;

SELECT COUNT(DISTINCT invoice_no) AS total_orders
FROM retail_data;

SELECT category, SUM(quantity * price) AS sales
FROM retail_data
GROUP BY category
ORDER BY sales DESC;

SELECT gender, SUM(quantity * price) AS sales
FROM retail_data
GROUP BY gender;

SELECT payment_method, COUNT(*) AS total_orders
FROM retail_data
GROUP BY payment_method;

SELECT 
     MONTH(invoice_date) AS month,
     SUM(quantity * price) AS sales
FROM retail_data
GROUP BY month
ORDER BY month;

SELECT shopping_mall, SUM(quantity * price) AS sales
FROM retail_data
GROUP BY shopping_mall
ORDER BY sales DESC
LIMIT 5;

SELECT 
    CASE 
       WHEN age < 20 THEN 'Teen'
       WHEN age BETWEEN 20 AND 40 THEN 'Young'
       WHEN age BETWEEN 41 AND 60 THEN 'Adult'
       ELSE 'Senior'
	END AS age_group,
    COUNT(*) AS customers
FROM retail_data
GROUP BY age_group;

SELECT category, SUM(quantity * price) AS total_quantity
FROM retail_data
GROUP BY category
ORDER BY total_quantity DESC
LIMIT 5;

SELECT invoice_date, SUM(quantity * price) AS sales
FROM retail_data
GROUP BY invoice_date
ORDER BY invoice_date;

SELECT * FROM retail_data LIMIT 10;

SELECT customer_id, category, quantity, price
FROM retail_data
LIMIT 10;

DESCRIBE retail_data;
