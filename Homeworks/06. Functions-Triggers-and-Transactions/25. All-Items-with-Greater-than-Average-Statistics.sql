select 
	i.Name, 
	i.Price, 
	i.MinLevel,
	s.Strength,
	s.Defence,
	s.Speed,
	s.Luck,
	s.Mind
from Items i
join [Statistics] s on s.Id = i.StatisticId
where s.Mind > (
	select AVG(s.Mind) from Items i 
	join [Statistics] s on s.Id = i.StatisticId
) and s.Luck > (
	select AVG(s.Luck) from Items i 
	join [Statistics] s on s.Id = i.StatisticId
) and s.Speed > (
	select AVG(s.Speed) from Items i 
	join [Statistics] s on s.Id = i.StatisticId
) 
order by i.Name
