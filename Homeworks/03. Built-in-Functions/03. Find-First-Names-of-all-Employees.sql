select e.FirstName
from Employees e
where (e.DepartmentID = 3 or e.DepartmentID = 10) 
and (year( e.Hiredate) between '1995' and '2005')
