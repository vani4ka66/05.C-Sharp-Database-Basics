select a.Title, c.Name as CategoryName, t.Name as TownName, ad.[Status]
from Ads a
left join Towns t
on t.Id = a.TownId
left join Categories c
on c.Id = a.CategoryId
left join AdStatuses ad
on ad.Id = a.StatusId
order by a.Id
