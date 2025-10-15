-- Database: ooshdb
--
-- DROP DATABASE IF EXISTS ooshdb;

CREATE DATABASE ooshdb
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

	-- Business Questions Answer General 

	--1. Which shops generates the highest total sales ?

	--
-- Check Shops Table 
SELECT * FROM shops;

--Check Orders Table 
SELECT * FROM orders;

-- Check Order_items Table 
SELECT * FROM order_items;

-- Answer to the question 1

SELECT s.shop_id, s.shop_name, s.suburb, s.postcode, s.state, ROUND(SUM(o.order_value),2) 
AS total_sales
FROM shops s
JOIN orders o
ON s.shop_id = o.shop_id 
GROUP BY s.shop_id, s.shop_name, s.suburb, s.postcode, s.state
ORDER BY total_sales DESC;



--2.During which hours are most orders placed each day? 

SELECT EXTRACT (HOUR FROM order_datetime) AS order_hour,
COUNT (order_id) AS total_orders

FROM orders
GROUP BY order_hour
ORDER BY total_orders DESC;


SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM order_datetime) BETWEEN 6 AND 11 THEN 'Morning (6AM–11AM)'
        WHEN EXTRACT(HOUR FROM order_datetime) BETWEEN 12 AND 17 THEN 'Afternoon (12PM–5PM)'
        WHEN EXTRACT(HOUR FROM order_datetime) BETWEEN 18 AND 22 THEN 'Evening (6PM–10PM)'
        ELSE 'Late Night (11PM–5AM)'
    END AS time_period,
    COUNT(order_id) AS total_orders
FROM 
    orders
GROUP BY 
    time_period
ORDER BY 
    total_orders DESC;


