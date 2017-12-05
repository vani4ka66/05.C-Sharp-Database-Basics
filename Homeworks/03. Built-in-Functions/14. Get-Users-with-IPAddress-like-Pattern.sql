select u.Username, u.IpAddress
from Users u
where u.IpAddress like '___.1%.%.___'
order by u.Username
