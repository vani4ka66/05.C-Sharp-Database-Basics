select top 5 e.EmployeeId, e.FirstName, p.Name
from Employees e
 join EmployeesProjects ep
on ep.EmployeeID = e.EmployeeID
 join Projects p
on ep.ProjectID = p.ProjectID
where (p.StartDate) > '20020813' and p.EndDate is null
order by e.EmployeeId asc

