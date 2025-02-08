select top(3)*
from Student

select top(3) St_Fname
from Student

select top(3) St_Fname
from Student
where st_address = 'alex'

select top(3) salary
from Instructor

select max(salary)
from Instructor

select top(2) salary
from Instructor
order by Salary desc

select distinct top(2) salary
from Instructor
order by Salary desc

select top(6) with ties *
from Student
order by St_Age

select NEWID() -- Global Universal ID (unique server level)


select *, newid()
from student

-- select 3 random students
select top(3)*
from student
order by newid()


select st_fname + ' ' + st_lname as fullname
from Student 
order by fullname

select st_fname + ' ' + st_lname as fullname
from Student 
where fullname = 'ahmed ali'

-- Execution Order
-- From 
-- Join
-- On
-- Where
-- Grouping
-- Having
-- Select [distinct + agg]
-- Order by
-- Top
-- DB objects (table, view, function, SP, Rule)
-- Default Path
	-- [ServerName].[DBName].[schemaName].[objectName]


select st_fname + ' ' + st_lname as fullname
from Student 
where CONCAT(st_fname , ' ' , st_lname) = 'ahmed ali'

select *
from (select st_fname + ' ' + st_lname as fullname 
		from Student) as NewTable 
where fullname = 'ahmed ali'

select *
from [DESKTOP-0AIO3S2].ITI.dbo.Student

select *
from [DESKTOP-0AIO3S2].company_sd.dbo.project

select *
from company_sd.dbo.project


select dname
from Company_SD.dbo.Departments
union all
select Department.dept_name
from Department

-- DDL
-- create new table that contain all the data from student
select * into table2
from Student

select * from table2

select st_id, st_fname into alex_residents
from Student
where St_Address = 'alex'

-- create an empty table that has the student table structure
select * into tab4
from Student
where 1=2

insert into tab4(St_Id, St_Fname)
values(66, 'ali')

-- insert based on select
insert into tab4
select * from Student