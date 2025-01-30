-- Use the ITI database
USE ITI;

-- Select all records from the Student table
SELECT * FROM Student;

-- Insert a new student record
INSERT INTO Student (St_Id, St_Fname)
VALUES (55, 'Ali');

/*
    This is a comment block for multi-line explanations
    - Inserting data into the Student table
*/

---------------------------------------------------
-- Data Definition Language (DDL)
---------------------------------------------------

-- Create Employee (emp) table with constraints
CREATE TABLE emp (
    eid INT PRIMARY KEY, -- Employee ID as primary key
    ename VARCHAR(20) NOT NULL, -- Employee name (mandatory field)
    age INT, -- Employee age
    emp_address VARCHAR(20) DEFAULT 'Cairo', -- Default address is Cairo
    hiredate DATE DEFAULT GETDATE(), -- Default hire date is current date
    Dnum INT -- Department number
);

-- Alter table: Add salary column
ALTER TABLE emp ADD salary INT;

-- Alter table: Change salary column data type to BIGINT
ALTER TABLE emp ALTER COLUMN salary BIGINT;

-- Alter table: Drop salary column
ALTER TABLE emp DROP COLUMN salary;

-- Drop the entire emp table
DROP TABLE emp;

---------------------------------------------------
-- Data Manipulation Language (DML)
---------------------------------------------------

-- Insert data into emp table
INSERT INTO emp VALUES (1, 'Ali', NULL, 'Alex', '2010-01-01', NULL);

-- Insert with specific columns
INSERT INTO emp (ename, eid) VALUES ('Eman', 2);

-- Insert multiple records at once (Insert Constructor)
INSERT INTO emp (ename, eid) VALUES ('Nour', 8), ('Omar', 9), ('Ibrahim', 10);

-- Update employee name where eid = 1
UPDATE emp SET ename = 'Omar' WHERE eid = 1;

-- Update employee name and age where eid = 1
UPDATE emp SET ename = 'Omar', age = 22 WHERE eid = 1;

-- Increase age for all employees by 1
UPDATE emp SET age += 1;

-- Set age to NULL for all employees
UPDATE emp SET age = NULL;

-- Delete all data in emp table
DELETE FROM emp;

-- Delete a specific record where eid = 1
DELETE FROM emp WHERE eid = 1;

---------------------------------------------------
-- Data Query Language (DQL)
---------------------------------------------------

-- Select all columns from Student table
SELECT * FROM Student;

-- Select specific columns from Student table
SELECT St_Id, St_Fname FROM Student;

-- Select students who are 25 years or older
SELECT St_Id, St_Fname FROM Student WHERE St_Age >= 25;

-- Select all students ordered by age in descending order
SELECT * FROM Student ORDER BY St_Age DESC;

-- Concatenate first name and last name as full name
SELECT St_Fname + ' ' + St_Lname AS [Full Name] FROM Student;

-- Select students where both first and last names are NOT NULL
SELECT * FROM Student WHERE St_Fname IS NOT NULL AND St_Lname IS NOT NULL;

-- Select all unique first names from Student table
SELECT DISTINCT St_Fname FROM Student;

-- Select students who live in Mansoura or Alex
SELECT * FROM Student WHERE St_Address = 'Mansoura' OR St_Address = 'Alex';

-- Select students who live in Cairo, Mansoura, or Alex using IN operator
SELECT * FROM Student WHERE St_Address IN ('Cairo', 'Mansoura', 'Alex');

-- Select students who live in Mansoura AND are at least 25 years old
SELECT * FROM Student WHERE St_Address = 'Mansoura' AND St_Age >= 25;

-- Select students whose age is between 23 and 25 (inclusive)
SELECT * FROM Student WHERE St_Age BETWEEN 23 AND 25;
