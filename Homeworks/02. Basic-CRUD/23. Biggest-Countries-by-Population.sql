select top 30 c.CountryName, c.Population
from Countries c
where c.ContinentCode = 'EU'
order by c.Population desc
