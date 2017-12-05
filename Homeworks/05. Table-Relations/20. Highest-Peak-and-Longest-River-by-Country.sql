select  top 5 c.CountryName, 
max(p.Elevation) as HighestPeakElevation,
max(r.Length) as LongestRiverLength
 from Countries c
 full outer join MountainsCountries mc
 on mc.CountryCode = c.CountryCode
 full outer join Peaks p
 on p.MountainId = mc.MountainId
 full outer join CountriesRivers cr
 on cr.CountryCode = c.CountryCode
 full outer join Rivers r
 on cr.RiverId = r.Id
 group by c.CountryName
 order by max(p.Elevation) desc, max(r.Length) desc, c.CountryName
