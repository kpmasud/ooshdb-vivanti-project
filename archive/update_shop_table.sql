SELECT * FROM shops;

-- update shop table with altering column name

ALTER TABLE             shops 
RENAME COLUMN           state 
TO                     state_id;

-- verify the changes


SELECT * FROM shops;

-- end of the code