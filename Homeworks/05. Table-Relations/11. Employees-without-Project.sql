select top 3 e.EmployeeId, e.FirstName
from Employees e
left join EmployeesProjects ep
on ep.EmployeeID = e.EmployeeID
left join Projects p
on ep.ProjectID = p.ProjectID
group by e.EmployeeId, e.FirstName
having count(ep.ProjectID) = 0
order by e.EmployeeId
