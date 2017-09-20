select a.Id, a.Title, a.Date, s.Status
from Ads a
join AdStatuses s
on a.StatusId = s.Id
where MONTH( a.Date) = (select Month(min(Date)) from Ads) 
and  year( a.Date) = (select year(min(Date)) from Ads) 
and s.Status != 'Published'
--AND Status <> 'Published'
order by a.Id
