# E-Commerce Sales Analytics — SQL Case Study

## 📌 Project Overview

This project focuses on analyzing an e-commerce sales dataset using Microsoft SQL Server (T-SQL).

The objective is to explore sales performance, revenue generation, customer satisfaction, payment behavior, product categories, and regional performance using SQL.

The analysis progresses from basic business metrics to advanced SQL techniques such as CTEs, subqueries, CASE statements, DENSE_RANK(), and window functions.

---

## 🎯 Business Objective

The main objective of this project is to transform raw e-commerce sales data into meaningful business insights by answering key analytical questions related to:

- Sales and revenue performance
- Product category performance
- Customer satisfaction
- Payment method behavior
- Monthly sales trends
- Regional performance
- Discount impact
- Revenue contribution

---

## 🛠️ Tools & Technologies

- **Database:** Microsoft SQL Server
- **Language:** T-SQL
- **Data Analysis:** SQL
- **Documentation:** Markdown
- **Presentation:** PowerPoint

---

## 📊 SQL Analysis Performed

### Basic Analysis

1. **Total Orders**
   - Analyzed the overall number of orders placed in the dataset.

2. **Total Revenue**
   - Evaluated the overall revenue generated from sales.

3. **Highest-Priced Product**
   - Identified the highest unit price within the product portfolio.

4. **Average Customer Rating**
   - Evaluated overall customer satisfaction using average ratings.

5. **Quantity Sold by Product Category**
   - Analyzed sales volume across different product categories.

### Intermediate Analysis

6. **Revenue and AOV by Product Category**
   - Analyzed revenue generation and average order value across categories.

7. **Order Distribution by Payment Method**
   - Analyzed order distribution and revenue across payment methods.

8. **High-Revenue Product Categories**
   - Identified product categories generating more than $1 million in revenue.

9. **Monthly Revenue Trend**
   - Analyzed monthly revenue trends to evaluate sales performance over time.

10. **Payment Methods with Above-Average AOV**
    - Identified payment methods associated with higher-than-average order values.

### Advanced Analysis

11. **Top Product Category per Region**
    - Identified the highest-revenue product category within each region.
    - **Technique:** CTE + DENSE_RANK()

12. **Revenue Contribution by Product Category**
    - Analyzed each product category's contribution to overall revenue.
    - **Technique:** Window Function

13. **Discount Impact on Customer Ratings**
    - Analyzed how different discount levels relate to customer ratings.
    - **Technique:** CASE WHEN + Subquery

14. **Monthly Revenue Trend with Cumulative Revenue**
    - Analyzed monthly revenue performance and cumulative revenue growth.
    - **Technique:** CTE + Window Function

---

## 🧠 SQL Concepts Demonstrated

This project demonstrates practical application of:

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- Aggregate Functions
- COUNT()
- SUM()
- AVG()
- MAX()
- ROUND()
- HAVING
- Subqueries
- CTEs
- CASE WHEN
- DENSE_RANK()
- Window Functions
- PARTITION BY
- Running Totals
- Date Functions
- Conditional Analysis

---

