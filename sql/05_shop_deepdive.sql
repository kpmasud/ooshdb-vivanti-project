-- =============================================================================
-- PROJECT  : Ooshman Food Business — PostgreSQL Analysis
-- FILE     : sql/05_shop_deepdive.sql
-- PURPOSE  : Shop vs shop comparison, staff, top items per shop
-- =============================================================================

-- Q1: Shop performance — full KPI comparison
SELECT s.name AS shop_name,
       COUNT(DISTINCT o.customer_id)            AS unique_customers,
       COUNT(o.order_id)                        AS total_orders,
       ROUND(SUM(o.order_value)::NUMERIC, 2)    AS total_revenue,
       ROUND(AVG(o.order_value)::NUMERIC, 2)    AS avg_order_value,
       ROUND(SUM(o.order_value) * 100.0 /
           SUM(SUM(o.order_value)) OVER (), 1)  AS revenue_share_pct
FROM orders o
JOIN shops s ON o.shop_id = s.shop_id
GROUP BY s.shop_id, s.name
ORDER BY total_revenue DESC;


-- Q2: Monthly revenue per shop (trend lines)
SELECT DATE_TRUNC('month', o.order_datetime)::DATE AS month,
       s.name                                      AS shop_name,
       COUNT(o.order_id)                           AS orders,
       ROUND(SUM(o.order_value)::NUMERIC, 2)       AS revenue
FROM orders o
JOIN shops s ON o.shop_id = s.shop_id
GROUP BY month, s.name
ORDER BY month, s.name;


-- Q3: Top 5 best-selling items per shop
WITH ranked AS (
    SELECT s.name AS shop_name,
           mi.menu_item_name,
           SUM(oi.quantity)                      AS total_qty,
           ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue,
           RANK() OVER (
               PARTITION BY s.shop_id
               ORDER BY SUM(oi.quantity) DESC
           ) AS rnk
    FROM order_items oi
    JOIN orders o    ON oi.order_id     = o.order_id
    JOIN shops s     ON o.shop_id       = s.shop_id
    JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
    GROUP BY s.shop_id, s.name, mi.menu_item_name
)
SELECT shop_name, menu_item_name, total_qty, total_revenue
FROM ranked WHERE rnk <= 5
ORDER BY shop_name, rnk;


-- Q4: Staff count and role breakdown by shop
SELECT s.name AS shop_name,
       st.role,
       COUNT(*) AS staff_count
FROM staff st
JOIN shops s ON st.shop_id = s.shop_id
GROUP BY s.name, st.role
ORDER BY s.name, st.role;


-- Q5: Payment method preference by shop
SELECT s.name AS shop_name,
       pm.payment_method_name,
       COUNT(o.order_id)                         AS orders,
       ROUND(COUNT(o.order_id) * 100.0 /
           SUM(COUNT(o.order_id)) OVER
               (PARTITION BY s.shop_id), 1)      AS pct
FROM orders o
JOIN shops s          ON o.shop_id    = s.shop_id
JOIN payment_methods pm ON o.payment_id = pm.payment_id
GROUP BY s.shop_id, s.name, pm.payment_method_name
ORDER BY s.name, orders DESC;


-- Q6: Average order value per shop by year
SELECT EXTRACT(YEAR FROM o.order_datetime)::INT AS year,
       s.name                                   AS shop_name,
       COUNT(o.order_id)                        AS orders,
       ROUND(AVG(o.order_value)::NUMERIC, 2)    AS avg_order_value,
       ROUND(SUM(o.order_value)::NUMERIC, 2)    AS total_revenue
FROM orders o
JOIN shops s ON o.shop_id = s.shop_id
GROUP BY year, s.shop_id, s.name
ORDER BY year, s.name;
