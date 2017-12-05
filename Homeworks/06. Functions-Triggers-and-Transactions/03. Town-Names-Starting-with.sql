create procedure usp_GetTownsStartingWith (@string nvarchar(50)) 
as
	select t.Name
	from Towns t
	where left(t.Name,len(@string)) = @string
