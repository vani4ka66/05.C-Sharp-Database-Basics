select 
count(*) as AdsCount, isnull(t.Name, '(no town)') as Town
from Ads a
left join Towns t
on t.Id = a.TownId
group by t.Name
having count(*) in (2, 3)
order by t.Name
