SELECT 
  r.RiverName AS [River], 
  (SELECT COUNT(DISTINCT CountryCode) 
   FROM CountriesRivers 
   WHERE RiverId = r.Id) AS [Countries Count]
FROM
  Rivers r
WHERE
  (SELECT COUNT(DISTINCT CountryCode) 
   FROM CountriesRivers 
   WHERE RiverId = r.Id) >= 3
ORDER BY RiverName
