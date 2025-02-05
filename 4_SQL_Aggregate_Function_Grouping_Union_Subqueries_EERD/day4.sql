USE ITI


SELECT SUM(Salary)
FROM Instructor

SELECT MIN(Salary) AS min_salary, MAX(Salary) AS max_salary
FROM Instructor


SELECT count(*), count(st_id), count(st_lname), count(st_age)
from Student

select AVG(ISNULL(st_age, 0))
from Student

select SUM(st_age) / count(*)
from Student

select sum(salary), Dept_Id
from Instructor
group by Dept_Id


select sum(salary), d.Dept_Id, dept_name
from Instructor i inner join Department d
ON d.Dept_Id = i.dept_id
group by d.Dept_Id, dept_name

select avg(st_age), st_address, dept_id
from student 
group by st_address, dept_id


select sum(salary), Dept_Id
from Instructor
group by Dept_Id



select sum(salary), Dept_Id
from Instructor
where Salary > 1000
group by Dept_Id


select sum(salary), Dept_Id
from Instructor
group by Dept_Id
having sum(salary) > 100000


select sum(salary), Dept_Id
from Instructor
group by Dept_Id
having count(Ins_Id) < 6



select sum(salary), Dept_Id
from Instructor
where Salary > 1000
group by Dept_Id
having count(Ins_Id) < 6

-----------------------------------------
-- Subqueries

select *
from Student 
where St_Age < (select AVG(st_age) from Student)

select *, (select count(st_id) from student) as student_count
from Student


select dept_name
from Department 
where Dept_Id in (select distinct(Dept_Id) 
				  from Student 
				  where Dept_Id is not null)



Select Distinct(dept_name)
from Student s inner join Department d
on d.Dept_Id = s.Dept_Id



-- Subquery + DML
Delete from Stud_Course
where St_Id = 1

Delete from Stud_Course
where St_Id in (select st_id from Student where St_Address = 'Cairo')

--------------------------------
-- Union Family
-- union all 
-- union
-- intersect
-- except

-- `union all` will join the results of the 2 queries
select st_fname as names
from Student
union all
select ins_name
from Instructor

-- `union` return the distinct results and order it
select st_fname as names
from Student
union
select ins_name
from Instructor

-- return the distinct results that exist in both queries output (order the result)
select st_fname as names
from Student
intersect
select ins_name
from Instructor

-- return the names of students that are not similar to instructor names (order the result)
select st_fname as names
from Student
except
select ins_name
from Instructor

select st_fname, st_id
from Student
intersect
select ins_name, ins_id
from Instructor


select St_Fname, st_age, Dept_Id
from Student
order by St_Address


select St_Fname, st_age, Dept_Id
from Student
order by 1

select St_Fname, st_age, Dept_Id
from Student
order by 2


select St_Fname, st_age, Dept_Id
from Student
order by Dept_Id asc, st_age desc


-- These queries won't work because department table is a parent table
delete from Department where Dept_Id = 20
update Department set Dept_Id=4000 where Dept_Id = 20

-- built-in functions
-- Agg functions
-- getdate()  isnull()   coalesce() concat() convert()  year() month() day()
-- substring()
select DB_NAME()
select SUSER_NAME()