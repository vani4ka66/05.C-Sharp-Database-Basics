create procedure usp_GetEmployeesFromTown (@townName nvarchar(50)) 
as
	select e.FirstName, e.LastName
	from Employees e
	join Addresses a
	on e.AddressID = a.AddressID
	join Towns t
	on t.TownID = a.TownID
	where t.Name = @townName
