use iti

-- Variables
declare @x int
set @x = 10

select @x


declare @y int
select @y = 10

select @y


declare @z int=100
select @z

declare @age int=(select avg(st_age) from student)
select @age


declare @age_id_6 int
select @age_id_6=St_Age from student where st_id=6
select @age_id_6

declare @x int=100
select @x=st_age from student where St_Address = 'Alex'
select @x


declare @z int
update student set St_Fname='Ali', @z=dept_id
where St_Id = 7
select @z


declare @t table(x int, y varchar(20))
insert into @t
select St_Id, St_Fname from student where St_Address = 'Alex'
select * from @t


declare @x int=3
select top(@x)*
from student


-- ERROR
declare @col varchar(20)='*', @tab varchar(20)='student'
select @col from @tab
-- ERROR

select * from student

select 'select * from student'

execute ('select * from student')

-- Dynamice Query
declare @col varchar(20)='*', @tab varchar(20)='student'
execute('select ' + @col + ' from ' + @tab)


-- Global Variables
select @@VERSION
select @@SERVERNAME

Update student
	set St_Age += 1
select @@ROWCOUNT AS 'Number of Rows Affected'
select @@ROWCOUNT

select * from st
go
select @@ERROR


select @@IDENTITY


----------------------------
-- Control of flow statement
----------------------------

-- if
declare @x int
update student
	set St_Age += 1

select @x=@@ROWCOUNT
if @x > 0
	begin
	select 'Mulit Rows Affected'
	end
else
	begin
	select 'No Rows Affected'
	end

-- begin
-- end
-- if exists if not exists

select * from sys.all_columns

select * from sys.tables

if exists (select name from sys.tables where name ='student')
	select 'Table is Existed'
else
	CREATE TABLE student
	(
	 id int,
	 name varchar(20)
	)

IF NOT EXISTS(SELECT dept_id from student where Dept_Id=20)
	and NOT EXISTS(SELECT	dept_id from Instructor WHERE Dept_Id=20)
	delete from Department where dept_id=20
ELSE
	SELECT 'ERROR: Table has relationships with other tables'


begin try
	delete from Department where dept_id=20
end try
begin catch
	SELECT 'ERROR: Table has relationships with other tables'
	select ERROR_LINE(), ERROR_NUMBER(), ERROR_MESSAGE()
end catch

-- while 
declare @x int=10
while @x <=20
	begin
		set @x += 1
		if @x = 14 
			continue
		if @x = 16
			break
		select @x
	end

-- continue
-- break
-- case
-- if
-- wait for
-- choose

-- WAITFOR is used to pause execution for a specific time or until a certain event occurs.

WAITFOR DELAY '00:00:05';  -- Waits for 10 seconds
PRINT '10 seconds have passed!';


WAITFOR TIME '11:42:59';  -- Waits until 11:59:59 PM
PRINT 'Midday has arrived!';

WAITFOR (RECEIVE * FROM MessageQueue), TIMEOUT 5000;  -- Waits for a message or 5 seconds

-- CHOOSE is a shortcut for selecting values from a list based on an index.
SELECT CHOOSE(3, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') AS Day;

DECLARE @Category INT = 2;

SELECT CHOOSE(@Category, 'Basic', 'Standard', 'Premium') AS SubscriptionType;


DECLARE @Index INT = 2;

WAITFOR DELAY '00:00:05';  -- Wait 5 seconds before executing the next line

SELECT CHOOSE(@Index, 'Low', 'Medium', 'High') AS Priority;



----------------------------------------
-- batch, transaction, script
-- batch
insert 
update
delete

-- script
create table
go
drop table
go

create rule
go
sp_bindrule
go
-- transactions
-- all run, or all fails

CREATE TABLE Parent(pid int primary key)
CREATE TABLE Child(cid int foreign key references Parent(pid))

-- batch
INSERT INTO Parent VALUES(1)
INSERT INTO Parent VALUES(2)
INSERT INTO Parent VALUES(3)
INSERT INTO Parent VALUES(4)

-- batch
INSERT INTO Child VALUES(1) -- run
INSERT INTO Child VALUES(5) -- error
INSERT INTO Child VALUES(3) -- run

TRUNCATE TABLE CHILD

-- Transaction
BEGIN TRANSACTION
	INSERT INTO Child VALUES(1) 
	INSERT INTO Child VALUES(2) 
	INSERT INTO Child VALUES(3) 
ROLLBACK

SELECT * FROM Child -- Empty table, because we used ROLLBACK

BEGIN TRANSACTION
	INSERT INTO Child VALUES(1) 
	INSERT INTO Child VALUES(5) 
	INSERT INTO Child VALUES(3) 
COMMIT

SELECT * FROM Child -- 1, 3 only, it acts like a batch

-- We need to use ROLLBACK When there is an error, else use COMMIT
BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO Child VALUES(1) -- RUN
		INSERT INTO Child VALUES(5) -- ERROR: STOP HERE AND GO TO CATCH 
		INSERT INTO Child VALUES(3) 
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK -- AND ROLLBACK
END CATCH


---------------------------
-- Functions
---------------------------
-- Built-in Functions
-- User Defined Functions

--1. Built-in Functions
-- NULL -- > ISNULL(), COALESCE(), NULLIF() 
-- SYSTEM --> DB_NAME(), SUSER_NAME()
-- CONVERT --> CONVERT(), CAST(), FORMAT()
-- STRING --> SUBSTRING(), UPPER(), LOWER(), LEN()
-- DATE --> GETDATE(), YEAR(), MONTH(), DAY()
-- AGGREGATE --> COUNT(), MAX(), MIN(), AVG(), SUM()
-- MATH --> POWER(), LOG(), SIN(), COS(), TAN()
-- RANKING --> ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE()
-- LOGICAL FUNCTIONS --> IIF, CHOOSE
-- WINDOWING --> LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()

-- Built-in functions called scaler functions
-- Return only one value

--2. User Defined Functions
-- We can create 3 types of functions
--	1. Scaler Function
--	2. Inline table Function
--	3. Multi Statement Table Valued Function

-- Select Statements only
-- Must Return something
-- Return 1 value --> scaler function
-- Return Table (depends on the function body)
-- If the body only has `select` --> Inline Table Function
-- If the body select with any logic (e.g if, declare variable, while, ...etc) --> Multi statement table valued function

---- Functions
select GETDATE()

select ISNULL(st_fname, '') from Student

select UPPER(st_fname), LOWER(st_lname) from Student

select st_fname, len(st_fname) from Student

select max(st_fname)
from Student

select coalesce(st_fname, st_lname, '')
from Student


SELECT top(1)St_Fname
from Student
ORDER BY len(st_fname) DESC

select power(salary, 2) from Instructor

select CONVERT(varchar(20), getdate(), 101)

select FORMAT(getdate(), 'dd-MM-yyyy')

select DB_NAME(), SUSER_NAME()

go

-- =======================
-- Create My Own Functions
-- =======================

CREATE FUNCTION getsname(@id int)
RETURNS VARCHAR(20)
	begin
		DECLARE @name varchar(20)
		select @name=st_fname from student
			WHERE student.St_Id = @id
		return @name
	end

go

SELECT dbo.GETSNAME(1)
go
-----------------------------
CREATE FUNCTION GetInstructor(@did int)
RETURNS table
as
return
(
	select ins_name, salary * 12 as totalsal
	from Instructor
	where Dept_Id = @did
)

go

SELECT * from GetInstructor(10)

select ins_name from GetInstructor(10)

select sum(totalsal) from GetInstructor(10)
go
----------------------------
-- Multi-statement functions
----------------------------

CREATE FUNCTION GetStuds(@format varchar(20))
RETURNS @t TABLE
	(
	 id int,
	 ename varchar(20)
	)
AS 
	BEGIN
		if @format = 'first'
			INSERT INTO @t
			SELECT st_id, st_fname from Student
		else if @format = 'last'
			INSERT INTO @t
			SELECT st_id, St_Lname from Student
		else if @format = 'full'
			INSERT INTO @t
			SELECT st_id, CONCAT(St_Fname, ' ', St_Lname) from Student
		RETURN
	END

go

SELECT * FROM GetStuds('full')

-------------------------------------
-- Windowing
-- LEAD, LAG, FIRST_VALUE, LAST_VALUE
-------------------------------------

SELECT s.St_Id as sid, St_Fname as sname, grade, Crs_Name as Cname INTO grades
FROM Student s, Stud_Course sc, Course c
where s.St_Id = sc.St_Id and sc.Crs_Id = c.Crs_Id

select * from grades

SELECT sname, grade, Cname,
	prod_prev = LAG(sname) over(order by grade),
	prod_next = LEAD(sname) over(order by grade)
from grades


SELECT *
FROM(
	SELECT sname, grade, Cname,
		prod_prev = LAG(sname) over(order by grade),
		prod_next = LEAD(sname) over(order by grade)
	from grades) AS newTable
WHERE sname = 'Saly'


SELECT sname, grade, cname,
	prod_prev = LAG(grade) over(partition by cname order by grade),
	prod_next = LEAD(grade) over(partition by cname order by grade)
from grades

-------------
SELECT sname, grade,
	First = FIRST_VALUE(sname) over(order by grade),
	last = LAST_VALUE(sname) over(order by grade)
from grades

SELECT sname, grade, cname,
	First = FIRST_VALUE(sname) over(partition by cname order by grade),
	last = LAST_VALUE(sname) over(partition by cname order by grade ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
from grades









