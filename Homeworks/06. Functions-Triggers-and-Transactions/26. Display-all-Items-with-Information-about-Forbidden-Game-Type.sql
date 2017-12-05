select i.Name as Item, Price, MinLevel, gt.Name as [Forbidden Game Type] from Items i
left join GameTypeForbiddenItems gtf on gtf.ItemId = i.Id
left join GameTypes gt on gt.Id = gtf.GameTypeId
order by [Forbidden Game Type] desc, Item 
