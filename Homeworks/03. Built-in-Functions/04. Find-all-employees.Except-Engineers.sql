select e.FirstName, e.LastName
from Employees e
where e.JobTitle not like '%engineer%' 
