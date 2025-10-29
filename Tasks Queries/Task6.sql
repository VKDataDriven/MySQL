show databases;

use college_mng_system;

show tables;

-- Task 6 - CTE and Views:
-- Use the above tables (Department Data, Student Data, Course Data, Instructor Data, CourseInstructor Data, Enrollment Data) to solve the following questions.
-- CTE (Common Table Expression) Questions
-- 1. List students and their department names using a CTE.
-- 		Hint: Create a CTE joining Student and Department, then select from it.
WITH STUDENT_DEPT AS(SELECT S.STUDENTNAME,
	   S.AGE,
       D.DEPTNAME
FROM STUDENT S,DEPARTMENT D 
WHERE S.DEPTID = D.DEPTID)
SELECT *FROM STUDENT_DEPT;

-- 2. Display courses with more than 3 credits using a CTE.
WITH MORE_THAN3_CREDITS AS (SELECT *FROM COURSE WHERE CREDITS >3)
SELECT *FROM MORE_THAN3_CREDITS;

-- 3. Find all students enrolled in any course using a CTE instead of a join directly in the main query
SELECT S.STUDENTID
	  ,S.STUDENTNAME
FROM STUDENT S
JOIN ENROLLMENT E ON S.STUDENTID = E.STUDENTID;


-- 4. Find the number of students enrolled per department using a CTE.
-- 	 	Hint: Join Student → Department → Enrollment and group by department.*
select *from enrollment;

WITH STD_DEPT AS (SELECT S.STUDENTID,S.STUDENTNAME,D.DEPTID,D.DEPTNAME
					FROM STUDENT S
						,DEPARTMENT D
					WHERE S.DEPTID = D.DEPTID)
SELECT SD.DEPTNAME,COUNT(SD.STUDENTID) NUM_OF_STUDENTS
FROM STD_DEPT SD,
	ENROLLMENT E
WHERE SD.STUDENTID = E.STUDENTID
GROUP BY SD.DEPTNAME;

-- 5. List all instructors who teach at least 2 courses using a CTE.
WITH INSTRUCTOR_COURSES AS(SELECT I.INSTRUCTORNAME,COUNT(CI.COURSEID) NUMBER_OF_COURSES
							FROM INSTRUCTOR I
								,COURSEINSTRUCTOR CI
							WHERE I.INSTRUCTORID = CI.INSTRUCTORID
							GROUP BY I.INSTRUCTORNAME)
SELECT INSTRUCTORNAME FROM INSTRUCTOR_COURSES WHERE NUMBER_OF_COURSES >= 2;

-- 6. Find students with average grades above 3.0 (A=4, B=3, C=2) using a CTE to calculate grade points first.
WITH GRADE_NUMBERS AS (SELECT E.STUDENTID,
						 CASE E.GRADE
							WHEN 'A' THEN 4
							WHEN 'B' THEN 3
							WHEN 'C' THEN 2
							ELSE 0
							END AS GRADE_NUM
						FROM ENROLLMENT E),
    AVERAGE_STUDENT AS (SELECT S.STUDENTNAME,AVG(G.GRADE_NUM) AS AVG_GRADE
						FROM GRADE_NUMBERS G,
							STUDENT S
						WHERE G.STUDENTID = S.STUDENTID
                        GROUP BY S.STUDENTNAME)                
SELECT *FROM AVERAGE_STUDENT WHERE AVG_GRADE > 3.0;

-- 7. Display the most popular course (highest number of enrollments) using a CTE and ORDER BY COUNT(*) DESC LIMIT 1.
WITH ENROLLMENT_COUNT_STD AS (SELECT C.COURSENAME, COUNT(E.STUDENTID) AS ENROLLMENT_COUNT
							  FROM ENROLLMENT E
								 , COURSE C
							  WHERE E.COURSEID = C.COURSEID
							  GROUP BY C.COURSENAME)
SELECT *FROM ENROLLMENT_COUNT_STD
ORDER BY ENROLLMENT_COUNT DESC
LIMIT 1;

-- 8. Recursive CTE: Create a simple recursive CTE that prints numbers from 1 to 10. (For CTE syntax practice.)
WITH RECURSIVE NUMBERS AS (SELECT 1 AS N UNION ALL 
					SELECT N + 1 FROM NUMBERS WHERE N < 10)
SELECT *FROM NUMBERS;

-- 9. Find departments that have students enrolled in all of their offered courses using a CTE to compare total courses vs. 
-- enrolled courses per department.
WITH DEPTCOURSE AS (
    SELECT D.DEPTID, COUNT(DISTINCT C.COURSEID) AS TOTAL_COURSES
    FROM DEPARTMENT D
        JOIN COURSE C ON D.DEPTID = C.DEPTID
    GROUP BY D.DEPTID
),
DEPTENRCOURSE AS (
    SELECT D.DEPTID, COUNT(DISTINCT E.COURSEID) AS TOTAL_ENT_COURSES
    FROM DEPARTMENT D
        JOIN COURSE C ON D.DEPTID = C.DEPTID
        JOIN ENROLLMENT E ON C.COURSEID = E.COURSEID
    GROUP BY D.DEPTID
)
SELECT D.DEPTNAME
FROM DEPARTMENT D
    JOIN DEPTCOURSE DC ON D.DEPTID = DC.DEPTID
    JOIN DEPTENRCOURSE DE ON D.DEPTID = DE.DEPTID
WHERE DC.TOTAL_COURSES = DE.TOTAL_ENT_COURSES;

-- 10. Rank courses by the number of students enrolled using a CTE and RANK() window function.
WITH CourseRank AS (
    SELECT c.CourseName, COUNT(e.StudentID) AS EnrollCount,
           RANK() OVER (ORDER BY COUNT(e.StudentID) DESC) AS RankNum
    FROM Course c
    JOIN Enrollment e ON c.CourseID = e.CourseID
    GROUP BY c.CourseName
)
SELECT * FROM CourseRank;

-- Views 
-- 1. Create a view named StudentDetailsView that shows:
--  StudentName, Age, DeptName.
CREATE VIEW StudentDetailsView AS
SELECT s.StudentName, s.Age, d.DeptName
FROM Student s
JOIN Department d ON s.DeptID = d.DeptID;

SELECT *FROM StudentDetailsView;
-- 2. Create a view named CourseDetailsView that displays each course along with its department name and instructor name.
CREATE VIEW CourseDetailsView AS
SELECT c.CourseName, d.DeptName, i.InstructorName
FROM Course c
JOIN Department d ON c.DeptID = d.DeptID
JOIN CourseInstructor ci ON c.CourseID = ci.CourseID
JOIN Instructor i ON ci.InstructorID = i.InstructorID;

SELECT *FROM CourseDetailsView;
-- 3. Create a view named EnrollmentView that shows:
-- 		StudentName, CourseName, Grade, EnrollmentDate.
CREATE VIEW EnrollmentView AS
SELECT s.StudentName, c.CourseName, e.Grade, e.EnrollmentDate
FROM Enrollment e
JOIN Student s ON e.StudentID = s.StudentID
JOIN Course c ON e.CourseID = c.CourseID;

SELECT *FROM EnrollmentView;
-- 4. Create a view HighAchieversView that lists students who have scored grade ‘A’.
CREATE VIEW HighAchieversView AS
SELECT s.StudentName, c.CourseName, e.Grade
FROM Enrollment e
JOIN Student s ON e.StudentID = s.StudentID
JOIN Course c ON e.CourseID = c.CourseID
WHERE e.Grade = 'A';

SELECT *FROM HighAchieversView;
-- 5. Create a view InstructorCourseCountView that shows each instructor and the number of courses they teach.
CREATE VIEW InstructorCourseCountView AS
SELECT i.InstructorName, COUNT(ci.CourseID) AS CourseCount
FROM Instructor i
JOIN CourseInstructor ci ON i.InstructorID = ci.InstructorID
GROUP BY i.InstructorName;

SELECT *FROM InstructorCourseCountView;
-- 6. Create a view DeptStudentCountView that lists each department and how many students belong to it.
CREATE VIEW DeptStudentCountView AS
SELECT d.DeptName, COUNT(s.StudentID) AS StudentCount
FROM Department d
LEFT JOIN Student s ON d.DeptID = s.DeptID
GROUP BY d.DeptName;

SELECT *FROM DeptStudentCountView;
-- 7. Create a view that shows each student with their average grade point (A=4, B=3, C=2) across all courses.
CREATE VIEW StudentAverageGradeView AS
SELECT s.StudentName,
       AVG(CASE e.Grade
           WHEN 'A' THEN 4
           WHEN 'B' THEN 3
           WHEN 'C' THEN 2
           ELSE 0 END) AS AvgGradePoint
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentName;

SELECT *FROM StudentAverageGradeView;
-- 8. Create a view TopPerformersView that displays the top 3 students with the highest average grade points.
CREATE VIEW TopPerformersView AS
SELECT StudentName, AvgGradePoint
FROM (
    SELECT s.StudentName,
           AVG(CASE e.Grade
               WHEN 'A' THEN 4
               WHEN 'B' THEN 3
               WHEN 'C' THEN 2
               ELSE 0 END) AS AvgGradePoint,
           RANK() OVER (ORDER BY AVG(CASE e.Grade
               WHEN 'A' THEN 4
               WHEN 'B' THEN 3
               WHEN 'C' THEN 2
               ELSE 0 END) DESC) AS RankNum
    FROM Student s
    JOIN Enrollment e ON s.StudentID = e.StudentID
    GROUP BY s.StudentName
) ranked
WHERE RankNum <= 3;

SELECT *FROM TopPerformersView;
-- 9. Create a view that shows courses with no students enrolled (use LEFT JOIN logic inside the view).
CREATE VIEW CoursesWithNoEnrollments AS
SELECT c.CourseName
FROM Course c
LEFT JOIN Enrollment e ON c.CourseID = e.CourseID
WHERE e.CourseID IS NULL;

SELECT *FROM CoursesWithNoEnrollments;
-- 10. Create a view DepartmentReportView combining:
-- 		Department name	
-- 		Number of students
-- 		Number of instructors
-- 		Number of courses offered
CREATE VIEW DepartmentReportView AS
SELECT d.DeptName,
       COUNT(DISTINCT s.StudentID) AS StudentCount,
       COUNT(DISTINCT i.InstructorID) AS InstructorCount,
       COUNT(DISTINCT c.CourseID) AS CourseCount
FROM Department d
LEFT JOIN Student s ON d.DeptID = s.DeptID
LEFT JOIN Instructor i ON d.DeptID = i.DeptID
LEFT JOIN Course c ON d.DeptID = c.DeptID
GROUP BY d.DeptName;

SELECT *FROM DepartmentReportView;