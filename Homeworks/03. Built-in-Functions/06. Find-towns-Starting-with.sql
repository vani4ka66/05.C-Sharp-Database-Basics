select  t.TownID,t.Name
from Towns t
where t.Name like 'M%' 
or t.Name like 'K%' 
or t.Name like 'B%' 
or t.Name like 'E%'
order by t.Name
