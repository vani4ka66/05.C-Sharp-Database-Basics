create function ufn_CalculateFutureValue (@sum decimal(19,8), @yearlyInterestRate decimal(19,8), @numberOfYears int)
returns decimal(19,4)
as 
begin
	declare @FV decimal(19,4);
	set @FV = @sum*(power((1+@yearlyInterestRate),@numberOfYears));
	return @FV;
end
