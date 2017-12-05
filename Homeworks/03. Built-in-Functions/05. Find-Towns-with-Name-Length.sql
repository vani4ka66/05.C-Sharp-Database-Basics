select t.Name
from Towns t
where LEN(t.Name) = 5 or len(t.Name) = 6
order by t.Name
