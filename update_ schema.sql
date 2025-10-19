-- In our ooshdb databse delivery_methods table shoulb be connected with orders table
--- so we need to add foreign key constraint on orders table
--- referencing delivery_methods table
-- first lets have a look on the orders table

SELECT          * 
FROM            orders;

-- now lets have a look on the delivery_methods table

SELECT          *
FROM            delivery_methods;


-- now we can see that delivery_methods table has a primary key column called id
-- and orders table does not have any column to reference delivery_methods table
-- so we need to add a new column called delivery_method_id in orders table

ALTER TABLE             orders
ADD COLUMN              delivery_method_id INT; 

-- verify the changes

SELECT                  * 
FROM                    orders;

-- now we have added a new column called delivery_method_id in orders table
-- now we need to add foreign key constraint on orders table referencing delivery_methods table
-- referencing delivery_method_id column in orders table

ALTER TABLE             orders
ADD CONSTRAINT          orders_delivery_method_id_fkey 
FOREIGN KEY             (delivery_method_id)
REFERENCES              delivery_methods (id) 
ON UPDATE               CASCADE
ON DELETE               SET NULL;

-- didn't run the above command because of the error because it should be delivery_id not id: 


-- Check delivery_methods table structure
SELECT 
column_name,            data_type 
FROM                    information_schema.columns 
WHERE 
table_name              = 'delivery_methods';

-- Check orders table structure
SELECT 
column_name,            data_type 
FROM                    information_schema.columns 
WHERE 
table_name              = 'orders';

-- we can see that delivery_methods table has a primary key column called delivery_id
-- so we need to update the foreign key constraint on orders table
-- referencing delivery_methods table
-- referencing delivery_method_id column in orders table
-- so now we can see the correct foreign key constraint command

ALTER TABLE             orders
ADD CONSTRAINT          orders_delivery_method_id_fkey 
FOREIGN KEY             (delivery_method_id)
REFERENCES              delivery_methods (delivery_id) 
ON UPDATE               CASCADE
ON DELETE               SET NULL;

-- Check the foreign key constraint
-- we can check the foreign key constraint using information_schema
-- we can use the following query to check the foreign key constraint


SELECT                  tc.constraint_name, 
                        tc.table_name, 
                        kcu.column_name, 
                        ccu.table_name 
AS                      foreign_table_name,
                        ccu.column_name  
AS                      foreign_column_name 
FROM                    information_schema.table_constraints 
AS                      tc 
JOIN                    information_schema.key_column_usage 
AS                      kcu
ON                      
                        tc.constraint_name = kcu.constraint_name

JOIN                    information_schema.constraint_column_usage 
AS                      ccu
ON                     
                        ccu.constraint_name = tc.constraint_name

WHERE                   
                        tc.constraint_type = 'FOREIGN KEY' 

AND                    
                         tc.table_name = 'orders';

-- Now we have added foreign key constraint on orders table referencing delivery_methods table
-- referencing delivery_method_id column in orders table
-- so now we can see the foreign key constraint is added successfully   


-- verify the changes

SELECT * FROM orders;


