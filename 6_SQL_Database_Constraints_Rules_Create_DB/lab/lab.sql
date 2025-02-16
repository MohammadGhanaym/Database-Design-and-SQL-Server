

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
-- Error: The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Works_on_Employee". The conflict occurred in database "SD_DB", table "dbo.Employee", column 'EmpNo'.
-- That is because there is no employee that has EmpNo=11111

-- 2-Change the employee number 10102  to 11111  in the works on table [what will happen]


-- 3-Modify the employee number 10102 in the employee table to 22222. [what will happen]


