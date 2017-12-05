SELECT c.CountryCode,
  COUNT(mc.MountainId)
FROM Countries c
JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
WHERE c.CountryName IN ('United States', 'Russia', 'Bulgaria')
GROUP BY c.CountryCode
