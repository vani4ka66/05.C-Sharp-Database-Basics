select top 5 e.EmployeeId, e.JobTitle, e.AddressID, a.AddressText
from Employees e
join Addresses a
on a.AddressID = e.AddressID
order by a.AddressID
