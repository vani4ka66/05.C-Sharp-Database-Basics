select e.EmployeeId, e.FirstName, e.ManagerID, emp.FirstName
from Employees e
 join Employees emp 
on e.ManagerID  = emp.EmployeeID
where e.ManagerID  in (3,7)
order by e.EmployeeId
