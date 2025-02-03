USE Company_SD

-- 1.	Display the Department id, name and id and the name of its manager.
SELECT Dnum, Dname, MGRSSN, Fname
FROM Departments, Employee
WHERE MGRSSN = SSN

-- 2.	Display the name of the departments and the name of the projects under its control.
SELECT Dname, Pname
FROM Departments D INNER JOIN Project P
ON D.Dnum = P.Dnum

-- 3.	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
SELECT E.Fname + ' ' + E.Lname AS Employee, D.*
FROM Dependent D INNER JOIN Employee E
ON D.ESSN = E.SSN

-- 4.	Display the Id, name and location of the projects in Cairo or Alex city.
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE CITY IN ('Alex', 'Cairo')

-- 5.	Display the Projects full data of the projects with a name starts with "a" letter.
SELECT *
FROM Project
WHERE Pname LIKE 'a%'

-- 6.	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT *
FROM Employee
WHERE Dno = 30 AND (Salary BETWEEN 1000 AND 2000)

-- 7.	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
SELECT *
FROM Employee E
INNER JOIN Works_for W
ON E.SSN = W.ESSn
INNER JOIN Project P
ON P.Pnumber = W.Pno
WHERE E.Dno = 10 AND W.Hours >= 10 AND P.Pname = 'AL Rabwah'


-- 8.	Find the names of the employees who directly supervised with Kamel Mohamed.
SELECT emp.Fname + ' ' + emp.Lname AS employee_name, mng.Fname + ' ' + mng.Lname AS manager_name
FROM Employee emp INNER JOIN Employee mng
ON mng.SSN = emp.Superssn
WHERE mng.Fname = 'Kamel' AND mng.Lname = 'Mohamed'


-- 9.	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
SELECT CONCAT(E.fname, ' ' , e.Lname), p.Pname
FROM Employee E
INNER JOIN Works_for W
ON E.SSN = W.ESSn
INNER JOIN Project P
ON P.Pnumber = W.Pno
ORDER BY P.Pname

-- 10.	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
SELECT P.Pnumber, D.Dname, E.Lname, E.Address ,E.Bdate
FROM Departments D
INNER JOIN Employee E
ON D.MGRSSN = E.SSN
INNER JOIN Project P
ON P.Dnum = D.Dnum
WHERE P.City = 'Cairo'

-- 11.	Display All Data of the mangers
SELECT E.*
FROM Departments D 
INNER JOIN Employee E
ON D.MGRSSN = E.SSN

-- 12.	Display All Employees data and the data of their dependents even if they have no dependents
SELECT *
FROM Employee E
LEFT OUTER JOIN Dependent D
ON E.SSN = D.ESSN 

-- Data Manipulating Language:
-- 1.	Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
INSERT INTO Employee(Fname, Lname, SSN, Dno, Superssn, Salary)
VALUES('Nour', 'Ghanaym', 102672, 30, 112233, 3000)

INSERT INTO Employee(Fname, Lname, SSN, Dno)
VALUES('Omar', 'Mohamed', 102660, 30)

UPDATE Employee
SET Salary += Salary * 0.2
WHERE Employee.SSN = 102672

SELECT *
FROM Employee