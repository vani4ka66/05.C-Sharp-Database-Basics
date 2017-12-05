select e.EmployeeID as EmployeeID, e.FirstName,
case when year(p.StartDate) >= '2005' then NULL
else p.Name
end as ProjectName
from Employees e
 join EmployeesProjects ep
on ep.EmployeeID = e.EmployeeID
 join Projects p
on ep.ProjectID = p.ProjectID
where e.EmployeeID = 24
