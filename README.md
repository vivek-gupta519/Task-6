# Sales Trend Analysis Using MySQL

## Objective
Analyze **monthly revenue** and **order volume** from the `online_sales` dataset using MySQL.

---

## Dataset
The dataset used here is `online_sales.csv` which contains:

| Column       | Description                        |
|--------------|------------------------------------|
| order_id     | Unique ID for each order           |
| order_date   | Date when the order was placed     |
| amount       | Order amount in USD                |
| product_id   | Product identifier                 |

Example record:  
order_id,order_date,amount,product_id  
1001,2023-01-05,250.00,1

---

## MySQL Steps

### 1. Create the table
```sql
CREATE TABLE online_sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

LOAD DATA INFILE '/var/lib/mysql-files/online_sales.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_date, amount, product_id);

SELECT
    YEAR(order_date) AS order_year,
    MONTHNAME(order_date) AS order_month,
    CONCAT(YEAR(order_date), '-', LPAD(MONTH(order_date), 2, '0')) AS period,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY order_year, MONTH(order_date), order_month, period
ORDER BY order_year, MONTH(order_date);

Example Output
order_year	order_month	period	total_revenue	order_volume
2023	January	2023-01	93,221.84	337
2023	February	2023-02	79,423.52	280
...	...	...	...	...

Visualization
The following chart was generated to visualize the monthly trend:


Outcome
By completing this task, we learn how to:

Group sales data by year and month in MySQL

Calculate total revenue using SUM()

Calculate order volume using COUNT(DISTINCT ...)

Sort and format the results for reporting
