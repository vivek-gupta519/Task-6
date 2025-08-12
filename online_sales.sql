-- 1️⃣ Create the table
CREATE TABLE online_sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

-- 2️⃣ Load CSV data (make sure CSV is placed in /var/lib/mysql-files/ or your MySQL secure folder)
LOAD DATA INFILE '/var/lib/mysql-files/online_sales.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_date, amount, product_id);

-- 3️⃣ Monthly Sales Trend Analysis with Month Names
SELECT
    YEAR(order_date) AS order_year,
    MONTHNAME(order_date) AS order_month,
    CONCAT(YEAR(order_date), '-', LPAD(MONTH(order_date), 2, '0')) AS period,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY order_year, MONTH(order_date), order_month, period
ORDER BY order_year, MONTH(order_date);
