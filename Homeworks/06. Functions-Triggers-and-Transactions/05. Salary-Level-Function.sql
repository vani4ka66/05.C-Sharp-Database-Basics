CREATE FUNCTION ufn_GetSalaryLevel(@salary money)
RETURNS nvarchar(10)
AS
BEGIN
     DECLARE @result nvarchar(10);
 
     BEGIN
 
        IF(@salary < 30000)
        BEGIN
           set  @result = 'Low';
        END
		IF(@salary >= 30000 and @salary <=50000)
        BEGIN
            set @result = 'Average';
        END
		IF(@salary> 50000)		
		BEGIN
		     set @result = 'High';
		END
		
       
     END

     RETURN @result;
END

