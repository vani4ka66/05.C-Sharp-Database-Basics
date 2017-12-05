select top 5 e.EmployeeId, e.FirstName, e.Salary, d.Name as DepartmentName
from Employees e
join Departments d 
on d.DepartmentID = e.DepartmentID
where e.Salary > 15000
order by e.DepartmentID
