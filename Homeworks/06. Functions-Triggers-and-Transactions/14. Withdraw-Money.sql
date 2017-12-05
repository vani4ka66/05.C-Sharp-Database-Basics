create procedure usp_WithdrawMoney (@AccountID int, @moneyAmount money)
 as
begin
update Accounts
	set Balance -= @moneyAmount
	where Id = @AccountID
end
