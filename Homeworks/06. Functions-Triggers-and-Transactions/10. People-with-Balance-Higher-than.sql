create procedure usp_GetHoldersWithBalanceHigherThan  (@number money ) 
as
begin
	select a.FirstName as [First Name],  a.LastName as [Last Name]
	from AccountHolders a
	left join Accounts ac
	on ac.AccountHolderId = a.Id
	--where sum(ac.Balance) > @number
	group by a.FirstName, a.LastName
	having sum(ac.Balance) > @number

end
