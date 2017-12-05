create procedure usp_GetEmployeesSalaryAboveNumber (@number float) 
as
	select e.FirstName, e.LastName
	from Employees e
	where e.Salary >= @number
