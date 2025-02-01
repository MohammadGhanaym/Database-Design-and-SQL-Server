USE ITI

SELECT * FROM Student

SELECT * FROM Department

SELECT St_Fname, dept_name
FROM Student, Department

SELECT St_Fname, dept_name
FROM Student CROSS JOIN Department

SELECT St_Fname, dept_name
FROM Student, Department
WHERE Department.Dept_Id = Student.Dept_Id

SELECT St_Fname, dept_name, D.Dept_Id
FROM Student S, Department D
WHERE D.Dept_Id = S.Dept_Id

SELECT St_Fname, D.*
FROM Student S, Department D
WHERE D.Dept_Id = S.Dept_Id


SELECT St_Fname, Dept_Name
FROM Student S, Department D
WHERE D.Dept_Id = S.Dept_Id AND St_Address = 'Alex'
ORDER BY Dept_Name


SELECT St_Fname, Dept_Name
FROM Student S INNER JOIN Department D
ON D.Dept_Id = S.Dept_Id AND St_Address = 'Alex'
ORDER BY Dept_Name


SELECT St_Fname, Dept_Name
FROM Student S LEFT OUTER JOIN Department D
ON D.Dept_Id = S.Dept_Id

SELECT St_Fname, Dept_Name
FROM Student S RIGHT OUTER JOIN Department D
ON D.Dept_Id = S.Dept_Id

SELECT St_Fname, Dept_Name
FROM Student S FULL OUTER JOIN Department D
ON D.Dept_Id = S.Dept_Id


-- SELF JOIN
SELECT ST.St_Fname AS Student_name, SP.* 
FROM STUDENT ST, STUDENT SP
WHERE ST.St_super = SP.St_Id

SELECT ST.St_Fname AS Student_name, SP.* 
FROM STUDENT ST INNER JOIN STUDENT SP
ON ST.St_super = SP.St_Id

-- Join Multi-tables
SELECT St_Fname, Crs_Name, Grade
FROM Student S, Stud_Course SC, Course C
WHERE S.St_Id = SC.St_Id AND SC.Crs_Id = C.Crs_Id


SELECT St_Fname, Crs_Name, Grade, Dept_Name
FROM Student S INNER JOIN Stud_Course SC
ON S.St_Id = SC.St_Id 
INNER JOIN Course C
ON SC.Crs_Id = C.Crs_Id
INNER JOIN Department D
ON D.Dept_Id = S.Dept_Id



-- JOIN DML 
-- JOIN UPDATE
UPDATE SC
	SET Grade += 10
FROM STUDENT S, Stud_Course SC
WHERE S.St_Id = SC.St_Id AND St_Address = 'Cairo'

-----------------------
SELECT ISNULL(St_Fname, 'UNKNOWN')
FROM Student

SELECT ISNULL(St_Fname, St_Lname)
FROM Student

SELECT COALESCE(St_Fname, St_Lname, St_Address, 'NO DATA') AS STUDENT_NAME
FROM Student

SELECT 'Student Name = ' +ISNULL(St_Fname, '') + ' ' + '& Age = ' + CONVERT(VARCHAR(2), ISNULL(ST_AGE, 0))
FROM Student


SELECT CONCAT(St_Fname, ' ', St_Age)
FROM Student


SELECT *
FROM STUDENT
WHERE St_Fname LIKE 'a%'

/*
 - one char
 % zero or more char
*/

SELECT *
FROM STUDENT
WHERE St_Fname LIKE '%a'

SELECT *
FROM STUDENT
WHERE St_Fname LIKE '_a%'

/*
'a%h'
'%a_'
'ahm%'


*/





