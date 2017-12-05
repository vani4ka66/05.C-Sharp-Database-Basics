select  c.CountryName, c.IsoCode
from Countries c
where c.CountryName like '%a%A%a%'
order by c.IsoCode
