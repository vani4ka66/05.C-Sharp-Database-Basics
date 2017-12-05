select u.Username, g.Name as Game, COUNT(i.Id) as [Items Count], SUM(i.Price) as [Items Price] 
from Users u
join UsersGames ug on ug.UserId = u.Id
join Games g on ug.GameId = g.Id
join Characters c on ug.CharacterId = c.Id
join UserGameItems ugi on ugi.UserGameId = ug.Id
join Items i on i.Id = ugi.ItemId
group by u.Username, g.Name
having COUNT(i.Id) >= 10
order by [Items Count] desc, [Items Price] desc, Username
