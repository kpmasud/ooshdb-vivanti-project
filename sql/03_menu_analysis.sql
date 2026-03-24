-- =============================================================================
-- PROJECT  : Ooshman Food Business — PostgreSQL Analysis
-- FILE     : sql/03_menu_analysis.sql
-- PURPOSE  : Menu performance, category revenue, best sellers, pricing
-- =============================================================================

-- Q1: Revenue by category
SELECT c.category_name,
       COUNT(DISTINCT mi.menu_item_id)            AS item_count,
       SUM(oi.quantity)                           AS total_qty_sold,
       ROUND(SUM(oi.line_total)::NUMERIC, 2)      AS total_revenue,
       ROUND(AVG(mi.price)::NUMERIC, 2)           AS avg_item_price
FROM order_items oi
JOIN menu_items mi  ON oi.menu_item_id  = mi.menu_item_id
JOIN categories c   ON mi.category_id   = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;


-- Q2: Top 15 best-selling items by quantity
SELECT mi.menu_item_name,
       c.category_name,
       ROUND(mi.price::NUMERIC, 2)           AS price,
       SUM(oi.quantity)                      AS total_qty_sold,
       ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue
FROM order_items oi
JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
JOIN categories c  ON mi.category_id  = c.category_id
GROUP BY mi.menu_item_name, c.category_name, mi.price
ORDER BY total_qty_sold DESC
LIMIT 15;


-- Q3: Top 15 highest revenue items
SELECT mi.menu_item_name,
       c.category_name,
       ROUND(mi.price::NUMERIC, 2)           AS price,
       SUM(oi.quantity)                      AS total_qty_sold,
       ROUND(SUM(oi.line_total)::NUMERIC, 2) AS total_revenue
FROM order_items oi
JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
JOIN categories c  ON mi.category_id  = c.category_id
GROUP BY mi.menu_item_name, c.category_name, mi.price
ORDER BY total_revenue DESC
LIMIT 15;


-- Q4: Category revenue share (%)
SELECT c.category_name,
       ROUND(SUM(oi.line_total)::NUMERIC, 2)      AS total_revenue,
       ROUND(SUM(oi.line_total) * 100.0 /
           SUM(SUM(oi.line_total)) OVER (), 1)    AS revenue_pct
FROM order_items oi
JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
JOIN categories c  ON mi.category_id  = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;


-- Q5: Price range by category — avg, min, max
SELECT c.category_name,
       COUNT(mi.menu_item_id)             AS item_count,
       ROUND(MIN(mi.price)::NUMERIC, 2)  AS min_price,
       ROUND(AVG(mi.price)::NUMERIC, 2)  AS avg_price,
       ROUND(MAX(mi.price)::NUMERIC, 2)  AS max_price
FROM menu_items mi
JOIN categories c ON mi.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_price DESC;


-- Q6: Items ordered per order (basket size) by category
SELECT c.category_name,
       ROUND(AVG(oi.quantity)::NUMERIC, 2)       AS avg_qty_per_order_item,
       ROUND(AVG(oi.line_total)::NUMERIC, 2)     AS avg_line_total,
       COUNT(DISTINCT oi.order_id)               AS orders_containing
FROM order_items oi
JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
JOIN categories c  ON mi.category_id  = c.category_id
GROUP BY c.category_name
ORDER BY orders_containing DESC;
