-----Project title: COLLEGE MANAGEMENT SYSTEM-----------

------Create the Database
CREATE Database College_Management_System

------	Load the Database
USE College_Management_System

------Import and extract the required datasets
SELECT * FROM COURSES
SELECT * FROM ENROLLMENTS
SELECT * FROM FACULTY_INSTRUCTORS
SELECT * FROM STUDENTS

---------------------------Quary starts from here-----------------------------------

--(1). Get the average grade for each student (considering A=4, B=3, C=2, D=1, F=0).

SELECT Name,
       Age,
	   Avg(CASE WHEN GRADE = 'A' THEN 4  
	            WHEN GRADE = 'B' THEN 3
				WHEN GRADE = 'C' THEN 2
				WHEN GRADE = 'D' THEN 1 ELSE 0 END) AS Avg_Grade

FROM STUDENTS ST
JOIN ENROLLMENTS EN
ON ST.STUDENTID = EN.STUDENTID
GROUP BY Name, Age
ORDER BY Avg_Grade Desc

--(2). List all instructors who are teaching a course with fewer than 3 students enrolled.

SELECT CONCAT(I.first_name, ' ', I.last_name) AS Instructor_Name,
       C.CourseName
FROM FACULTY_INSTRUCTORS I
JOIN COURSES C
    ON I.Faculty_id = C.InstructorID
LEFT JOIN ENROLLMENTS E
    ON C.CourseID = E.CourseID
GROUP BY I.Faculty_id, I.first_name, I.last_name, C.CourseID, C.CourseName
HAVING COUNT(E.StudentID) < 3

--(3). Find the total number of credits each student has earned, grouped by their major.

SELECT ST.Name,
       ST.Major,
	   sum(C.Credits) as Total_credits

FROM STUDENTS ST
JOIN ENROLLMENTS E
ON ST.StudentID = E.StudentID
LEFT JOIN COURSES C
ON E.CourseID = C.CourseID
GROUP BY ST.Name,ST.Major
ORDER BY Total_credits DESC


--(4). Find the average salary of instructors in each department.

SELECT department,
       AVG(Salary) AS Avg_sal

FROM FACULTY_INSTRUCTORS
GROUP BY department
ORDER BY 2 DESC

--(5). List all courses that are taught by more than one instructor.

SELECT CourseName,
       COUNT(InstructorID) as total_instructors

FROM COURSES
GROUP BY CourseName
HAVING COUNT(InstructorID) > 1 ----------Courses having more then 1 instructor
       

--(6). List the top 3 students with the highest number of credits earned.

SELECT Top 3 ST.Name,
	        sum(C.Credits) as Total_credits

FROM STUDENTS ST
JOIN ENROLLMENTS E
ON ST.StudentID = E.StudentID
LEFT JOIN COURSES C
ON E.CourseID = C.CourseID
GROUP BY ST.Name,ST.Major
ORDER BY Total_credits DESC


--------------------------------------------------End of Quary-----------------------------------------------------

