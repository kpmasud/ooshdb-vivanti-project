-- Creating different user on database "ooshdb"
-- Lets start by checking current user details

SELECT          rolname
FROM            pg_roles;


-- Create a new user master_admin with superuser privileges

CREATE 
USER             master_admin 
WITH 
PASSWORD        '#Master@dmin321/' 
SUPERUSER;

-- verify the changes

SELECT          rolname
FROM            pg_roles;   


-- check all all users for ooshdb


SELECT          usename
FROM            pg_user;    

-- Check which user has what access on ooshdb

SELECT          usename, 
                usesuper
FROM            pg_catalog.pg_user;

-- Grant all privileges to master_admin on ooshdb

GRANT           
ALL PRIVILEGES
ON              
DATABASE          ooshdb
TO                master_admin;       


-- verify the changes

SELECT          usename, 
                usesuper
FROM            pg_catalog.pg_user;

--Grant all privileges to masud for ooshdb

GRANT           
ALL PRIVILEGES
ON              
DATABASE        ooshdb
TO              masud;


-- verify the changes

SELECT          usename, 
                usesuper
FROM            pg_catalog.pg_user;


-- Check current user details

SELECT              rolname
FROM                pg_roles;


SELECT              current_user;

-- switch to master_admin user

SET                 ROLE master_admin;
SELECT              current_user;

-- Check current user details

SELECT              rolname
FROM                pg_roles;

-- switch to masud user

SET                 ROLE masud;
SELECT              current_user;

-- Check current user details

SELECT              rolname
FROM                pg_roles;


-- Create a new user analyst_user with no superuser privileges

CREATE 
USER                analyst_user 
WITH 
PASSWORD            '#Analyst@user321/' 
NOSUPERUSER;


-- verify the changes

SELECT              rolname
FROM                pg_roles;


-- check all all users for ooshdb


SELECT              usename
FROM                pg_user;    

-- Check which user has what access on ooshdb

SELECT              usename, 
                    usesuper
FROM                pg_catalog.pg_user;   


-- end of the code

-- Thank you 

-- Reference:
-- https://www.postgresql.org/docs/current/sql-createuser.html
-- https://www.postgresql.org/docs/current/sql-grant.html
-- https://www.postgresql.org/docs/current/sql-alterrole.html
-- https://www.postgresql.org/docs/current/role-membership.html
-- https://www.postgresql.org/docs/current/role-attributes.html
-- https://www.postgresql.org/docs/current/role-security.html
-- https://www.postgresql.org/docs/current/functions-current.html
-- https://www.postgresql.org/docs/current/infoschema-user-privileges.html
-- https://www.postgresql.org/docs/current/infoschema-roles.html
