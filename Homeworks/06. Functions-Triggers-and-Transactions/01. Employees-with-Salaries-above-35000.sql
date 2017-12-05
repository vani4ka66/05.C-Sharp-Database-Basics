create procedure usp_GetEmployeesSalaryAbove35000 
as
	select e.FirstName, e.LastName
	from Employees e
	where e.Salary > 35000
