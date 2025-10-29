-- Task 7 - Store Procedure:
CREATE DATABASE STORE_PROC_EMP;

USE STORE_PROC_EMP;

-- Step 1: Create Tables
-- Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(100) NOT NULL
);

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

-- Enrollment Table
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


-- Step 2: Insert Data
INSERT INTO Department (DeptName) VALUES
('Computer Science'), ('Mathematics'), ('Physics'), ('English');

INSERT INTO Student (StudentName, Age, DeptID) VALUES
('Alice', 20, 1), ('Bob', 21, 1), ('Charlie', 22, 2),
('David', 19, 3), ('Emma', 20, 4);

INSERT INTO Course (CourseName, Credits, DeptID) VALUES
('Database Systems', 4, 1), ('Operating Systems', 3, 1),
('Linear Algebra', 3, 2), ('Quantum Physics', 4, 3),
('English Literature', 3, 4);

INSERT INTO Enrollment (StudentID, CourseID, EnrollmentDate, Grade) VALUES
(1, 1, '2025-01-10', 'A'),
(2, 2, '2025-01-12', 'B'),
(3, 3, '2025-01-15', 'A'),
(4, 4, '2025-01-20', 'C'),
(5, 5, '2025-01-25', 'B');


-- Step 3: Store Procedure.
-- 1. Create a stored procedure named GetAllStudents that displays all student details from the Student table.
DELIMITER $$

CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT * FROM Student;
END $$

DELIMITER ;

-- CALLING 
CALL GetAllStudents();

-- 2. Create a stored procedure named GetCoursesByDepartment that accepts a DeptID as input and displays all courses offered by that department, along with the department name.
DELIMITER $$

CREATE PROCEDURE GetCoursesByDepartment(IN p_DeptID INT)
BEGIN
    SELECT 
        c.CourseID,
        c.CourseName,
        c.Credits,
        d.DeptName
    FROM Course c
    JOIN Department d ON c.DeptID = d.DeptID
    WHERE c.DeptID = p_DeptID;
END $$

DELIMITER ;

-- CALLING
CALL GetCoursesByDepartment(1);

-- 3. Create a stored procedure named InsertStudentRecord that inserts a new student record into the Student table.
-- 		After inserting, the procedure should display the details of the newly added student.
DELIMITER $$

CREATE PROCEDURE InsertStudentRecord(
    IN p_StudentName VARCHAR(100),
    IN p_Age INT,
    IN p_DeptID INT
)
BEGIN
    INSERT INTO Student (StudentName, Age, DeptID)
    VALUES (p_StudentName, p_Age, p_DeptID);
    
    SELECT * FROM Student WHERE StudentID = LAST_INSERT_ID();
END $$

DELIMITER ;

-- CALLING
CALL InsertStudentRecord('Frank', 23, 2);

-- 4. Create a stored procedure named GetAllEnrollments that displays all enrollments with the student name, course name, and grade.
DELIMITER $$

CREATE PROCEDURE GetAllEnrollments()
BEGIN
    SELECT 
        e.EnrollmentID,
        s.StudentName,
        c.CourseName,
        e.Grade,
        e.EnrollmentDate
    FROM Enrollment e
    JOIN Student s ON e.StudentID = s.StudentID
    JOIN Course c ON e.CourseID = c.CourseID;
END $$

DELIMITER ;

-- CALLING
CALL GetAllEnrollments();

-- 5. Create a stored procedure named UpdateStudentGrade that accepts an EnrollmentID and a new grade as input, and updates the corresponding record in the Enrollment table.
DELIMITER $$

CREATE PROCEDURE UpdateStudentGrade(
    IN p_EnrollmentID INT,
    IN p_NewGrade CHAR(2)
)
BEGIN
    UPDATE Enrollment
    SET Grade = p_NewGrade
    WHERE EnrollmentID = p_EnrollmentID;
    
    SELECT * FROM Enrollment WHERE EnrollmentID = p_EnrollmentID;
END $$

DELIMITER ;

-- CALLING
CALL UpdateStudentGrade(2, 'A');

-- 6. Create a stored procedure named GetCoursesByStudent that accepts a student name as input and returns the list of courses that student is enrolled in.
DELIMITER $$

CREATE PROCEDURE GetCoursesByStudent(IN p_StudentName VARCHAR(100))
BEGIN
    SELECT 
        s.StudentName,
        c.CourseName,
        c.Credits,
        e.Grade
    FROM Enrollment e
    JOIN Student s ON e.StudentID = s.StudentID
    JOIN Course c ON e.CourseID = c.CourseID
    WHERE s.StudentName = p_StudentName;
END $$

DELIMITER ;

-- CALLING
CALL GetCoursesByStudent('Alice');

-- 7. Create a stored procedure named GetDeptAverageGrade that:
-- 		Accepts a DeptID as input
-- 		Calculates and displays the average grade for all students in that department (where A=4, B=3, C=2).
DELIMITER $$

CREATE PROCEDURE GetDeptAverageGrade(IN p_DeptID INT)
BEGIN
    SELECT 
        d.DeptName,
        ROUND(AVG(
            CASE 
                WHEN e.Grade = 'A' THEN 4
                WHEN e.Grade = 'B' THEN 3
                WHEN e.Grade = 'C' THEN 2
                ELSE 0
            END
        ), 2) AS Average_Grade
    FROM Enrollment e
    JOIN Student s ON e.StudentID = s.StudentID
    JOIN Department d ON s.DeptID = d.DeptID
    WHERE d.DeptID = p_DeptID
    GROUP BY d.DeptName;
END $$

DELIMITER ;

-- CALLING
CALL GetDeptAverageGrade(1);
