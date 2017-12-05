select mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation
 from Peaks p
 join Mountains m
 on m.Id = p.MountainId
 join MountainsCountries mc
 on mc.MountainId = m.Id
 where p.Elevation > 2835 and mc.CountryCode = 'BG'
 order by p.Elevation desc
