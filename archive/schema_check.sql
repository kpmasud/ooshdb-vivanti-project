

-- Check the schema of the database

SELECT    table_name,   
          column_name, 
          data_type
FROM      information_schema.columns
WHERE     
table_schema        = 'public'
AND    
table_catalog       = 'ooshdb';

-- Check the constraints of the tables
SELECT    tc.table_schema, 
          tc.table_name, 
          kcu.column_name, 
          tc.constraint_type, 
          ccu.table_schema AS foreign_table_schema,
          ccu.table_name AS foreign_table_name,
          ccu.column_name AS foreign_column_name
FROM      information_schema.table_constraints AS tc
JOIN      information_schema.key_column_usage AS kcu
  ON      tc.constraint_name = kcu.constraint_name
  AND     tc.table_schema = kcu.table_schema
LEFT JOIN information_schema.constraint_column_usage AS ccu
  ON      ccu.constraint_name = tc.constraint_name
  AND     ccu.table_schema = tc.table_schema
WHERE     tc.table_schema = 'public'
AND       tc.table_catalog = 'ooshdb'
ORDER BY  tc.table_name,
          kcu.column_name;  


-- Check the foreign key relationships between tables

SELECT    conname AS constraint_name,
          conrelid::regclass AS table_from,
          a.attname AS column_from,
          confrelid::regclass AS table_to,
          af.attname AS column_to
FROM      pg_constraint
JOIN      pg_attribute a ON a.attnum = ANY (conkey) AND a.attrelid = conrelid
JOIN      pg_attribute af ON af.attnum = ANY (confkey) AND af.attrelid = confrelid
WHERE     contype = 'f'
AND       connamespace = 'public'::regnamespace
AND       conrelid IN (SELECT oid FROM pg_class WHERE relname IN (
    'shops', 'categories', 'menu_items', 'customers', 'orders', 'order_items', 'payment_methods', 'staff'))
ORDER BY  conrelid::regclass::text,
          a.attname;     

-- Check the number of rows in each table

SELECT    relname AS table_name,
          n_live_tup AS row_count
FROM      pg_stat_user_tables
WHERE     schemaname = 'public'
AND       relname IN ('shops', 'categories', 'menu_items', 'customers', 'orders', 'order_items', 'payment_methods', 'staff')
ORDER BY  relname;

