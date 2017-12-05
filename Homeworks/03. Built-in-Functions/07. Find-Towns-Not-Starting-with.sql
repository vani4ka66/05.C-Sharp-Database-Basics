select t.TownId, t.Name
from Towns t
where t.Name like '[^RDB]%' --or t.Name like '[^D]%' or t.Name like '[^B]%'
order by t.Name
