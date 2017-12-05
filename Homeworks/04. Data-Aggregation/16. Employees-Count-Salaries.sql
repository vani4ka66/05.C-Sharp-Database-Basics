select count(e.Salary) as [Count]
from Employees e
where e.ManagerId is null
