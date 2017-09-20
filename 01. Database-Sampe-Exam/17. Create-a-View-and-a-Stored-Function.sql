17.1
CREATE VIEW V_AllAds
AS
SELECT 
  a.Id,
  a.Title, 
  u.UserName AS Author,
  a.Date,
  t.Name AS Town, 
  c.Name AS Category,
  s.Status AS Status
FROM
  Ads a
  LEFT JOIN Towns t on a.TownId = t.Id
  LEFT JOIN Categories c on a.CategoryId = c.Id
  LEFT JOIN AdStatuses s on a.StatusId = s.Id
  LEFT JOIN AspNetUsers u on u.Id = a.OwnerId
  
  
17.2
IF (object_id(N'fn_ListUsersAds') IS NOT NULL) 
DROP FUNCTION fn_ListUsersAds
GO

CREATE FUNCTION fn_ListUsersAds()
	RETURNS @tbl_UsersAds TABLE(
		UserName NVARCHAR(MAX),
		AdDates NVARCHAR(MAX)
	)
AS
BEGIN
	DECLARE UsersCursor CURSOR FOR
		SELECT UserName FROM AspNetUsers
		ORDER BY UserName DESC;
	OPEN UsersCursor;
	DECLARE @username NVARCHAR(MAX);
	FETCH NEXT FROM UsersCursor INTO @username;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @ads NVARCHAR(MAX) = NULL;
		SELECT
			@ads = CASE
				WHEN @ads IS NULL THEN CONVERT(NVARCHAR(MAX), Date, 112)
				ELSE @ads + '; ' + CONVERT(NVARCHAR(MAX), Date, 112)
			END
		FROM AllAds
		WHERE Author = @username
		ORDER BY Date;

		INSERT INTO @tbl_UsersAds
		VALUES(@username, @ads)
		
		FETCH NEXT FROM UsersCursor INTO @username;
	END;
	CLOSE UsersCursor;
	DEALLOCATE UsersCursor;
	RETURN;
END
GO

SELECT * FROM fn_ListUsersAds()


