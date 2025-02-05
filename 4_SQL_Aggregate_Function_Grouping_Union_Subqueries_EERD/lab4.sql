USE Company_SD

-- 1.	Display (Using Union Function)
--		a.	 The name and the gender of the dependence that's gender is Female and depending on Female Employee.
--		b.	 And the male dependence that depends on Male Employee.
SELECT D.Dependent_name, D.Sex
FROM Dependent D 
INNER JOIN Employee E
ON D.ESSN = E.SSN
WHERE D.Sex = 'F' AND E.Sex = 'F'
UNION ALL
SELECT D.Dependent_name, D.Sex
FROM Dependent D 
INNER JOIN Employee E
ON D.ESSN = E.SSN
WHERE D.Sex = 'M' AND E.Sex = 'M'

-- 2.	For each project, list the project name and the total hours per week (for all employees) spent on that project.
SELECT Pname, SUM(W.Hours) AS Total_hours_per_week
FROM Project P
INNER JOIN Works_for W
ON P.Pnumber = W.Pno
GROUP BY Pname

-- 3.	Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT D.*
FROM Departments D
INNER JOIN Employee E
ON D.Dnum = E.Dno
WHERE E.SSN = (SELECT MIN(SSN) FROM Employee)

-- 4.	For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
SELECT D.Dname, MAX(E.Salary) AS min_salary, MIN(E.Salary) AS max_salary, AVG(E.Salary) AS avg_salary
FROM Departments D
INNER JOIN Employee E
ON D.Dnum = E.Dno
GROUP BY D.Dname


-- 5.	List the last name of all managers who have no dependents.
-- Assuming he is asking about the managers of employees
SELECT Lname
FROM Employee E
WHERE E.SSN IN (SELECT Superssn FROM Employee) 
AND E.SSN NOT IN (SELECT ESSN FROM Dependent)
-- Assuming he is asking about the managers of departments
SELECT Lname
FROM Employee E
WHERE E.SSN IN (SELECT MGRSSN FROM Departments)
AND E.SSN NOT IN (SELECT ESSN FROM Dependent)
