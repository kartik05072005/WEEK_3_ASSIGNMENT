-- =========================================
-- 1. Top 5 Customers
-- =========================================

WITH customer_sales AS
(
SELECT
`Customer ID`,
SUM(Sales) AS total_sales
FROM orders
GROUP BY `Customer ID`
)
SELECT
c.`Customer Name`,
cs.total_sales
FROM customers c
JOIN customer_sales cs
ON c.`Customer ID` = cs.`Customer ID`
ORDER BY cs.total_sales DESC
LIMIT 5;

-- =========================================
-- 2. Bottom 5 Customers
-- =========================================

WITH customer_sales AS
(
SELECT
`Customer ID`,
SUM(Sales) AS total_sales
FROM orders
GROUP BY `Customer ID`
)
SELECT
c.`Customer Name`,
cs.total_sales
FROM customers c
JOIN customer_sales cs
ON c.`Customer ID` = cs.`Customer ID`
ORDER BY cs.total_sales ASC
LIMIT 5;

-- =========================================
-- 3. Customers Who Made Only One Order
-- =========================================

SELECT
`Customer ID`,
COUNT(`Order ID`) AS total_orders
FROM orders
GROUP BY `Customer ID`
HAVING COUNT(`Order ID`) = 1;

-- =========================================
-- 4. Customers With Above Average Sales
-- =========================================

WITH customer_sales AS
(
SELECT
`Customer ID`,
SUM(Sales) AS total_sales
FROM orders
GROUP BY `Customer ID`
)
SELECT *
FROM customer_sales
WHERE total_sales >
(
SELECT AVG(total_sales)
FROM customer_sales
);

-- =========================================
-- 5. Highest Order Value Per Customer
-- =========================================

SELECT
    c.`Customer Name`,
    o.`Customer ID`,
    MAX(o.Sales) AS highest_order_value
FROM orders o
JOIN customers c
ON o.`Customer ID` = c.`Customer ID`
GROUP BY c.`Customer Name`, o.`Customer ID`;
