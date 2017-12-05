create proc usp_CalculateFutureValueForAccount
as
select a.AccountID as [Account Id],
 c.FirstName as [First Name], 
 c.LastName as [Last Name],
  a.Balance as [Current Balance], 
a.Balance * l.Interest* 5 as [Balance in 5 years]
 from Accounts a
join Customers c
on c.CustomerID = a.CustomerID
join Loans l
on l.CustomerID = a.CustomerID
