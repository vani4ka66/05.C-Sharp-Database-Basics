create view V_EmployeesHiredAfter2000 as 
select  e.FirstName, e.LastName
from Employees e
where year(e.HireDate) > 2000
