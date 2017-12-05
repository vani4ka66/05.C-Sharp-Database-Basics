create procedure usp_GetHoldersFullName 
   as
	select concat(a.FirstName,' ',  a.LastName) as [Full Name]
	from AccountHolders a
