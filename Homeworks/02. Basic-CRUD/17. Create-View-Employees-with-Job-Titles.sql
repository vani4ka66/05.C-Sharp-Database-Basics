create view V_EmployeeNameJobTitle  as 
select 
case when e.MiddleName is not null then (e.FirstName + ' ' + e.MiddleName + ' ' + e.LastName)
else (e.FirstName + '  ' + e.LastName)
end as [Full Name],
e.JobTitle as [Job Title]
from Employees e
