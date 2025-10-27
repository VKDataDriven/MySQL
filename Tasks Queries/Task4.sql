CREATE DATABASE EMP;
USE EMP;

show tables;
-- Task 4 - Clauses:
-- Step 1: Create Table
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) DEFAULT 'General',
    salary DECIMAL(10,2) CHECK (salary > 0),
    joining_date DATE NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0 CHECK (bonus >= 0),
    rating DECIMAL(2,1) CHECK (rating BETWEEN 0.0 AND 5.0),
    age INT CHECK (age >= 18)
);

-- Step 2: Insert Data (50 Records)
Insert into Employees (first_name, last_name, department, salary, joining_date, bonus, rating, age) VALUES
('John', 'Smith', 'IT', 60000, '2018-03-15', 5000, 4.5, 28),
('Jane', 'Doe', 'HR', 45000, '2019-06-20', 2000, 3.9, 32),
('Robert', 'Brown', 'Finance', 70000, '2017-01-10', 7000, 4.8, 40),
('Emily', 'Clark', 'IT', 55000, '2020-11-05', 3000, 4.2, 26),
('David', 'Wilson', 'Marketing', 48000, '2016-09-12', 1500, 3.5, 35),
('Sophia', 'Taylor', 'IT', 75000, '2015-04-01', 8000, 4.9, 38),
('Liam', 'Johnson', 'Finance', 68000, '2021-07-23', 5000, 4.1, 29),
('Olivia', 'Martin', 'HR', 42000, '2019-05-15', 1800, 3.6, 27),
('Noah', 'Lee', 'IT', 62000, '2018-02-19', 4000, 4.3, 31),
('Ava', 'Walker', 'Marketing', 51000, '2020-08-10', 2500, 4.0, 30),
('Ethan', 'Hall', 'Finance', 73000, '2017-10-08', 6000, 4.6, 41),
('Mia', 'Allen', 'HR', 46000, '2020-03-02', 2200, 3.8, 28),
('James', 'Young', 'IT', 59000, '2016-06-30', 3500, 4.4, 33),
('Isabella', 'Hernandez', 'Finance', 71000, '2018-09-18', 5500, 4.7, 37),
('Benjamin', 'King', 'Marketing', 52000, '2019-11-11', 2300, 3.9, 34),
('Charlotte', 'Wright', 'IT', 64000, '2021-04-25', 4500, 4.5, 29),
('Michael', 'Lopez', 'Finance', 69000, '2015-01-15', 7500, 4.2, 42),
('Amelia', 'Scott', 'HR', 47000, '2020-07-07', 2100, 3.7, 26),
('Alexander', 'Green', 'Marketing', 53000, '2017-05-19', 2600, 4.1, 36),
('Harper', 'Adams', 'IT', 61000, '2019-12-01', 3800, 4.4, 30),
('Daniel', 'Baker', 'Finance', 72000, '2016-08-22', 6800, 4.5, 39),
('Evelyn', 'Nelson', 'HR', 44000, '2018-10-14', 1900, 3.5, 31),
('Matthew', 'Carter', 'IT', 65000, '2017-03-09', 4700, 4.6, 35),
('Abigail', 'Mitchell', 'Finance', 74000, '2015-12-20', 8000, 4.9, 43),
('Joseph', 'Perez', 'Marketing', 50000, '2016-02-28', 1700, 3.4, 28),
('Ella', 'Roberts', 'HR', 43000, '2019-09-17', 1600, 3.2, 24),
('Samuel', 'Turner', 'IT', 67000, '2020-06-04', 4900, 4.7, 29),
('Grace', 'Phillips', 'Finance', 76000, '2018-01-29', 8200, 4.8, 44),
('Henry', 'Campbell', 'Marketing', 54000, '2017-07-16', 2700, 4.0, 32),
('Victoria', 'Parker', 'HR', 41000, '2016-11-11', 1400, 3.1, 30),
('Jackson', 'Evans', 'IT', 69000, '2015-09-03', 5200, 4.5, 38),
('Scarlett', 'Edwards', 'Finance', 77000, '2019-02-22', 8500, 4.9, 36),
('Sebastian', 'Collins', 'Marketing', 55000, '2020-05-27', 2800, 4.2, 33),
('Chloe', 'Stewart', 'HR', 48000, '2018-04-06', 2100, 3.8, 27),
('Aiden', 'Morris', 'IT', 63000, '2016-12-30', 4100, 4.3, 31),
('Layla', 'Rogers', 'Finance', 78000, '2017-08-19', 9000, 5.0, 45),
('Lucas', 'Reed', 'Marketing', 56000, '2015-05-05', 2900, 4.1, 37),
('Zoe', 'Cook', 'HR', 49000, '2019-01-13', 2300, 3.9, 28),
('Mason', 'Morgan', 'IT', 70000, '2020-10-09', 5300, 4.6, 34),
('Lily', 'Bell', 'Finance', 79000, '2016-03-21', 9500, 5.0, 46),
('Logan', 'Murphy', 'Marketing', 57000, '2018-08-30', 3000, 4.0, 35),
('Hannah', 'Bailey', 'HR', 45000, '2015-06-25', 2000, 3.6, 29),
('Elijah', 'Rivera', 'IT', 66000, '2017-10-13', 4600, 4.5, 32),
('Aria', 'Cooper', 'Finance', 80000, '2019-12-18', 10000, 5.0, 47),
('Oliver', 'Richardson', 'Marketing', 58000, '2020-09-24', 3100, 4.2, 31),
('Sofia', 'Ward', 'HR', 47000, '2016-04-07', 2200, 3.7, 27),
('William', 'Peterson', 'IT', 71000, '2018-07-22', 5400, 4.7, 36),
('Camila', 'Gray', 'Finance', 82000, '2015-08-14', 11000, 5.0, 48),
('Jacob', 'Ramirez', 'Marketing', 59000, '2017-11-30', 3200, 4.3, 34),
('Madison', 'James', 'HR', 46000, '2021-03-11', 2100, 3.5, 25);

SELECT *FROM EMPLOYEES;

-- Step 3: Answer the Following Questions
-- 🔹 DDL / DML:
-- Add a new column email VARCHAR(100) to the Employees table.
ALTER TABLE EMPLOYEES ADD COLUMN email VARCHAR(100);

SELECT *FROM EMPLOYEES;

-- Update all employees in the IT department to get a 5% salary hike.
SET SQL_SAFE_UPDATES = 0;

UPDATE EMPLOYEES
SET SALARY = SALARY *1.05
WHERE DEPARTMENT = 'IT';

SELECT *FROM EMPLOYEES;

-- Delete employees whose age < 25.
-- 🔹 WHERE
DELETE FROM EMPLOYEES WHERE AGE < 25;

-- List employees from Finance earning more than 70000 with rating above 4.5.
SELECT *FROM EMPLOYEES WHERE DEPARTMENT = 'FINANCE' AND SALARY > 70000 AND RATING > 4.5;


-- Show all employees whose age is between 30 and 40 AND department = 'Marketing'.
SELECT *FROM EMPLOYEES WHERE DEPARTMENT = 'MARKETING' AND AGE BETWEEN 30 AND 40;

/* Classify employees by salary range using CASE.
If Salary Greater than 70000 , then “Higher Earner”.
If Salary between 50000 AND 69999 THEN 'Mid Earner'
ELSE 'Low Earner'*/
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT,SALARY,
CASE 
	WHEN SALARY > 70000 THEN 'HIGHER EARNER'
    WHEN SALARY BETWEEN 50000 AND 69999 THEN 'MID EARNER'
    WHEN SALARY < 50000 THEN 'LOW EARNER' END AS SALARY_RANGE
FROM EMPLOYEES;


-- 🔹GROUP BY
-- Find the average salary per department.
SELECT DEPARTMENT, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT;

-- Find the maximum bonus in each department.
SELECT DEPARTMENT, MAX(BONUS) AS HIGHEST_BONUS
FROM EMPLOYEES
GROUP BY DEPARTMENT;

-- Count how many employees are in each department.
SELECT DEPARTMENT, COUNT(*) FROM EMPLOYEES GROUP BY DEPARTMENT;

-- 🔹 HAVING
-- Show departments having an average salary > 60000.
SELECT DEPARTMENT, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT
HAVING AVG_SALARY > 60000;

-- Show departments where the count of employees > 8.
SELECT DEPARTMENT, COUNT(*) AS COUNT_OF_EMP
FROM EMPLOYEES
GROUP BY DEPARTMENT
HAVING COUNT_OF_EMP > 8;


-- 🔹 ORDER BY, LIMIT, OFFSET
-- Show the top 5 highest-paid employees.
SELECT * FROM EMPLOYEES ORDER BY SALARY DESC LIMIT  5;


-- Show employees ordered by rating DESC, but skip the first 3 and display next 5.
SELECT * FROM EMPLOYEES ORDER BY RATING DESC LIMIT 5 OFFSET 3;

-- 🔹 DISTINCT + Functions
-- Display all distinct departments.
SELECT DISTINCT DEPARTMENT FROM EMPLOYEES;

-- Find the total salary + bonus per employee and order results by that total.
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT,(SALARY+BONUS) AS TOTAL_SALARY 
FROM EMPLOYEES ORDER BY TOTAL_SALARY;

-- Find employees from IT whose salary > 60000, group them by rating,
SELECT RATING,COUNT(*) AS NUMBER_OF_EMP
FROM EMPLOYEES
WHERE SALARY > 60000
GROUP BY RATING
ORDER BY NUMBER_OF_EMP DESC;


 -- and show only groups with average bonus > 4000, ordered by average salary descending.
 SELECT SALARY, AVG(BONUS) AS AVG_BONUS
 FROM EMPLOYEES
 GROUP BY SALARY
 HAVING AVG_BONUS > 4000
 ORDER BY SALARY DESC;
 
/* Classify employees by joining year with CASE:
If YEAR(joining_date) < 2017 THEN 'Old Batch'
If YEAR(joining_date) BETWEEN 2017 AND 2019 THEN 'Mid Batch'
ELSE 'New Batch' */
SELECT FIRST_NAME,
	  LAST_NAME,
      DEPARTMENT,
      JOINING_DATE,
      CASE
		WHEN YEAR(JOINING_DATE) < 2017 THEN 'OLD BATCH'
        WHEN YEAR(JOINING_DATE) BETWEEN 2017 AND 2019 THEN 'MID BATCH'
        WHEN YEAR(JOINING_DATE) > 2019 THEN 'NEW BATCH'
      END AS EMP_YEAR
FROM EMPLOYEES;


-- 🔹 Step 7: Additional (Built-in Functions)
-- Show employees’ names in uppercase.
SELECT UPPER(CONCAT(FIRST_NAME,' ',LAST_NAME)) FROM EMPLOYEES;

-- Display first 3 letters of each employee’s last name.
SELECT substr(LAST_NAME, 1, 3) FROM EMPLOYEES;

-- Show employees with total salary (salary + bonus), rounded to nearest 1000.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPARTMENT,SALARY,BONUS, ROUND(SALARY + BONUS, -3) TOTAL_SALARY 
FROM EMPLOYEES;
SELECT *FROM EMPLOYEES;
-- Extract year, month name, and day of week from joining_date.
SELECT EMP_ID, 
	   JOINING_DATE, 
       YEAR(JOINING_DATE) AS JOINING_YEAR,
       MONTHNAME(JOINING_DATE) AS JOINING_MONTH,
       DAYNAME(JOINING_DATE) AS JOINING_DAY
FROM EMPLOYEES;

-- 🔹 Step 8:Order of Execution of Clauses:
-- Write the order of execution of the clauses.
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY

THE ACTUAL EXECUTION ORDER IS:

FROM → Tables are joined and data sources identified.
WHERE → Filters rows before grouping.
GROUP BY → Groups rows (if aggregation is used).
HAVING → Filters groups after aggregation.
SELECT → Columns or expressions are selected.
ORDER BY → Orders the final output.
LIMIT / FETCH → (if used) restricts the number of rows returned.