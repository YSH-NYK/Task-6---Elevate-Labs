# Sales Trend Analysis Using Aggregations

## 📊 Project Overview

This project demonstrates SQL aggregation techniques to analyze sales trends over time. The analysis focuses on monthly revenue patterns, order volumes, and business metrics using the `online_sales` dataset.

## 🎯 Objective

Analyze monthly revenue and order volume to identify:
- Sales trends over time
- Peak revenue periods
- Average order values
- Quarterly performance
- Product diversity in sales

## 🛠️ Tools Used

- **Database**: MariaDB/MySQL
- **Dataset**: online_sales.csv
- **Skills**: SQL Aggregations, Date Functions, Grouping

## 📋 Database Schema

### Table: `online_sales`

| Column | Type | Description |
|--------|------|-------------|
| order_id | INT | Primary key, unique order identifier |
| customer_name | VARCHAR(100) | Customer name |
| country | VARCHAR(50) | Customer country |
| product_name | VARCHAR(100) | Product purchased |
| order_date | DATE | Date of order |
| amount | DECIMAL(10,2) | Order amount in currency |
| quantity | INT | Quantity ordered |

## 🔍 Analysis Performed

### 1. **Database Setup**
   - Created `sales_analysis` database
   - Created `online_sales` table with appropriate schema
   - Loaded 1,894 records from CSV file using `LOAD DATA LOCAL INFILE`

### 2. **Data Verification**
   - Verified record count: 1,894 rows
   - Checked table structure using `SHOW COLUMNS`
   - Previewed sample data with `LIMIT 10`

### 3. **Basic Monthly Revenue and Order Volume**
   - Extracted year and month from order dates using `EXTRACT()`
   - Calculated monthly order volume with `COUNT(DISTINCT order_id)`
   - Computed total revenue per month with `SUM(amount)`
   - Grouped by year and month, ordered chronologically

### 4. **Monthly Revenue with Average Order Value**
   - Extended basic analysis to include `AVG(amount)`
   - Rounded average order value to 2 decimal places
   - Average order value ranged from $5,307.63 to $6,357.97

### 5. **Quarterly Analysis**
   - Grouped data by quarters using `QUARTER(order_date)`
   - Analyzed seasonal trends across Q1, Q2, and Q3 2022
   - Q1 2022: $2,344,965 (395 orders)
   - Q2 2022: $2,292,087 (416 orders)
   - Q3 2022: $1,546,573 (283 orders - partial)

### 6. **Top 5 Revenue Months**
   - Sorted by `total_revenue DESC` and limited to 5 results
   - January 2022 was the highest revenue month: $896,105 (154 orders)
   - Followed by June, July, May, and March

### 7. **Specific Time Period Analysis (2022 only)**
   - Filtered data using `WHERE YEAR(order_date) = 2022`
   - Analyzed all 8 months of available 2022 data
   - Consistent analysis format for focused period

### 8. **Monthly Product Sales Count**
   - Added `COUNT(DISTINCT product_name)` to track product diversity
   - Found consistent 22 unique products across all months
   - Combined with order volume and revenue metrics

### 9. **Data Export**
   - Exported analysis results using `INTO OUTFILE`
   - Created `monthly_sales_results.csv` with comma delimiters
   - Included year, month, order volume, total revenue, and average order value

### 10. **Overall Statistics**
   - Calculated summary statistics across entire dataset:
     - Total orders: 1,894
     - Total revenue: $6,183,625.00
     - Average order value: $5,652.31
     - Date range: January 3, 2022 to August 31, 2022

## 📊 Key Findings

### Revenue Trends
- **Total Revenue**: $6,183,625.00 over 8 months
- **Peak Month**: January 2022 ($896,105.00)
- **Lowest Month**: February 2022 ($699,377.00)
- **Average Monthly Revenue**: $772,953.13

### Order Patterns
- **Total Orders**: 1,894 orders
- **Average Orders/Month**: 237 orders
- **Peak Volume**: June 2022 (163 orders)
- **Lowest Volume**: February 2022 (110 orders)

### Business Metrics
- **Average Order Value**: $5,652.31
- **Highest AOV**: February 2022 ($6,357.97)
- **Lowest AOV**: June 2022 ($5,307.63)
- **Product Range**: 22 unique products consistently

### Quarterly Performance
1. **Q1 2022**: $2,344,965.00 (395 orders)
2. **Q2 2022**: $2,292,087.00 (416 orders)
3. **Q3 2022**: $1,546,573.00 (283 orders - partial quarter)

## 🔑 SQL Techniques Used

### Date Functions
- `EXTRACT(YEAR FROM order_date)` - Extract year from date
- `EXTRACT(MONTH FROM order_date)` - Extract month from date
- `QUARTER(order_date)` - Get quarter number (1-4)
- `YEAR(order_date)` - Alternative year extraction for WHERE clause
- `STR_TO_DATE(@date, '%d-%m-%y')` - Parse date format during CSV load

### Aggregate Functions
- `COUNT(DISTINCT order_id)` - Count unique orders
- `COUNT(DISTINCT product_name)` - Count unique products
- `SUM(amount)` - Calculate total revenue
- `AVG(amount)` - Calculate average order value
- `ROUND(value, 2)` - Round to 2 decimal places
- `MIN(order_date)` - Find earliest date
- `MAX(order_date)` - Find latest date

### Grouping & Sorting
- `GROUP BY year, month` - Group data by time period
- `GROUP BY year, quarter` - Group by quarter
- `ORDER BY year, month` - Sort chronologically
- `ORDER BY total_revenue DESC` - Sort by revenue (highest first)

### Filtering
- `WHERE YEAR(order_date) = 2022` - Filter specific year
- `LIMIT 5` - Restrict result count

### Data Export
- `INTO OUTFILE 'filepath'` - Export query results to CSV
- `FIELDS TERMINATED BY ','` - Set field delimiter
- `ENCLOSED BY '"'` - Enclose fields in quotes
- `LINES TERMINATED BY '\n'` - Set line terminator