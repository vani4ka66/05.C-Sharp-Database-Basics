CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
     DECLARE @lengthOfWord INT = LEN(@word);
     DECLARE @comprisedCharsCount INT = 0;
     DECLARE @currentIndex INT= 1;
     DECLARE @result BIT = 0;
 
     WHILE @currentIndex <= @lengthOfWord
     BEGIN
        DECLARE @currentChar NVARCHAR(MAX) = SUBSTRING(@word, @currentIndex, 1);
 
        IF(CHARINDEX(@currentChar, @setOfLetters) > 0)
        BEGIN
            SET @comprisedCharsCount += 1;
        END
        SET @currentIndex += 1
     END
 
     IF(@comprisedCharsCount = @lengthOfWord)
     BEGIN
        SET @result = 1;
     END
     
     RETURN @result;
END

