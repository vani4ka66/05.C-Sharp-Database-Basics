select e.DepartmentID,
min(e.salary)
from Employees e
where e.DepartmentId in (2, 5, 7) and
e.HireDate > '20000101'
group by e.DepartmentID
