-- Task 5 - Joins and Subqueries:
-- Database Schema: College Management System
-- Step 1: Create Table
-- Department Table
CREATE DATABASE COLLEGE_MNG_SYSTEM;
SHOW DATABASES;
USE COLLEGE_MNG_SYSTEM;

SHOW TABLES;
CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(100) NOT NULL
);

SHOW TABLES;

-- Student Table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100),
    Age INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Course Table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100),
    Credits INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Enrollment Table (junction table for many-to-many)
CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Instructor Table
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    InstructorName VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Course_Instructor (many-to-many relationship)
CREATE TABLE CourseInstructor (
    CourseID INT,
    InstructorID INT,
    PRIMARY KEY (CourseID, InstructorID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Step 2: Insert Data
-- Department Data
INSERT INTO Department (DeptName) VALUES
('Computer Science'),
('Mathematics'),
('Physics'),
('English');

-- Student Data
INSERT INTO Student (StudentName, Age, DeptID) VALUES
('Alice', 20, 1),
('Bob', 21, 1),
('Charlie', 22, 2),
('David', 19, 3),
('Emma', 20, 4),
('Frank', 21, 2),
('Grace', 23, 1),
('Hannah', 22, 3);

-- Course Data
INSERT INTO Course (CourseName, Credits, DeptID) VALUES
('Database Systems', 4, 1),
('Operating Systems', 3, 1),
('Linear Algebra', 3, 2),
('Quantum Physics', 4, 3),
('English Literature', 3, 4),
('Data Structures', 4, 1);

-- Instructor Data
INSERT INTO Instructor (InstructorName, DeptID) VALUES
('Dr. Smith', 1),
('Dr. Johnson', 2),
('Dr. Brown', 3),
('Dr. Taylor', 4);

-- CourseInstructor Data
INSERT INTO CourseInstructor (CourseID, InstructorID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 1);

-- Enrollment Data
INSERT INTO Enrollment (StudentID, CourseID, EnrollmentDate, Grade) VALUES
(1, 1, '2025-01-10', 'A'),
(2, 1, '2025-01-10', 'B'),
(3, 3, '2025-01-12', 'A'),
(4, 4, '2025-01-15', 'C'),
(5, 5, '2025-01-18', 'B'),
(6, 3, '2025-01-20', 'A'),
(7, 2, '2025-01-25', 'B'),
(8, 4, '2025-01-28', 'A'),
(1, 6, '2025-02-01', 'A'),
(2, 6, '2025-02-02', 'C');

SELECT *FROM COURSE;
-- Step 3: JOINS
-- List all students with their department names.
SELECT STD.*,
		DP.DEPTNAME
FROM STUDENT STD,
	DEPARTMENT DP
WHERE STD.DEPTID = DP.DEPTID;

-- Show all courses along with their respective department names.
SELECT C.*,DP.DEPTNAME
FROM COURSE C,
DEPARTMENT DP
WHERE C.DEPTID = DP.DEPTID;

-- Display the names of students and the courses they are enrolled in.
SELECT STD.STUDENTNAME,
	   C.COURSENAME
FROM STUDENT STD,
DEPARTMENT DP,
COURSE C
WHERE STD.DEPTID = DP.DEPTID
AND DP.DEPTID = C.DEPTID;

-- Show the names of students, their course names, and grades.
SELECT STD.STUDENTNAME
	  , ENT.GRADE
      , C.COURSENAME
FROM STUDENT STD,
	 ENROLLMENT ENT,
     COURSE C
WHERE STD.STUDENTID = ENT.STUDENTID
AND ENT.COURSEID = C.COURSEID;

-- List all instructors and the courses they teach.
SELECT I.INSTRUCTORNAME, C.COURSENAME
FROM INSTRUCTOR I,
	 COURSE C
WHERE I.DEPTID = C.DEPTID;

-- Find all students who are enrolled in courses taught by “Dr. Smith.”
SELECT S.STUDENTNAME,
	   C.COURSENAME,
       I.INSTRUCTORNAME
FROM STUDENT S,
	 COURSE C,
     INSTRUCTOR I
WHERE S.DEPTID = C.DEPTID
AND C.DEPTID = I.DEPTID
AND I.INSTRUCTORNAME = "Dr. Smith";

-- Display all students who belong to the same department as “Bob.”
SELECT S1.* 
FROM STUDENT S1, STUDENT S2
WHERE S1.DEPTID = S2.DEPTID
AND S2.STUDENTNAME = "Bob";

-- Find the total number of students enrolled in each course.
SELECT C.COURSENAME, COUNT(S.STUDENTID) AS NO_OF_STUDENTS
FROM STUDENT S,
	COURSE C 
WHERE S.DEPTID = C.DEPTID
GROUP BY C.COURSENAME;

-- List courses that have no students enrolled (use a LEFT JOIN).
SELECT C.*
FROM COURSE C
	LEFT JOIN STUDENT S ON C.DEPTID = S.DEPTID
    WHERE S.STUDENTID IS NULL;

-- Display each instructor with the total number of courses they are teaching.
SELECT I.INSTRUCTORNAME, COUNT(C.COURSEID) NUM_OF_COURSES
FROM INSTRUCTOR I,
	COURSE C 
WHERE I.DEPTID = C.DEPTID
GROUP BY I.INSTRUCTORNAME;


-- Step 4: SubQueries 
-- Find the names of students who got grade ‘A’.
SELECT *FROM STUDENT 
	WHERE STUDENTID IN (SELECT STUDENTID FROM ENROLLMENT WHERE GRADE="A");
    
	-- Display the details of students who belong to the same department as “Alice.”
SELECT * FROM STUDENT
WHERE DEPTID IN (SELECT DEPTID FROM student WHERE studentname = "Alice");

-- List the courses that belong to the same department as “Database Systems.”
SELECT *FROM COURSE
WHERE DEPTID IN (SELECT DEPTID FROM course WHERE coursename = "Database Systems");

-- Find students enrolled in more than one course.
SELECT S.STUDENTID,S.STUDENTNAME,COUNT(I.COURSEID)
FROM STUDENT S
JOIN ENROLLMENT I ON S.STUDENTID = I.STUDENTID
GROUP BY S.STUDENTID,S.STUDENTNAME;
 
-- List all students whose grade in any course is higher than “Bob’s” grade in “Database Systems.”
SELECT DISTINCT S.STUDENTID,S.STUDENTNAME
FROM STUDENT S
JOIN ENROLLMENT E ON S.STUDENTID = E.STUDENTID
JOIN COURSE C ON E.COURSEID = C.COURSEID
WHERE E.GRADE > (SELECT E2.GRADE 
FROM ENROLLMENT E2
JOIN STUDeNT S2 ON E2.STUDENTID = S2.STUDENTID
JOIN COURSE C2 ON E2.COURSEID = C2.COURSEID
WHERE S2.STUDENTNAME = 'Bob'
AND C2.COURSENAME = 'Database System');

-- Show all instructors who teach courses in the same department as “Dr. Johnson.”
SELECT *FROM INSTRUCTOR I WHERE I.DEPTID IN (
SELECT DEPTID FROM INSTRUCTOR WHERE INSTRUCTORNAME = "Dr. Johnson");

-- Display the students who are not enrolled in any course.
SELECT *FROM STUDENT S WHERE S.STUDENTID NOT IN (SELECT E.STUDENTID FROM ENROLLMENT E);

-- Find the department(s) with the maximum number of students.
SELECT DEPTNAME,COUNT(S.STUDENTID) AS NUMBER_OF_STD
FROM STUDENT S
JOIN DEPARTMENT D ON S.DEPTID = D.DEPTID
GROUP BY DEPTNAME
ORDER BY NUMBER_OF_STD DESC;

SELECT D.DeptID, D.DeptName, COUNT(S.StudentID) AS Student_Count
FROM DEPARTMENT D
JOIN STUDENT S ON D.DeptID = S.DeptID
GROUP BY D.DeptID, D.DeptName
HAVING COUNT(S.StudentID) = (
    SELECT MAX(Student_Count)
    FROM (
        SELECT COUNT(StudentID) AS Student_Count
        FROM STUDENT
        GROUP BY DeptID
    ) T
);


-- List the top 3 students with the highest average grade (consider A=4, B=3, C=2).
SELECT S.StudentID, S.StudentName,
       AVG(
           CASE E.Grade
               WHEN 'A' THEN 4
               WHEN 'B' THEN 3
               WHEN 'C' THEN 2
               ELSE 0
           END
       ) AS Avg_Grade
FROM STUDENT S
JOIN ENROLLMENT E ON S.StudentID = E.StudentID
GROUP BY S.StudentID, S.StudentName
ORDER BY Avg_Grade DESC
LIMIT 3;


-- Find students who are enrolled in all the courses offered by their department.
SELECT S.StudentID, S.StudentName
FROM STUDENT S
WHERE NOT EXISTS (
    SELECT C.CourseID
    FROM COURSE C
    WHERE C.DeptID = S.DeptID
    AND C.CourseID NOT IN (
        SELECT E.CourseID
        FROM ENROLLMENT E
        WHERE E.StudentID = S.StudentID
    )
);


-----------------  The End ---------------------
