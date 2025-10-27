show databases;

use innomatics_practice;

show tables;

-- Task 3 - Built-IN Functions:
-- Task A - Table Creation (DDL & Constraints)

CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    nickname VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    commission DECIMAL(10,2),
    hire_date DATE,
    phone_home VARCHAR(20),
    phone_office VARCHAR(20),
    phone_mobile VARCHAR(20),
    hours_worked INT
);

INSERT INTO employees VALUES
(1, 'John Smith', NULL, 'Sales', 5000, NULL, '2015-03-15', NULL, '555-1234', '999-1111', 160),
(2, 'Mary Jones', 'MJ', 'HR', 6000, 500, '2018-07-22', '444-2222', NULL, NULL, 0),
(3, 'Sam Lee', 'Sammy', 'IT', 7000, NULL, '2020-01-10', NULL, NULL, '777-8888', 172),
(4, 'Alex Brown', NULL, NULL, NULL, NULL, '2019-11-05', NULL, NULL, NULL, NULL),
(5, 'Sophia White', 'Sophie', 'Finance', 8000, 1200, '2017-05-30', '333-9999', '555-0000', NULL, 150);

select *from employees;

-- Task B - String Functions:
-- Show all employee names in uppercase.
select upper(name) from employees;

-- Display the first 4 letters of each employee’s name.
select left(name, 4) from employees;

-- Show the length of each employee’s name.
select name,length(name) from employees; 

-- Replace 'Smith' in names with 'Johnson'.
select replace(name, 'Smith', 'Johnson') as updated_name from employees;

-- Concatenate name and department separated by a dash (Name-Department).
select concat(name, '-', department ) as name_department from employees;

-- Display only the last 4 digits of each employee’s mobile number.
select name, right(phone_mobile, 4) from employees;

-- Show nickname if available, otherwise name (hint: COALESCE).
select coalesce(nickname, name) preferred_name from employees;

-- Find employees where the department name starts with 'S'.
select name from employees where department like 'S%';

-- Task C - Numeric Functions:
-- Display salary × 12 as yearly salary.
select name, (salary*12) as Yearly_salary from employees;

-- Round salary to nearest number..
select name, round(salary) as rounded_salary from employees;

-- Show absolute value of (commission - 1000).
select name, abs(coalesce(commission,0) - 1000) as abs_different from employees;

-- Find employees where salary modulo 3000 = 0.
select * from employees where salary % 3000 = 0;

-- Show square root of salary.
select name, sqrt(salary) from employees;

-- Show employees ordered by salary descending.
select *from employees order by salary desc;

-- Task D - Date/Time Functions:
-- Show hire_date and weekday name of hire_date.
select name,hire_date,dayname(hire_date) as day from employees;

-- Display hire year and month for each employee.
select name,year(hire_date) as Year,month(hire_date) as Month from employees;

-- Find employees hired before '2018-01-01'.
select *from employees where hire_date < '2018-01-01';

-- Show how many days each employee has worked in the company (DATEDIFF(NOW(), hire_date)).
select name, datediff(now(), hire_date) from employees;

-- Add 6 months to hire_date and display as probation_end_date.
select name,date_add(hire_date, interval 6 month) as probation_end_date from employees; 

-- Show employees ordered by hire_date (earliest first).
select * from employees order by hire_date asc;

-- Task E - Date/Time Functions:
-- Show commission, but replace NULL with 0.
select name, coalesce(commission,0) as commission from employees;

-- Show department, replace NULL with 'Not Assigned'.
select name, coalesce(department, 'Not Assigned') from employees;

-- Display available phone number in priority order: mobile → office → home.
select name, coalesce(phone_mobile, phone_office, phone_home) as phone_number from employees;

-- Calculate salary per hour (salary / hours_worked) but avoid division by zero or NULL.
-- (hint: use NULLIF(hours_worked, 0)).
select name, salary, hours_worked, salary / nullif(hours_worked, 0) as salary_per_hour from employees;


-- Task F - Date/Time Functions:
-- Find the total number of employees.
select count(*) as total_numbers_of_emp from employees;

-- Find the average salary of all employees.
select avg(salary) as avg_salary from employees;

-- Find the highest salary.
select max(salary) highest_salary from employees;

-- Find the lowest salary.
select min(salary) as lowest_salary from employees;

-- Count how many employees don’t have commission (WHERE commission IS NULL).
select count(*) from employees where commission is null;

-- Find total commission paid (only SUM, no grouping).
select sum(commission) from employees where commission is not null;
