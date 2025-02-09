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

select sum(salary)
from Instructor
having count(ins_id) < 100

-- Ranking Functions
--------------------
-- Used with select
-- row_number() over (order by col_name)
-- dense_rank() over (order by col_name)
-- ntiles(group) over (order by col_name)
-- rank()

-- RANK(): Skips ranks after ties.

-- DENSE_RANK(): Does not skip ranks after ties.

-- ROW_NUMBER(): Assigns a unique number to each row, even if there are ties.

select * , DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DR, 
		   RANK() OVER(ORDER BY SALARY DESC) AS R
FROM Instructor

-- PARTITION BY
-- row_number() over (partition by col_name order by col_name)
-- dense_rank() over (order by col_name)
-- ntiles(group) over (order by col_name)

select *
from (select *, row_number() over(order by st_age desc) as RN
		from Student) as newtable
where RN = 1


select *
from (select *, dense_rank() over(order by st_age desc) as RD
		from Student) as newtable
where RD = 1

select *
from (select *, row_number() over(partition by dept_id order by st_age desc) as RN
		from Student) as newtable
where RN = 1

select *
from (select *, dense_rank() over(partition by dept_id order by st_age desc) as RN
		from Student) as newtable
where RN = 1


select *
from 
	(select *, ntile(4) over(order by st_age desc) as G
	from Student) as newtable
where G=1


--------------------------------------
--				DataTypes
--------------------------------------
--------- Numeric Datatype
-- bit -- it is like boolean in programming (0,1) (true, false)
-- tinyint --> 1 Byte (-128:+127)	--> unsigned (0:255)
-- samllint --> 2 Bytes (-32768:+32767) 
-- int 4B
-- bigint 8B

--------- Decimal Datatype
-- smallmoney 4B --> .0000
-- money      8B --> .0000
-- real              .0000000
-- float			 .0000000000000000000000
-- dec decimal	dec(5, 2) 5 digit (2 of them are decimal)

--------- Char Datatype
-- char(10) ---> fixed length character (only 10 bytes)
-- varchar(10) --> (variable length character) it depened on the entries values
-- nchar(10) --> detect language (unicode)
-- nvarchar(10)
-- nvarchar(max) --> up to 2GB

--------- Datetime
-- date				MM/DD/yyyy
-- time				hh:mm:12.765
-- time(7)			hh:mm:12.7659876
-- smalldatetime	MM/DD/yyyy hh:mm:00
-- datetime			MM/DD/yyyy hh:mm:ss.987
-- datetime2(7)		MM/DD/yyyy hh:mm:ss.9879876
-- datetimeoffset	11/24/2020	10:30	+2:00      (Timeszone)

--------- Binary
-- binary 0111100    11111100
-- image  save images as binary


-- others
-- XML
-- unique_identifier
-- sql_variant

select ins_name, salary,
		case
		when salary >= 3000 then 'High Salary'
		when salary < 3000 then 'Low'
		else 'No Value'
		end
from Instructor

select ins_name, iif(salary >= 3000, 'High', 'Low')
from Instructor

update Instructor
	set Salary = 
	case 
	when salary >= 3000 then salary * 1.10
	else salary * 1.20
	end

--------------------------------------------------
select convert(varchar(20), getdate())

select cast(getdate() as varchar(10))

select convert(varchar(20), getdate(), 102)
select convert(varchar(20), getdate(), 103)
select convert(varchar(20), getdate(), 104)
select convert(varchar(20), getdate(), 105)


select FORMAT(getdate	(), 'dd-MM-yyyy')
select FORMAT(getdate	(), 'dddd MMMM yyyy')
select FORMAT(getdate	(), 'ddd MMM yy')
select FORMAT(getdate	(), 'dddd')
select FORMAT(getdate	(), 'MMMM')
select FORMAT(getdate	(), 'hh:mm:ss')
select FORMAT(getdate	(), 'HH')
select FORMAT(getdate	(), 'hh tt')
select FORMAT(getdate	(), 'dd-MM-yyyy hh:mm:ss tt')
select FORMAT(getdate	(), 'dd')

select year(getdate())
select day(getdate())
select MONTH(getdate())

select format(EOMONTH(getdate()), 'dddd')





















