  select count(c.CountryCode) as CountryCode
   FROM Countries c
  left join MountainsCountries mc
  on mc.CountryCode = c.CountryCode
  left join Mountains m
  on m.Id = mc.MountainId
  where m.MountainRange is null
