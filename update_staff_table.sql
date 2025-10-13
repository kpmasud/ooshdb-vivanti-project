
SELECT * FROM staff;

-- udpate staff table because if one staff take a leave and then he come back after 2 months or a year then how we can store his data 
-- so we need to add a new column called status to store the status of the staff whether he is active or inactive

-- first lets have a look on the staff table

SELECT * FROM staff;


-- we have few options to add a new column in the table
-- 1. add a new column called " status" with default value to tack active or inactive or leave or resigned or retired
--    we can use integer value to store the status like 1 for active, 0 for inactive, 2 for leave, 3 for resigned, 4 for retired
--    or we can use text value to store the status like 'active', 'inactive', 'leave', 'retired' or 'resigned'
-- 2. add a new column called " leave_date" to store the date when the staff take a leave
-- 3. add a new column called " return_date" to store the date when the staff come back from leave
-- 4. add a new column called " leave_reason" to store the reason of leave
-- 5. add a new column called " notes" to store any other information about the staff   


-- we will go with the first option to add a new column called " status" with default value to tack active or inactive or leave or resigned or retired


ALTER TABLE             staff 
ADD COLUMN              status TEXT DEFAULT 'active'; 

-- verify the changes

SELECT * FROM staff;


-- add a new column called " leave_date" to store the date when the staff take a leave

ALTER TABLE             staff 
ADD COLUMN              leave_date DATE;    

-- verify the changes
SELECT * FROM staff;

-- add a new column called " return_date" to store the date when the staff come back from leave

ALTER TABLE             staff
ADD COLUMN              return_date DATE;

-- verify the changes

SELECT * FROM staff;

-- add a new column called " leave_reason" to store the reason of leave

ALTER TABLE             staff
ADD COLUMN              leave_reason TEXT;


-- verify the changes

SELECT * FROM staff;


-- add a new column called " notes" to store any other information about the staff

ALTER TABLE             staff
ADD COLUMN              notes TEXT;

-- verify the changes

SELECT * FROM staff;





-- add a new column called " notes" to store any other information about the staff

ALTER TABLE             staff
ADD COLUMN              notes TEXT;

-- verify the changes

-- Udpate staff status to inactive where staff_id is 405 where staff is on leave for 2 months


UPDATE                  staff
SET status              = 'inactive', 
leave_date              = '2024-01-01', 
return_date             = '2024-03-01', 
leave_reason            = 'personal reasons', 
notes                   = 'on leave for 2 months'
WHERE 
staff_id                = 405;

-- verify the changes
SELECT * 
FROM                    staff 
WHERE 
staff_id                = 405;

-- Update staff status to resigned where staff_id is 428 where staff has resigned


UPDATE                  staff
SET status              = 'resigned', 
leave_date              = '2024-02-15', 
return_date             = NULL, 
leave_reason            = 'resigned', 
notes                   = 'resigned from the job'
WHERE 
staff_id                = 428;   

-- verify the changes
SELECT * 
FROM                    staff 
WHERE                   
staff_id                = 428;

-- End of the code



-- end of the code

-- --- IGNORE ---