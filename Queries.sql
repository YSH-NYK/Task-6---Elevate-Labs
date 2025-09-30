-- Step 1: Create Database and Table
CREATE DATABASE sales_analysis;

USE sales_analysis;

CREATE TABLE online_sales (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    country VARCHAR(50),
    product_name VARCHAR(100),
    order_date DATE,
    amount DECIMAL(10, 2),
    quantity INT
);

-- Step 2: Load Data from CSV
LOAD DATA LOCAL INFILE 'C:/xampp/mysql/data/sales_analysis/online_sales.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(order_id, customer_name, country, product_name, @order_date, amount, quantity)
SET order_date = STR_TO_DATE(@order_date, '%d-%m-%y');

-- Step 3: Verify Data Load
SELECT COUNT(*) FROM online_sales;

-- Step 4: Verify Data
SELECT * FROM online_sales LIMIT 10;

-- Step 5: Check Column Names
SHOW COLUMNS FROM online_sales;

-- ANALYSIS QUERIES

-- Query 1: Basic Monthly Revenue and Order Volume
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year, month
ORDER BY year, month;

-- Query 2: Monthly Revenue with Average Order Value
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM online_sales
GROUP BY year, month
ORDER BY year, month;

-- Query 3: Quarterly Analysis
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    QUARTER(order_date) AS quarter,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year, quarter
ORDER BY year, quarter;

-- Query 4: Top 5 Revenue Months
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year, month
ORDER BY total_revenue DESC
LIMIT 5;

-- Query 5: Specific Time Period Analysis (2022 only)
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue
FROM online_sales
WHERE YEAR(order_date) = 2022
GROUP BY year, month
ORDER BY year, month;

-- Query 6: Monthly Product Sales Count
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    COUNT(DISTINCT product_name) AS unique_products,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year, month
ORDER BY year, month;

-- Query 7: Export Monthly Sales Results to CSV
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS order_volume,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM online_sales
GROUP BY year, month
ORDER BY year, month
INTO OUTFILE 'C:/temp/monthly_sales_results.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Query 8: Overall Statistics
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_order_value,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM online_sales;