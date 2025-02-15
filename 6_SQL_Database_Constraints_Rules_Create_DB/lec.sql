-- Selecting all records from the Student table
SELECT *
FROM dbo.Student;

-- Creating schemas
CREATE SCHEMA HR;
CREATE SCHEMA sales;

-- Transferring tables between schemas
ALTER SCHEMA HR TRANSFER Student;
ALTER SCHEMA HR TRANSFER Instructor;
ALTER SCHEMA sales TRANSFER department;

-- Creating a table in the sales schema
CREATE TABLE sales.student (
    id INT,
    name VARCHAR(20)
);

-- Selecting data from HR schema tables
SELECT * FROM HR.Instructor;
SELECT * FROM HR.Student;

-- Using AdventureWorks2012 database
USE AdventureWorks2012;

-- Selecting from EmployeeDepartmentHistory
SELECT * FROM HumanResources.EmployeeDepartmentHistory;

-- Creating a synonym
CREATE SYNONYM HE FOR HumanResources.EmployeeDepartmentHistory;

-- Selecting from the synonym
SELECT * FROM HE;

-- Dropping a table (removes data and metadata)
DROP TABLE course;

-- Deleting data from a table
DELETE FROM course;  -- Removes data only
-- We can use `WHERE` with DELETE
-- DELETE is slower as it logs transactions
-- Allows rollback
-- Does not reset Identity

-- Truncating a table
TRUNCATE TABLE course;  -- Removes all data
-- No `WHERE` condition allowed
-- Faster than DELETE
-- Not logged in transaction log
-- Cannot be rolled back
-- Resets Identity

-- Creating a test table
CREATE TABLE test1 (
    id INT IDENTITY,
    name VARCHAR(20)
);

-- Inserting data into test1
INSERT INTO test1 VALUES ('Ali');

-- Selecting data from test1
SELECT * FROM test1;

-- Deleting data from test1
DELETE FROM test1;

-- Truncating test1
TRUNCATE TABLE test1;

-------------------------------------------
-- Using ITI database
USE ITI;

-- Creating Dept table
CREATE TABLE Dept (
    Dept_id INT PRIMARY KEY,
    dname VARCHAR(20)
);

-- Creating empl table with constraints
CREATE TABLE empl (
    eid INT IDENTITY(1, 1), 
    ename VARCHAR(20),
    eadd VARCHAR(20) DEFAULT 'Alex',
    hiredate DATE DEFAULT GETDATE(),
    sal INT,
    overtime INT,
    netsal AS (ISNULL(sal, 0) + ISNULL(overtime, 0)) PERSISTED,
    DB DATE,
    age AS (YEAR(GETDATE()) - YEAR(DB)),
    gender VARCHAR(1),
    hour_rate INT NOT NULL,
    did INT,
    CONSTRAINT c1 PRIMARY KEY (eid, ename),
    CONSTRAINT c2 UNIQUE (sal),
    CONSTRAINT c3 UNIQUE (overtime),
    CONSTRAINT c4 CHECK (sal > 1000),
    CONSTRAINT c5 CHECK (eadd IN ('Cairo', 'Mansoura', 'Alex')),
    CONSTRAINT c6 CHECK (gender = 'F' OR gender = 'M'),
    CONSTRAINT c7 CHECK (overtime BETWEEN 100 AND 500),
    CONSTRAINT c8 FOREIGN KEY (did) REFERENCES Dept(Dept_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);
