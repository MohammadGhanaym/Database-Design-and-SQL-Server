

-- Create a new data type for department location
	-- Type: nchar(2)
	-- Default value: 'NY'
	-- Range of values: ('NY', 'DS', 'KW')

sp_addtype loc, 'nchar(2)'

CREATE DEFAULT locDef AS 'NY'

CREATE RULE locR1 AS @x IN ('NY', 'DS', 'KW')

sp_bindefault locDef, loc

sp_bindrule locR1, loc

-- Create the Department Table
CREATE TABLE Department
(
 DeptNo varchar(20),
 DeptName varchar(50),
 [Location] loc,

 CONSTRAINT C1 PRIMARY KEY(DeptNo)
)

-- Insert 3 rows in the Department table
INSERT INTO Department(DeptNo, DeptName, Location)
VALUES
('d1', 'Research', 'NY'),
('d2', 'Accounting', 'DS'), 
('d3', 'Marketing', 'KW')

-- Create the Employee Table
CREATE TABLE Employee
(
 EmpNo int PRIMARY KEY,
 Emp_Fname varchar(30) NOT NULL,
 Emp_Lname varchar(30) NOT NULL,
 Dept_No varchar(20),
 Salary int,

 CONSTRAINT C2 FOREIGN KEY(Dept_No) REFERENCES Department(DeptNo),
 CONSTRAINT C3 UNIQUE(Salary),
)

-- Create new rule for salary to force the salary to be below 6000
CREATE RULE Salary_R1 AS @x < 6000

sp_bindrule Salary_R1, 'Employee.Salary'

-- Insert values into the Employee Table
INSERT INTO Employee(EmpNo, Emp_Fname, Emp_Lname, Dept_No, Salary)
VALUES(25348, 'Mathew', 'Smith', 'd3', 2500),
(10102, 'Ann', 'Jones', 'd3', 3000),
(18316, 'John', 'Barrimore', 'd1', 2400),
(29346, 'James', 'James', 'd2', 2800),
(9031, 'Lisa', 'Bertoni', 'd2', 4000),
(2581, 'Elisa', 'Hansel', 'd2', 3600),
(28559, 'Sybl', 'Moser', 'd1', 2900)


-- Testing Referential Integrity
-- 1-Add new employee with EmpNo =11111 In the works_on table [what will happen]
INSERT INTO Works_on(EmpNo, ProjectNo, Job)
Values(11111, 'p1', 'Clerk')
-- ERROR: The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Works_on_Employee". The conflict occurred in database "SD_DB", table "dbo.Employee", column 'EmpNo'.
-- That is because there is no employee that has EmpNo=11111

-- 2-Change the employee number 10102  to 11111  in the works on table [what will happen]
UPDATE Works_on
	SET EmpNo=11111
	WHERE EmpNo=10102
-- ERROR: The UPDATE statement conflicted with the FOREIGN KEY constraint "FK_Works_on_Employee". The conflict occurred in database "SD_DB", table "dbo.Employee", column 'EmpNo'.

-- 3-Modify the employee number 10102 in the employee table to 22222. [what will happen]
UPDATE Employee
	SET EmpNo=22222
	WHERE EmpNo=10102
-- ERROR: The UPDATE statement conflicted with the REFERENCE constraint "FK_Works_on_Employee". The conflict occurred in database "SD_DB", table "dbo.Works_on", column 'EmpNo'.

-- 4-Delete the employee with id 10102
DELETE FROM Employee
WHERE EmpNo=10102
-- ERROR: The DELETE statement conflicted with the REFERENCE constraint "FK_Works_on_Employee". The conflict occurred in database "SD_DB", table "dbo.Works_on", column 'EmpNo'.


-- 2.	Create the following schema and transfer the following tables to it 
--		a.	Company Schema 
--			i.	Department table (Programmatically)
--			ii.	Project table (using wizard)
--		b.	Human Resource Schema
--			i.	  Employee table (Programmatically)

CREATE SCHEMA Company

ALTER SCHEMA Company TRANSFER Department

CREATE SCHEMA [Human Resource]

ALTER SCHEMA [Human Resource] TRANSFER Human_Resource.Employee

-- 3.	 Write query to display the constraints for the Employee table.

sp_helpconstraint '[Human Resource].Employee'


-- 4.	Create Synonym for table Employee as Emp and then run the following queries and describe the results
--		a.	Select * from Employee
--		b.	Select * from [Human Resource].Employee
--		c.	Select * from Emp
--		d.	Select * from [Human Resource].Emp


CREATE SYNONYM Emp for [Human Resource].Employee

Select * from Employee
-- ERROR: Because Employee table is not in the default schema (dbo)

Select * from [Human Resource].Employee
-- Works Fine

Select * from Emp
-- Works Fine

Select * from [Human Resource].Emp
-- ERROR: Emp is already a synonym to [Human Resource].Employee


-- 5.	Increase the budget of the project where the manager number is 10102 by 10%.
UPDATE Project
	SET Budget += (Budget * 0.1)
	WHERE MANAGER_NUM =10102


-- 6.	Change the name of the department for which the employee named James works.The new department name is Sales.
UPDATE [Company].Department
	SET DeptName = 'Sales'
WHERE DeptNo = (SELECT Dept_No FROM [Human Resource].Employee
				WHERE Emp_Fname = 'James')

-- 7.	Change the enter date for the projects for those employees who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.
UPDATE Works_on
	SET Enter_Date = '12.12.2007'
WHERE ProjectNo = 'p1' 
AND EmpNo IN (SELECT EmpNo 
			FROM [Human Resource].Employee e
			INNER JOIN Company.Department d
			ON e.Dept_No = d.DeptNo
			WHERE d.DeptName = 'Sales'
			)


-- 8.	Delete the information in the works_on table for all employees who work for the department located in KW.
DELETE FROM Works_on
WHERE EmpNo IN (SELECT EmpNo 
			FROM [Human Resource].Employee e
			INNER JOIN Company.Department d
			ON e.Dept_No = d.DeptNo
			WHERE d.Location = 'KW'
			)

