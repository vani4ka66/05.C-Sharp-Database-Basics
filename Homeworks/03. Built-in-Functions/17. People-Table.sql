select p.Name,
datediff(year, GETDATE(), p.BirthDate) as [Age in Years],
datediff(month, GETDATE(), p.BirthDate) as [Age in Months],
datediff(day, GETDATE(), p.BirthDate) as [Age in Days],
datediff(minute, GETDATE(), p.BirthDate) as [Age in Minutes]
from People p
