select * into EmployeeTemp
from  Employees e
where e.Salary > 30000


delete from EmployeeTemp 
where ManagerID = 42



update EmployeeTemp
set Salary += 5000
where DepartmentID = 1



select et.DepartmentID, avg(et.Salary) as [AverageSalary]
from EmployeeTemp et
group by et.DepartmentID
