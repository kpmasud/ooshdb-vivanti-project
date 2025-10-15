--- Load 1 Million Customer and Orders data into ooshdb 
-- Check data of customer 

SELECT * FROM customers;

--- Remove all rows from customer table 

DELETE FROM customers;

 -- Check again
 
SELECT * FROM customers;
 
-- Check orders table 
SELECT * FROM orders;

-- Remove data from table 

DELETE FROM orders;

-- final check 


SELECT * FROM orders;


SELECT * FROM order_items;


SELECT * FROM menu_items;


SELECT * FROM customers;

SELECT COUNT(*) AS customers_rows FROM customers;


/*
\copy customers(shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) FROM '/Users/masudrana/Desktop/ooshdb/customers_1M.csv' WITH (FORMAT csv, HEADER true); ooshdb=# \copy customers(shop_id, customer_id, first_name, last_name, mobile, email, gender, date_of_birth, address) FROM '/Users/masudrana/Desktop/ooshdb/customers_1M.csv' WITH (FORMAT csv, HEADER true);
COPY 1000000
ooshdb=# \copy orders(shop_id, customer_id, order_id, order_datetime, payment_id, order_value) FROM '/Users/masudrana/Desktop/ooshdb/orders_1M.csv' WITH (FORMAT csv, HEADER true);
ERROR:  date/time field value out of range: "19-1-2023 17:06"
HINT:  Perhaps you need a different "datestyle" setting.
CONTEXT:  COPY orders, line 2, column order_datetime: "19-1-2023 17:06"
ooshdb=# \copy orders(shop_id, customer_id, order_id, order_datetime, payment_id, order_value) FROM '/Users/masudrana/Desktop/ooshdb/orders_1M.csv' WITH (FORMAT csv, HEADER true);
ERROR:  date/time field value out of range: "19/1/2023 17:06"
HINT:  Perhaps you need a different "datestyle" setting.
CONTEXT:  COPY orders, line 2, column order_datetime: "19/1/2023 17:06"
ooshdb=# \copy orders(shop_id, customer_id, order_id, order_datetime, payment_id, order_value) FROM '/Users/masudrana/Desktop/ooshdb/orders_1M.csv' WITH (FORMAT csv, HEADER true);
ooshdb=# \copy orders(shop_id, customer_id, order_id, order_datetime, payment_id, order_value) FROM '/Users/masudrana/Desktop/ooshdb/orders_1M_fixed.csv' WITH (FORMAT csv, HEADER true);

COPY 1000000

ooshdb=# \copy order_items (order_item_id, menu_item_id, order_id, quantity, unit_price, line_total) FROM '/Users/masudrana/Desktop/ooshdb/order_items_500k.csv' WITH (FORMAT csv, HEADER true);

 */


SELECT * FROM orders;


Select * from customers;


SELECT * FROM menu_items;



