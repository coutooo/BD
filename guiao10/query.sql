use EncomendasProj;
/*
-- 10.1
-- a)
GO
CREATE PROCEDURE p_RemoveEmployee (@Employee_ssn CHAR(9))
AS
	DELETE dbo.WORKS_ON WHERE Essn=@Employee_ssn;
	DELETE dbo.WORKS_ON WHERE Essn=@Employee_ssn;
	UPDATE dbo.DEPARTMENT SET Mgr_ssn = null, Mgr_start_date = null WHERE Mgr_ssn = @Employee_ssn;
	UPDATE dbo.EMPLOYEE SET Super_ssn = null WHERE Super_ssn = @Employee_ssn;
	DELETE dbo.EMPLOYEE WHERE Ssn=@Employee_ssn;
GO


-- b)
GO
CREATE PROCEDURE p_DepartmentManagers (@OldestEmployee_ssn CHAR(9) OUTPUT, @OldestEmployee_years INT OUTPUT)
AS
	SELECT TOP 1 @OldestEmployee_ssn=Ssn, @OldestEmployee_years=DATEDIFF(YEAR, DEP.Mgr_start_date, GETDATE())
	FROM (dbo.DEPARTMENT AS DEP JOIN dbo.EMPLOYEE AS EMP on DEP.Mgr_ssn = EMP.Ssn)
	ORDER BY Mgr_start_date DESC;

	SELECT * FROM (dbo.DEPARTMENT AS DEP JOIN dbo.EMPLOYEE AS EMP on DEP.Mgr_ssn = EMP.Ssn);
GO


-- c)
GO
CREATE TRIGGER t_InsertEmployeeManager ON dbo.DEPARTMENT INSTEAD OF INSERT, UPDATE
AS
BEGIN
	DECLARE @Dname	AS VARCHAR(15);
	DECLARE @Dnumber AS INT;
	DECLARE @Mgr_ssn AS CHAR(9);
	DECLARE @Mgr_start_date AS DATE;

	SELECT @Dname=inserted.Dname, @Dnumber=inserted.Dnumber, @Mgr_ssn=inserted.Mgr_ssn, @Mgr_start_date=inserted.Mgr_start_date FROM inserted;

	IF @Mgr_ssn IN (SELECT Mgr_ssn FROM dbo.DEPARTMENT AS DEP WHERE DEP.Mgr_ssn = @Mgr_ssn)
	BEGIN
		PRINT('Employee already manages one or more departements');
		RAISERROR('Insertion/update failed. Employees cant manage more than one department', 16, 1);
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT * FROM deleted)
		BEGIN
			PRINT('Updating')
			UPDATE dbo.DEPARTMENT SET Dname=@Dname, Dnumber=@Dnumber, Mgr_ssn=@Mgr_ssn, Mgr_start_date=@Mgr_start_date WHERE Dnumber=@Dnumber
		END
		ELSE
		BEGIN
			PRINT('Inserting')
			INSERT INTO dbo.DEPARTMENT SELECT * FROM inserted;
		END
	END
END
GO


-- d)
GO
CREATE TRIGGER t_EmployeeCapital ON dbo.EMPLOYEE AFTER INSERT, UPDATE
AS 
BEGIN
	DECLARE @Essn			AS CHAR(9);
	DECLARE @Esalary		AS DECIMAL(10,2);
	DECLARE @Dno			AS INT;
	DECLARE @Ssalary		AS DECIMAL(10,2);

	SELECT @Essn=inserted.Ssn, @Esalary=inserted.Salary, @Dno=inserted.Dno FROM inserted;
	SELECT @Ssalary=EMPLOYEE.Salary 
	FROM dbo.DEPARTMENT
	JOIN dbo.EMPLOYEE ON dbo.DEPARTMENT.Mgr_ssn=EMPLOYEE.Ssn
	WHERE @Dno=DEPARTMENT.Dnumber;
	

	IF @Esalary>@Ssalary 
	BEGIN
		UPDATE dbo.EMPLOYEE SET dbo.EMPLOYEE.Salary=@Ssalary-1
		WHERE dbo.EMPLOYEE.Ssn=@Essn;
	END
END
GO

-- e)
GO
CREATE FUNCTION f_EmployeeWorkProjects (@Employee_ssn CHAR(9)) RETURNS @Projects_table TABLE (Pname VARCHAR(15), Plocation VARCHAR(15))
AS
	BEGIN
		INSERT @Projects_table
		SELECT dbo.PROJECT.Pname, dbo.PROJECT.Plocation
		FROM dbo.PROJECT
		JOIN dbo.WORKS_ON ON dbo.WORKS_ON.Pno=dbo.PROJECT.Pnumber
		WHERE dbo.WORKS_ON.Essn=@Employee_ssn;
		RETURN;
	END;
GO

-- f)
GO
CREATE FUNCTION f_HigherCapitalEmployees (@Dno INT) RETURNS @Employees_table TABLE (Fname VARCHAR(15), Minit CHAR, Lname VARCHAR(15), Ssn INT)
AS
	BEGIN
		INSERT @Employees_table
		SELECT dbo.EMPLOYEE.Fname, dbo.EMPLOYEE.Minit, dbo.EMPLOYEE.Lname, dbo.EMPLOYEE.Ssn
		FROM dbo.EMPLOYEE JOIN (SELECT Dno, AVG(Salary) AS 'Department_average_salary'
			FROM dbo.EMPLOYEE
			GROUP BY Dno) AS Average_salary
		ON Average_salary.Dno=dbo.EMPLOYEE.Dno
		WHERE dbo.EMPLOYEE.Salary > Average_salary.Department_average_salary
		RETURN;
	END;
GO

-- g)
GO
CREATE FUNCTION f_DepartmentProjects (@Dno INT) RETURNS @DepartmentProjects_table TABLE (ProjectName VARCHAR(15), MensalBudget DECIMAL(10, 2), CumulativeBudget DECIMAL(10, 2))
AS
	BEGIN
		INSERT @DepartmentProjects_table
			SELECT dbo.PROJECT.Pname, SUM(dbo.EMPLOYEE.Salary) AS 'MensalBudget', SUM(dbo.EMPLOYEE.Salary*dbo.WORKS_ON.[Hours]/160) AS 'CumulativeBudget'
			FROM dbo.DEPARTMENT
			JOIN dbo.PROJECT ON dbo.DEPARTMENT.Dnumber=dbo.PROJECT.Dnum
			JOIN dbo.WORKS_ON ON dbo.PROJECT.Pnumber=dbo.WORKS_ON.Pno
			JOIN dbo.EMPLOYEE ON dbo.WORKS_ON.Essn=dbo.EMPLOYEE.Ssn
			GROUP BY dbo.PROJECT.Pname
		RETURN;
	END;
GO
*/
-- h)

CREATE TRIGGER DEP_DELETED ON dbo.Department
INSTEAD OF DELETE
AS
	DECLARE @deleted_dno AS INT
	SELECT @deleted_dno = Dnumber FROM deleted;
	-- create the table if it doesnt exist
	IF(NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_SCHEMA='myschema' AND TABLE_NAME='department_deleted'))
	BEGIN
	CREATE TABLE dbo.department_deleted(Dname varchar(30), Dnumber INT,
									     Mgr_Ssn INT, Mgr_Start_Date Date,
										 PRIMARY KEY(Dnumber),
										 FOREIGN KEY(Mgr_Ssn) REFERENCES dbo.Employee(Ssn));
	END

	DELETE FROM dbo.Project WHERE Dnum=@deleted_dno;
	UPDATE dbo.Employee SET Dno=NULL WHERE Dno=@deleted_dno;
	INSERT dbo.department_deleted SELECT * FROM deleted;
	DELETE FROM dbo.Department WHERE Dnumber=@deleted_dno;

GO

-- i)
/*

Stored Procedures 
	- não é necessário recompilar código sempre que o procedimento é executado
	- podem ter argumentos de entrada e retornar valores
	- podem alterar a bd com inserts, updates e deletes
	- suportam blocos de try... catch
	- são mais utilizados em casos em que é necessário alterar a bd

UDF's
	- retornam sempre um valor, mas este pode ser uma tabela
	- se for necessário retornar uma tabela, utiliza-se UDF's