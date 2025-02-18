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





















