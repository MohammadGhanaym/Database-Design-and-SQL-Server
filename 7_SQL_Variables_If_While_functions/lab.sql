USE ITI	
GO

-- 1.	Create a scalar function that takes date and returns Month name of that date.
CREATE FUNCTION getMonthName(@date datetime)
RETURNS VARCHAR(20)
	BEGIN
	RETURN FORMAT(@date, 'MMMM')
	END

GO 

SELECT dbo.getMonthName(getdate())
GO
-- 2.	 Create a multi-statements table-valued function that takes 2 integers and returns the values between them.

CREATE FUNCTION getRange(@n1 int, @n2 int)
RETURNS @nums TABLE
		(
		 num int
		)
AS
	BEGIN
	WHILE @n1 < @n2 - 1
		BEGIN

		SET @n1 += 1
		INSERT INTO @nums(num)
		VALUES(@n1)

		END
	RETURN
	END

GO

SELECT * FROM getRange(1, 2)
GO
-- 3.	 Create inline function that takes Student No and returns Department Name with Student full name.
CREATE FUNCTION get_StudDept(@st_id int)
RETURNS TABLE
AS
RETURN 
	(
		SELECT CONCAT(S.st_fname, ' ', S.St_Lname) AS [Full Name], D.Dept_Name AS [Department Name]
		FROM Student S
		INNER JOIN Department D
		ON S.Dept_Id = D.Dept_Id
		WHERE S.St_Id = @st_id
	)

GO

SELECT * FROM get_StudDept(6)
GO

-- 4.	Create a scalar function that takes Student ID and returns a message to user 
	-- a.	If first name and Last name are null then display 'First name & last name are null'
	-- b.	If First name is null then display 'first name is null'
	-- c.	If Last name is null then display 'last name is null'
	-- d.	Else display 'First name & last name are not null'

CREATE FUNCTION CheckName(@st_id int)
RETURNS VARCHAR(50)
AS
	BEGIN 
		DECLARE @user_message VARCHAR(50) = NULL
		DECLARE @f_name VARCHAR(20) = NULL
		DECLARE @l_name VARCHAR(20) = NULL

		SELECT @f_name = St_Fname, @l_name = St_Lname FROM Student
		WHERE St_Id = @st_id

		IF @f_name IS NULL AND @l_name IS NULL
			SET @user_message = 'First name & last name are null'
		ELSE IF @f_name IS NULL
			SET @user_message = 'first name is null'
		ELSE IF @l_name IS NULL
			SET @user_message = 'last name is null'
		ELSE
			SET @user_message = 'First name & last name are not null'
		RETURN @user_message
	END

GO

SELECT dbo.CheckName(14)

SELECT * FROM Student
GO
-- 5.	Create inline function that takes integer which represents manager ID and displays department name, Manager Name and hiring date 
CREATE FUNCTION getManagerData(@mang_id int)
RETURNS TABLE
AS
RETURN
(
	SELECT D.Dept_Name, I.Ins_Name AS [Manager Name], D.Manager_hiredate FROM Department D
	INNER JOIN Instructor I
	ON D.Dept_Manager = I.Ins_Id 
	WHERE D.Dept_Manager = @mang_id
)

GO
SELECT * FROM getManagerData(1)
GO
-- 6.	Create multi-statements table-valued function that takes a string
-- If string='first name' returns student first name
-- If string='last name' returns student last name 
-- If string='full name' returns Full Name from student table 
-- Note: Use “ISNULL” function

CREATE FUNCTION GETStudName(@name_type varchar(20))
RETURNS @t TABLE
		(
		 st_name varchar(50)
		)
AS
	BEGIN
	IF @name_type ='first name'
		INSERT INTO @t
		SELECT ISNULL(St_Fname, '') from Student
	ELSE IF @name_type ='last name'
		INSERT INTO @t
		SELECT ISNULL(St_Lname, '') from Student
	ELSE IF @name_type ='full name'
		INSERT INTO @t
		SELECT CONCAT(ISNULL(St_Fname, ''), ' ', ISNULL(St_Lname, '')) from Student
	RETURN
	END
GO
SELECT * FROM GETStudName('full name')

-- 7.	Write a query that returns the Student No and Student first name without the last char
SELECT ST_ID, SUBSTRING(ST_FNAME, 1, LEN(ST_FNAME)-1)
FROM Student
WHERE LEN(ST_FNAME) > 1


-- 8.	Write query to delete all grades for the students Located in SD Department 
UPDATE Stud_Course
	SET grade = NULL
FROM Stud_Course SC
INNER JOIN Student S
ON SC.St_Id = S.St_Id
INNER JOIN Department D
ON D.Dept_Id = S.Dept_Id
WHERE D.Dept_Name = 'SD'