select p.PeakName, m.MountainRange as Mountain, c.CountryName, ct.ContinentName -???
from Peaks p
left  join Mountains m
on m.Id = p.MountainId
left join MountainsCountries mc
on mc.MountainId = m.Id
left join Countries c
on c.CountryCode = mc.CountryCode
left join Continents ct
on ct.ContinentCode = c.CountryCode
order by p.PeakName, c.Country

