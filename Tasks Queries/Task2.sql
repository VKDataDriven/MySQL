-- Task 2 - DDL and DML Commands :

-- checking the how many databases is there
show databases;

-- Create the New database name Innomatics_practice
create database Innomatics_practice;

-- Selecting the DataBase
use Innomatics_practice;

-- Checking the how many tables is there
show tables;
/*Task A – Bakery Table
Create a table called bakery with the following columns:
cake_name 
flavor 
price 
No constraints are required, but choose appropriate data types.*/

-- Creating the new Table bakery
create table bakery (cake_name varchar(50), flour varchar(50), price decimal(6,2));

-- Read Data from bakery table
select *from bakery;

-- inserting new Data into bakery table 
insert into bakery values('chocolate','straberry',99.50);

/*Task B – Library Table
The college wants to maintain a record of students using the library.
 The table should be called library and must have the following details:
student_id
student_name
student_library_id
student_login_time 
student_logout_time
student_course
student_college 
Create this table with suitable constraints.
*/

create table library(student_id int,
student_name varchar(250),
student_library_id varchar(50),
student_login_time datetime,
student_logout_time datetime,
student_course varchar(250),
student_college varchar(250)
);

/*Task C – Insert Records:
Insert 8 sample records into the library table.
*/
insert into library values
(1001,'vamshi krishna','18p6a502','2025-10-01 12:10:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar'),
(1002,'krishnaveni','18p6a503','2025-10-01 10:10:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar'),
(1003,'Manasa','18p6a504','2025-10-01 11:10:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar'),
(1004,'Kaveri','18p6a505','2025-10-01 09:10:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar'),
(1005,'Priyanka','18p6a506','2025-10-01 09:40:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar'),
(1006,'Manisha','18p6a507','2025-10-01 08:10:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar'),
(1007,'Chitti','18p6a508','2025-10-01 08:30:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar'),
(1008,'Yamuna','18p6a509','2025-10-01 09:20:24','2025-10-01 12:55:44','Computer Science Egg','VBIT Ghatkesar');


select *from library;

SET SQL_SAFE_UPDATES = 0;

-- Task D – Table Modifications:

-- The library now wants to record the student’s age.
-- Add a new column student_age (INT).
ALTER TABLE library ADD COLUMN student_age INT;

-- Later, the admin decides the student_name column should allow only up to 30 characters instead of 50.
-- Modify the column data type to VARCHAR(30).
ALTER TABLE library MODIFY COLUMN student_name varchar(30);

-- The bakery table is filled with test data. The owner wants to clear all records but still keep the table structure.
-- Write a query to empty the bakery table.
TRUNCATE bakery;

select *from bakery;

-- The college realizes they don’t need to store student logout time anymore.
-- Write a query to completely remove this column from the library table.
ALTER TABLE library DROP COLUMN student_logout_time;

-- The bakery table should be renamed from bakery to cakeshop.
-- Write the SQL query to rename it.
RENAME TABLE bakery to cakeshop;

-- In the library table, rename the column student_course to course_name.
--  Write the SQL query for this.
ALTER TABLE library CHANGE student_course course_name varchar(30);
