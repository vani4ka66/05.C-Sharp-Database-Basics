select top 5 c.CountryName, r.RiverName
 from Rivers r
 full outer join CountriesRivers cr
 on cr.RiverId = r.Id
 full outer  join Countries c
 on cr.CountryCode = c.CountryCode
 where c.ContinentCode = 'AF'
 order by c.CountryName
