select t.Name as [Town Name], Status, count([Status]) as [Count]
from Ads a
join AdStatuses s
on a.StatusId = s.Id
join Towns t
on t.Id = a.TownId
group by t.Name, Status
order by t.Name, Status
