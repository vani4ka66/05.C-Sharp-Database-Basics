select e.DepartmentID,
(select max(emp.Salary) from Employees emp where e.DepartmentId = emp.DepartmentID) as MaxSalary
from Employees e
group by e.DepartmentID
having (select max(emp.Salary) from Employees emp where e.DepartmentId = emp.DepartmentID) < 30000 or
(select max(emp.Salary) from Employees emp where e.DepartmentId = emp.DepartmentID) > 70000
