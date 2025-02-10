USE ITI

-- 1.	Retrieve number of students who have a value in their age. 
select count(St_Age)
from student

-- 2.	Get all instructors Names without repetition
select distinct Ins_Name
from Instructor

-- 3.	Display student with the following Format (use isNull function)
select ISNULL(St_Id, '') AS [Student ID], 
	   CONCAT(isnull(st_fname, ''), ' ', ISNULL(st_lname, '')) AS [Full Name],
	   ISNULL(D.Dept_Name, ' ') [AS Department Name]
from Student S
LEFT JOIN Department D
ON S.Dept_Id = D.Dept_Id


-- 4.	Display instructor Name and Department Name 
-- Note: display all the instructors if they are attached to a department or not
select Ins_Name, Dept_Name
from Instructor i
left join Department d
on i.Dept_Id = d.Dept_Id

-- 5.	Display student full name and the name of the course he is taking
-- For only courses which have a grade  
select CONCAT(isnull(st_fname, ''), ' ', ISNULL(st_lname, '')) AS [Full Name],
	   c.Crs_Name
from student s
inner join Stud_Course sc
on s.St_Id = sc.St_Id
inner join Course c
on c.Crs_Id = sc.Crs_Id
where sc.Grade is not null

-- 6.	Display number of courses for each topic name
select t.Top_Name, count(c.Crs_Id) as n_courses
from Topic t
left join Course c
on t.Top_Id = c.Top_Id
group by t.Top_Name

-- 7.	Display max and min salary for instructors
select max(salary) max_sal, min(salary) min_sal
from Instructor

-- 8.	Display instructors who have salaries less than the average salary of all instructors.
select *
from Instructor
where Salary < (select AVG(salary) from Instructor)

-- 9.	Display the Department name that contains the instructor who receives the minimum salary.
-- Return the first department (e.g., when there's only one minimum salary).
select top(1) d.Dept_Name
from Instructor i
inner join  Department d
on i.Dept_Id = d.Dept_Id
order by i.Salary

-- Another solution
-- Return all departments that might have instructors with the same minimum salary and you want to capture all of them.
select d.Dept_Name
from Instructor i
inner join  Department d
on i.Dept_Id = d.Dept_Id
where i.Salary = (select MIN(salary) from Instructor)

-- 10.	 Select max two salaries in instructor table. 
select top(2)Salary
from Instructor
order by Salary desc

-- 11.	 Select instructor name and his salary but if there is no salary display instructor bonus. “use one of coalesce Function”
select Ins_Name, coalesce(Salary, 'bonus')
from Instructor

-- 12.	Select Average Salary for instructors 
select AVG(salary)
from Instructor

-- 13.	Select Student first name and the data of his supervisor 
select s.St_Fname AS [Student First Name], s_sup.*
from student s
inner join Student s_sup
on s.St_super = s_sup.St_Id


-- 14.	Write a query to select the highest two salaries in Each Department for instructors who have salaries. “using one of Ranking Functions”
-- assuming that we only need two salaries without ties
select *
from
	(select *, row_number() over (partition by dept_id order by salary desc) as RN
	from Instructor
	where Dept_Id is not null and Salary is not null) as newtable
where RN <= 2


-- 15.	 Write a query to select a random  student from each department.  “using one of Ranking Functions”
select * 
from (select *, ROW_NUMBER() over (partition by dept_id order by newid()) as RN
	  from Student) as newtable
where RN = 1


