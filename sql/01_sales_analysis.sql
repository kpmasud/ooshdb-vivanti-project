-- =============================================================================
-- PROJECT  : Ooshman Food Business — PostgreSQL Analysis
-- FILE     : sql/01_sales_analysis.sql
-- PURPOSE  : Revenue trends, shop performance, payment methods, order values
-- =============================================================================

-- Q1: Total revenue and order count by shop
SELECT s.name AS shop_name,
       s.suburb,
       COUNT(o.order_id)               AS total_orders,
       ROUND(SUM(o.order_value)::NUMERIC, 2) AS total_revenue,
       ROUND(AVG(o.order_value)::NUMERIC, 2) AS avg_order_value
FROM orders o
JOIN shops s ON o.shop_id = s.shop_id
GROUP BY s.shop_id, s.name, s.suburb
ORDER BY total_revenue DESC;


-- Q2: Monthly revenue trend (all shops combined)
SELECT DATE_TRUNC('month', order_datetime)::DATE AS month,
       COUNT(*)                                   AS total_orders,
       ROUND(SUM(order_value)::NUMERIC, 2)        AS total_revenue,
       ROUND(AVG(order_value)::NUMERIC, 2)        AS avg_order_value
FROM orders
GROUP BY month
ORDER BY month;


-- Q3: Revenue by payment method
SELECT pm.payment_method_name,
       COUNT(o.order_id)                      AS total_orders,
       ROUND(SUM(o.order_value)::NUMERIC, 2)  AS total_revenue,
       ROUND(COUNT(o.order_id) * 100.0 /
           SUM(COUNT(o.order_id)) OVER (), 1) AS order_pct
FROM orders o
JOIN payment_methods pm ON o.payment_id = pm.payment_id
GROUP BY pm.payment_method_name
ORDER BY total_revenue DESC;


-- Q4: Order value distribution — bracket breakdown
SELECT
    CASE
        WHEN order_value < 20          THEN 'Under $20'
        WHEN order_value BETWEEN 20 AND 39.99 THEN '$20 – $39'
        WHEN order_value BETWEEN 40 AND 59.99 THEN '$40 – $59'
        WHEN order_value BETWEEN 60 AND 99.99 THEN '$60 – $99'
        ELSE '$100+'
    END                               AS value_band,
    COUNT(*)                          AS orders,
    ROUND(COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (), 1)     AS pct,
    ROUND(AVG(order_value)::NUMERIC, 2) AS avg_value
FROM orders
GROUP BY value_band
ORDER BY MIN(order_value);


-- Q5: Monthly revenue by shop (for multi-line trend)
SELECT DATE_TRUNC('month', o.order_datetime)::DATE AS month,
       s.name AS shop_name,
       ROUND(SUM(o.order_value)::NUMERIC, 2)       AS revenue
FROM orders o
JOIN shops s ON o.shop_id = s.shop_id
GROUP BY month, s.name
ORDER BY month, s.name;


-- Q6: Revenue by delivery method
SELECT dm.delivery_method_name,
       COUNT(o.order_id)                      AS total_orders,
       ROUND(SUM(o.order_value)::NUMERIC, 2)  AS total_revenue,
       ROUND(AVG(o.order_value)::NUMERIC, 2)  AS avg_order_value,
       ROUND(COUNT(o.order_id) * 100.0 /
           SUM(COUNT(o.order_id)) OVER (), 1) AS order_pct
FROM orders o
JOIN delivery_methods dm ON o.delivery_method_id = dm.delivery_id
GROUP BY dm.delivery_method_name
ORDER BY total_orders DESC;
