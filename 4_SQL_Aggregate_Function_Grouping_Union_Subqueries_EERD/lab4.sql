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


-- 6.	For each department-- if its average salary is less than the average salary of all employees
-- display its number, name and number of its employees.
SELECT D.Dnum, D.Dname, COUNT(E.SSN)
FROM Departments D
INNER JOIN Employee E
ON D.Dnum = E.Dno
GROUP BY D.Dnum, D.Dname
HAVING AVG(E.Salary) < (SELECT AVG(Salary) FROM Employee)

-- 7.	Retrieve a list of employees and the projects they are working on ordered by department and within each department
-- , ordered alphabetically by last name, first name.
SELECT *
FROM Employee E
INNER JOIN Works_for W
ON E.SSN = W.ESSn
INNER JOIN Project P
ON P.Pnumber = W.Pno
ORDER BY E.Dno, E.Lname, E.Fname

-- 8.	Try to get the max 2 salaries using subquery
SELECT MAX(Salary) AS top_salary
FROM Employee
UNION ALL
SELECT MAX(Salary) AS top_2_salary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee)

-- 9.	Get the full name of employees that is similar to any dependent name
SELECT DISTINCT CONCAT(E.FNAME, ' ' , E.LNAME) AS FULL_NAME
FROM Employee E
INNER JOIN Dependent D
ON E.SSN = D.ESSN
WHERE CONCAT(E.FNAME, ' ' , E.LNAME) = D.Dependent_name

-- 10.	Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 
UPDATE Employee
	SET Salary += (Salary * 0.3)
FROM Employee E
INNER JOIN Works_for W
ON E.SSN = W.ESSn
INNER JOIN Project P
ON P.Pnumber = W.Pno
WHERE P.Pname = 'Al Rabwah'

-- 11.	Display the employee number and name if at least one of them have dependents (use exists keyword) 
SELECT SSN, Fname
FROM Employee E
WHERE EXISTS (SELECT 1 FROM Dependent D WHERE E.SSN = D.ESSN)

-----------------
-- DML

-- 1.	In the department table insert new department called "DEPT IT" , with id 100, employee with SSN = 112233 as a manager for this department. 
-- The start date for this manager is '1-11-2006'
INSERT INTO Departments
VALUES('DEPT IT', 100, 112233,'1-11-2006')

-- 2.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), 
--		and they give you(your SSN =102672) her position (Dept. 20 manager) 
--		a.	First try to update her record in the department table
--		b.	Update your record to be department 20 manager.
--		c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

UPDATE Departments
	SET MGRSSN = 968574
WHERE Departments.Dnum = 100 AND EXISTS (
	SELECT 1 FROM Employee
	WHERE SSN = 968574
	);

UPDATE Departments
	SET MGRSSN = 102672
WHERE Departments.Dnum = 20 AND EXISTS (
	SELECT 1 FROM Employee
	WHERE SSN = 102672
	);


UPDATE Employee
	SET Superssn = 102672
WHERE SSN = 102660 AND EXISTS (
	SELECT 1 FROM Employee
	WHERE SSN = 102672
	);


-- 3.	Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) 
--      so try to delete his data from your database in case you know that you will be temporarily in his position.
--      Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).

UPDATE Employee
	SET Superssn = 102672
WHERE Superssn = 223344

UPDATE Departments
	SET MGRSSN = 102672
WHERE MGRSSN = 223344

DELETE Works_for
WHERE ESSn = 223344

DELETE Employee
WHERE SSN = 223344

