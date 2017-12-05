select s.Status, count([Status]) as [Count]
from Ads a
join AdStatuses s
on a.StatusId = s.Id
group by Status
order by s.Status
