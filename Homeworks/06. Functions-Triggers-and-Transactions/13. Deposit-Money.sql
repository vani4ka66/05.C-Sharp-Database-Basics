create procedure usp_DepositMoney (@AccountID int, @moneyAmount money)
 as
begin
update Accounts
	set Balance += @moneyAmount
	where Id = @AccountID
end
