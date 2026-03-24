-- =============================================================================
-- PROJECT  : Ooshman Food Business — PostgreSQL Analysis
-- FILE     : sql/02_customer_analysis.sql
-- PURPOSE  : Customer demographics, order frequency, spending patterns
-- =============================================================================

-- Q1: Customer age group distribution
SELECT
    CASE
        WHEN DATE_PART('year', AGE(date_of_birth)) < 18  THEN 'Under 18'
        WHEN DATE_PART('year', AGE(date_of_birth)) < 25  THEN '18 – 24'
        WHEN DATE_PART('year', AGE(date_of_birth)) < 35  THEN '25 – 34'
        WHEN DATE_PART('year', AGE(date_of_birth)) < 45  THEN '35 – 44'
        WHEN DATE_PART('year', AGE(date_of_birth)) < 60  THEN '45 – 59'
        ELSE '60+'
    END                   AS age_group,
    COUNT(*)              AS customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
FROM customers
WHERE date_of_birth IS NOT NULL
GROUP BY age_group
ORDER BY MIN(DATE_PART('year', AGE(date_of_birth)));


-- Q2: Order frequency — how many orders per customer
WITH order_counts AS (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders GROUP BY customer_id
)
SELECT
    CASE
        WHEN order_count = 1  THEN '1 order'
        WHEN order_count <= 3 THEN '2 – 3 orders'
        WHEN order_count <= 5 THEN '4 – 5 orders'
        WHEN order_count <= 10 THEN '6 – 10 orders'
        ELSE '10+ orders'
    END                  AS frequency_band,
    COUNT(*)             AS customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct
FROM order_counts
GROUP BY frequency_band
ORDER BY MIN(order_count);


-- Q3: Gender split by shop
SELECT s.name AS shop_name,
       c.gender,
       COUNT(DISTINCT o.customer_id) AS customers,
       COUNT(o.order_id)             AS orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN shops s     ON o.shop_id     = s.shop_id
GROUP BY s.name, c.gender
ORDER BY s.name, c.gender;


-- Q4: Top 10 highest-spending customers
SELECT o.customer_id,
       c.first_name || ' ' || c.last_name        AS customer_name,
       COUNT(o.order_id)                          AS total_orders,
       ROUND(SUM(o.order_value)::NUMERIC, 2)      AS total_spent,
       ROUND(AVG(o.order_value)::NUMERIC, 2)      AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;


-- Q5: Average spend by age group
SELECT
    CASE
        WHEN DATE_PART('year', AGE(c.date_of_birth)) < 18  THEN 'Under 18'
        WHEN DATE_PART('year', AGE(c.date_of_birth)) < 25  THEN '18 – 24'
        WHEN DATE_PART('year', AGE(c.date_of_birth)) < 35  THEN '25 – 34'
        WHEN DATE_PART('year', AGE(c.date_of_birth)) < 45  THEN '35 – 44'
        WHEN DATE_PART('year', AGE(c.date_of_birth)) < 60  THEN '45 – 59'
        ELSE '60+'
    END                                             AS age_group,
    COUNT(DISTINCT o.customer_id)                   AS customers,
    ROUND(AVG(o.order_value)::NUMERIC, 2)           AS avg_order_value,
    ROUND(SUM(o.order_value)::NUMERIC, 2)           AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE c.date_of_birth IS NOT NULL
GROUP BY age_group
ORDER BY MIN(DATE_PART('year', AGE(c.date_of_birth)));


-- Q6: New customers registered by month (growth trend)
SELECT DATE_TRUNC('month', o.order_datetime)::DATE AS month,
       COUNT(DISTINCT o.customer_id)               AS unique_customers,
       COUNT(o.order_id)                           AS total_orders,
       ROUND(AVG(o.order_value)::NUMERIC, 2)       AS avg_spend
FROM orders o
GROUP BY month
ORDER BY month;
