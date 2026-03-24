-- =============================================================================
-- PROJECT  : Ooshman Food Business — PostgreSQL Analysis
-- FILE     : sql/04_operations_analysis.sql
-- PURPOSE  : Peak hours, day of week, delivery trends, year-over-year growth
-- =============================================================================

-- Q1: Orders by hour of day (peak times)
SELECT EXTRACT(HOUR FROM order_datetime)::INT AS hour,
       COUNT(*)                               AS total_orders,
       ROUND(SUM(order_value)::NUMERIC, 2)    AS total_revenue,
       ROUND(AVG(order_value)::NUMERIC, 2)    AS avg_order_value
FROM orders
GROUP BY hour
ORDER BY hour;


-- Q2: Orders by day of week
SELECT TO_CHAR(order_datetime, 'Day')         AS day_name,
       EXTRACT(DOW FROM order_datetime)::INT  AS day_num,
       COUNT(*)                               AS total_orders,
       ROUND(SUM(order_value)::NUMERIC, 2)    AS total_revenue
FROM orders
GROUP BY day_name, day_num
ORDER BY day_num;


-- Q3: Year-over-year comparison (2023 vs 2024)
SELECT EXTRACT(YEAR FROM order_datetime)::INT  AS year,
       EXTRACT(MONTH FROM order_datetime)::INT AS month,
       COUNT(*)                                AS total_orders,
       ROUND(SUM(order_value)::NUMERIC, 2)     AS total_revenue
FROM orders
WHERE EXTRACT(YEAR FROM order_datetime) IN (2023, 2024)
GROUP BY year, month
ORDER BY year, month;


-- Q4: Delivery method trend by month
SELECT DATE_TRUNC('month', o.order_datetime)::DATE AS month,
       dm.delivery_method_name,
       COUNT(*)                                    AS orders
FROM orders o
JOIN delivery_methods dm ON o.delivery_method_id = dm.delivery_id
GROUP BY month, dm.delivery_method_name
ORDER BY month, dm.delivery_method_name;


-- Q5: Busiest weeks of the year (top 20)
SELECT DATE_TRUNC('week', order_datetime)::DATE AS week_start,
       COUNT(*)                                 AS total_orders,
       ROUND(SUM(order_value)::NUMERIC, 2)      AS total_revenue
FROM orders
GROUP BY week_start
ORDER BY total_orders DESC
LIMIT 20;


-- Q6: Hour × day of week heatmap (order volume)
SELECT EXTRACT(DOW  FROM order_datetime)::INT  AS day_num,
       TO_CHAR(order_datetime, 'Dy')           AS day_name,
       EXTRACT(HOUR FROM order_datetime)::INT  AS hour,
       COUNT(*)                                AS orders
FROM orders
GROUP BY day_num, day_name, hour
ORDER BY day_num, hour;
