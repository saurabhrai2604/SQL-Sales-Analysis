-- ====================================================================
-- E-COMMERCE SALES ANALYTICS - SQL CASE STUDY
-- Database Engine: Microsoft SQL Server (T-SQL)
-- Target Table: dbo.ECommerce_Sales_Analytics
-- ====================================================================


-- ====================================================================
-- SECTION 1: BASIC ANALYSIS
-- ====================================================================

-- 1. Total Orders
-- Business Objective:
-- Analyze the overall number of orders placed in the dataset.

SELECT COUNT(order_id) AS total_orders
FROM dbo.ECommerce_Sales_Analytics;


-- 2. Total Revenue
-- Business Objective:
-- Evaluate the overall revenue generated from sales.

SELECT ROUND(SUM(revenue), 2) AS total_revenue
FROM dbo.ECommerce_Sales_Analytics;


-- 3. Highest-Priced Product
-- Business Objective:
-- Identify the highest unit price within the product portfolio.

SELECT MAX(unit_price) AS max_unit_price
FROM dbo.ECommerce_Sales_Analytics;


-- 4. Average Customer Rating
-- Business Objective:
-- Evaluate overall customer satisfaction using average ratings.

SELECT ROUND(AVG(customer_rating), 2) AS avg_customer_rating
FROM dbo.ECommerce_Sales_Analytics;


-- 5. Quantity Sold by Product Category
-- Business Objective:
-- Analyze sales volume across different product categories.

SELECT 
    product_category,
    SUM(quantity) AS total_quantity_sold
FROM dbo.ECommerce_Sales_Analytics
GROUP BY product_category
ORDER BY total_quantity_sold DESC;


-- ====================================================================
-- SECTION 2: INTERMEDIATE ANALYSIS
-- ====================================================================

-- 6. Revenue and AOV by Product Category
-- Business Objective:
-- Analyze revenue generation and average order value across categories.

SELECT 
    product_category,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(revenue), 2) AS avg_order_value
FROM dbo.ECommerce_Sales_Analytics
GROUP BY product_category
ORDER BY total_revenue DESC;


-- 7. Order Distribution by Payment Method
-- Business Objective:
-- Analyze order distribution and revenue across payment methods.

SELECT 
    payment_method,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM dbo.ECommerce_Sales_Analytics
GROUP BY payment_method
ORDER BY total_orders DESC;


-- 8. High-Revenue Product Categories
-- Business Objective:
-- Identify product categories generating more than $1 million in revenue.

SELECT 
    product_category,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM dbo.ECommerce_Sales_Analytics
GROUP BY product_category
HAVING SUM(revenue) > 1000000
ORDER BY total_revenue DESC;


-- 9. Monthly Revenue Trend
-- Business Objective:
-- Analyze monthly revenue trends to evaluate sales performance over time.

SELECT 
    YEAR(order_date) AS sales_year,
    MONTH(order_date) AS sales_month,
    ROUND(SUM(revenue), 2) AS monthly_revenue
FROM dbo.ECommerce_Sales_Analytics
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY sales_year, sales_month;


-- 10. Payment Methods with Above-Average AOV
-- Business Objective:
-- Identify payment methods associated with higher-than-average order values.

SELECT 
    payment_method,
    ROUND(AVG(revenue), 2) AS avg_payment_aov
FROM dbo.ECommerce_Sales_Analytics
GROUP BY payment_method
HAVING AVG(revenue) > (
    SELECT AVG(revenue)
    FROM dbo.ECommerce_Sales_Analytics
)
ORDER BY avg_payment_aov DESC;


-- ====================================================================
-- SECTION 3: ADVANCED ANALYSIS
-- ====================================================================

-- 11. Top Product Category per Region
-- Technique: CTE + DENSE_RANK
-- Business Objective:
-- Identify the highest-revenue product category within each region.

WITH RankedCategories AS (
    SELECT 
        region,
        product_category,
        ROUND(SUM(revenue), 2) AS total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY region 
            ORDER BY SUM(revenue) DESC
        ) AS rnk
    FROM dbo.ECommerce_Sales_Analytics
    GROUP BY region, product_category
)
SELECT 
    region,
    product_category,
    total_revenue
FROM RankedCategories
WHERE rnk = 1
ORDER BY region;


-- 12. Revenue Contribution by Product Category
-- Technique: Window Function
-- Business Objective:
-- Analyze each product category's contribution to overall revenue.

SELECT 
    product_category,
    ROUND(SUM(revenue), 2) AS category_revenue,
    ROUND(
        (SUM(revenue) * 100.0) / 
        SUM(SUM(revenue)) OVER(), 
        2
    ) AS percentage_contribution
FROM dbo.ECommerce_Sales_Analytics
GROUP BY product_category
ORDER BY percentage_contribution DESC;


-- 13. Discount Impact on Customer Ratings
-- Technique: CASE WHEN
-- Business Objective:
-- Analyze how different discount levels relate to customer ratings.

SELECT 
    discount_category,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM (
    SELECT 
        customer_rating,
        CASE 
            WHEN discount = 0 THEN 'No discount'
            WHEN discount > 0 AND discount <= 0.10 THEN 'Low Discount'
            WHEN discount > 0.10 AND discount <= 0.20 THEN 'Medium Discount'
            ELSE 'High Discount'
        END AS discount_category
    FROM dbo.ECommerce_Sales_Analytics
) AS sub
GROUP BY discount_category
ORDER BY avg_rating DESC;


-- 14. Monthly Revenue Trend with Cumulative Revenue
-- Technique: CTE + Window Function
-- Business Objective:
-- Analyze monthly revenue performance and track cumulative revenue growth.

WITH MonthlySales AS (
    SELECT 
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(revenue) AS monthly_revenue
    FROM dbo.ECommerce_Sales_Analytics
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT 
    sales_year,
    sales_month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY sales_year, sales_month
        ), 
        2
    ) AS cumulative_revenue
FROM MonthlySales
ORDER BY sales_year, sales_month;


-- ====================================================================
-- END OF SQL SALES ANALYSIS
-- ====================================================================