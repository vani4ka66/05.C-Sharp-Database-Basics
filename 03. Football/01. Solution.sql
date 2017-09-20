Problem 1.	All Teams
select t.TeamName
 from Teams t
 order by t.TeamName
 
 Problem 2.	Biggest Countries by Population
 select top 50 c.CountryName, c.Population
 from Countries c
 order by c.Population desc


Problem 3.	Countries and Currency (Eurzone)
select c.CountryName, c.CountryCode,
(Case when c.CurrencyCode = 'EUR' then 'Inside' else 'Outside' end) as Eurozone
 from Countries c
order by c.CountryName


Problem 4.	Teams Holding Numbers
select t.TeamName as [Team Name], t.CountryCode as [Country Code]
 from Teams t
 where t.TeamName LIKE '%[0-9]%'
order by t.CountryCode


Problem 5.	International Matches
select 
c.CountryName as [Home Team],
x.CountryName as [Away Team],
i.MatchDate as [Match Date]
 from InternationalMatches i
 join Countries c
 on i.HomeCountryCode = c.CountryCode
 join Countries x
 on i.AwayCountryCode = x.CountryCode
 order by i.MatchDate desc


Problem 6.	*Teams with their League and League Country
select 
 TeamName AS [Team Name],
  LeagueName AS [League],
  (CASE WHEN l.CountryCode IS NULL THEN 'International' ELSE c.CountryName END) AS [League Country]
FROM Teams t
JOIN Leagues_Teams lt on t.Id = lt.TeamId
JOIN Leagues l on l.id = lt.LeagueId
LEFT JOIN Countries c on c.CountryCode = l.CountryCode
ORDER BY TeamName


Problem 7.	* Teams with more than One Match
SELECT 
  t.TeamName AS Team, 
  (SELECT COUNT(DISTINCT tm.Id) 
   FROM TeamMatches tm
   WHERE tm.HomeTeamId = t.Id OR tm.AwayTeamId = t.Id) AS [Matches Count]
FROM
  Teams t
WHERE
  (SELECT COUNT(DISTINCT tm.Id) 
   FROM TeamMatches tm
   WHERE tm.HomeTeamId = t.Id OR tm.AwayTeamId = t.Id) > 1
ORDER BY TeamName


Problem 8.	Number of Teams and Matches in Leagues - ???
SELECT
  l.LeagueName AS [League Name],
  COUNT(DISTINCT lt.TeamId) AS [Teams],
  COUNT(DISTINCT tm.Id) AS [Matches],
  ISNULL(AVG(tm.HomeGoals + tm.AwayGoals), 0) AS [Average Goals]
FROM Leagues l
LEFT JOIN Leagues_Teams lt ON l.Id = lt.LeagueId
LEFT JOIN TeamMatches tm ON tm.LeagueId = l.Id
GROUP BY l.LeagueName
ORDER BY Teams DESC, Matches DESC


Problem 9.	Total Goals per Team in all Matches
SELECT
  t.TeamName,
  ISNULL(SUM(tm1.HomeGoals), 0) + ISNULL(SUM(tm2.AwayGoals), 0) AS [Total Goals]
FROM Teams t
LEFT JOIN TeamMatches tm1 on tm1.HomeTeamId = t.Id
LEFT JOIN TeamMatches tm2 on tm2.AwayTeamId = t.Id
GROUP BY t.TeamName
ORDER BY [Total Goals] DESC, TeamName


Problem 10.	Pairs of Matches on the Same Day
SELECT tm1.MatchDate AS [First Date], tm2.MatchDate AS [Second Date]
FROM TeamMatches tm1, TeamMatches tm2
WHERE
  tm2.MatchDate > tm1.MatchDate AND
  DATEDIFF(day, tm1.MatchDate, tm2.MatchDate) < 1
ORDER BY tm1.MatchDate DESC, tm2.MatchDate DESC


Problem 11.	Mix of Team Names
SELECT LOWER(SUBSTRING(t1.teamname, 1, LEN(t1.TeamName) - 1) +  REVERSE(t2.TeamName)) AS Mix
FROM Teams t1, Teams t2
WHERE RIGHT(t1.TeamName, 1) = RIGHT(t2.TeamName, 1)
ORDER BY Mix


Problem 12.	Countries with International and Team Matches
SELECT
  c.CountryName AS [Country Name],
  COUNT(DISTINCT im1.Id) + COUNT(DISTINCT im2.Id) AS [International Matches],
  COUNT(DISTINCT tm.Id) AS [Team Matches]
FROM Countries c
LEFT JOIN InternationalMatches im1 on im1.HomeCountryCode = c.CountryCode
LEFT JOIN InternationalMatches im2 on im2.AwayCountryCode = c.CountryCode
LEFT JOIN Leagues l on l.CountryCode = c.CountryCode
LEFT JOIN TeamMatches tm on l.Id = tm.LeagueId
GROUP BY c.CountryName
HAVING (COUNT(DISTINCT im1.Id) + COUNT(DISTINCT im2.Id)) > 0 OR
	(COUNT(DISTINCT tm.Id) > 0)
ORDER BY [International Matches] DESC, [Team Matches] DESC, [Country Name]


Problem 13.	Non-international Matches
IF OBJECT_ID('FriendlyMatches') IS NOT NULL
  DROP TABLE FriendlyMatches
CREATE TABLE FriendlyMatches(
	Id int IDENTITY NOT NULL,
	HomeTeamId int NOT NULL,
	AwayTeamId int NOT NULL,
	MatchDate datetime NULL
 CONSTRAINT PK_FriendlyMatches PRIMARY KEY (Id))
GO

ALTER TABLE FriendlyMatches WITH CHECK ADD CONSTRAINT
FK_FriendlyMatches_Teams_HomeTeam FOREIGN KEY(HomeTeamId)
REFERENCES Teams (Id)
GO

ALTER TABLE FriendlyMatches WITH CHECK ADD CONSTRAINT
FK_FriendlyMatches_Teams_AwayTeam FOREIGN KEY(AwayTeamId)
REFERENCES Teams (Id)
GO

INSERT INTO Teams(TeamName) VALUES
 ('US All Stars'),
 ('Formula 1 Drivers'),
 ('Actors'),
 ('FIFA Legends'),
 ('UEFA Legends'),
 ('Svetlio & The Legends')
GO

INSERT INTO FriendlyMatches(
  HomeTeamId, AwayTeamId, MatchDate) VALUES
  
((SELECT Id FROM Teams WHERE TeamName='US All Stars'), 
 (SELECT Id FROM Teams WHERE TeamName='Liverpool'),
 '30-Jun-2015 17:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Formula 1 Drivers'), 
 (SELECT Id FROM Teams WHERE TeamName='Porto'),
 '12-May-2015 10:00'),
 
((SELECT Id FROM Teams WHERE TeamName='Actors'), 
 (SELECT Id FROM Teams WHERE TeamName='Manchester United'),
 '30-Jan-2015 17:00'),

((SELECT Id FROM Teams WHERE TeamName='FIFA Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='UEFA Legends'),
 '23-Dec-2015 18:00'),

((SELECT Id FROM Teams WHERE TeamName='Svetlio & The Legends'), 
 (SELECT Id FROM Teams WHERE TeamName='Ludogorets'),
 '22-Jun-2015 21:00')

GO

SELECT 
  t1.TeamName AS [Home Team],
  t2.TeamName AS [Away Team],
  fm.MatchDate AS [Match Date]
FROM FriendlyMatches fm
JOIN Teams t1 on t1.Id = fm.HomeTeamId
JOIN Teams t2 on t2.Id = fm.AwayTeamId
UNION
SELECT 
  t1.TeamName AS [Home Team],
  t2.TeamName AS [Away Team],
  tm.MatchDate AS [Match Date]
FROM TeamMatches tm
JOIN Teams t1 on t1.Id = tm.HomeTeamId
JOIN Teams t2 on t2.Id = tm.AwayTeamId
ORDER BY [Match Date] DESC


Problem 14.	Seasonal Matches
ALTER TABLE Leagues
ADD IsSeasonal BIT NOT NULL
DEFAULT 0

INSERT INTO TeamMatches(
  HomeTeamId, AwayTeamId, HomeGoals, AwayGoals, MatchDate, LeagueId) VALUES
  
((SELECT Id FROM Teams WHERE TeamName='Empoli'), 
 (SELECT Id FROM Teams WHERE TeamName='Parma'), 
 2, 2, '19-Apr-2015 16:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Italian Serie A')),

((SELECT Id FROM Teams WHERE TeamName='Internazionale'), 
 (SELECT Id FROM Teams WHERE TeamName='AC Milan'), 
 0, 0, '19-Apr-2015 21:45', 
 (SELECT Id FROM Leagues WHERE LeagueName='Italian Serie A'))

GO

UPDATE Leagues
SET IsSeasonal = 1
WHERE Id IN (
	SELECT l.Id
	FROM Leagues l
	  JOIN TeamMatches tm ON tm.LeagueId = l.Id
	GROUP BY l.Id
	HAVING COUNT(tm.Id) > 0
)

SELECT 
	t1.TeamName AS [Home Team],
	tm.HomeGoals AS [Home Goals],
	t2.TeamName AS [Away Team],
	tm.AwayGoals AS [Away Goals],
	l.LeagueName AS [League Name]
FROM TeamMatches tm
JOIN Leagues l ON l.Id = tm.LeagueId
JOIN Teams t1 ON tm.HomeTeamId = t1.Id
JOIN Teams t2 ON tm.AwayTeamId = t2.Id
WHERE tm.MatchDate > '10-Apr-2015'
ORDER BY [League Name], [Home Goals] DESC, [Away Goals] DESC



Problem 15.	Stored Function: Bulgarian Teams with Matches JSON
IF OBJECT_ID('fn_TeamsJSON') IS NOT NULL
  DROP FUNCTION fn_TeamsJSON
GO

CREATE FUNCTION fn_TeamsJSON()
	RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @json NVARCHAR(MAX) = '{"teams":['

	DECLARE teamsCursor CURSOR FOR
	SELECT Id, TeamName FROM Teams
	WHERE CountryCode = 'BG'
	ORDER BY TeamName

	OPEN teamsCursor
	DECLARE @TeamName NVARCHAR(MAX)
	DECLARE @TeamId INT
	FETCH NEXT FROM teamsCursor INTO @TeamId, @TeamName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @json = @json + '{"name":"' + @TeamName + '","matches":['

		DECLARE matchesCursor CURSOR FOR
		SELECT t1.TeamName, t2.TeamName, HomeGoals, AwayGoals, MatchDate FROM TeamMatches
		LEFT JOIN Teams t1 ON t1.Id = HomeTeamId
		LEFT JOIN Teams t2 ON t2.Id = AwayTeamId
		WHERE HomeTeamId = @TeamId OR AwayTeamId = @TeamId
		ORDER BY TeamMatches.MatchDate DESC

		OPEN matchesCursor
		DECLARE @HomeTeamName NVARCHAR(MAX)
		DECLARE @AwayTeamName NVARCHAR(MAX)
		DECLARE @HomeGoals INT
		DECLARE @AwayGoals INT
		DECLARE @MatchDate DATE
		FETCH NEXT FROM matchesCursor INTO @HomeTeamName, @AwayTeamName, @HomeGoals, @AwayGoals, @MatchDate
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @json = @json + '{"' + @HomeTeamName + '":' + CONVERT(NVARCHAR(MAX), @HomeGoals) + ',"' + 
						@AwayTeamName + '":' + CONVERT(NVARCHAR(MAX), @AwayGoals) + 
						',"date":' + CONVERT(NVARCHAR(MAX), @MatchDate, 103) + '}'
			FETCH NEXT FROM matchesCursor INTO @HomeTeamName, @AwayTeamName, @HomeGoals, @AwayGoals, @MatchDate
			IF @@FETCH_STATUS = 0
				SET @json = @json + ','
		END
		CLOSE matchesCursor
		DEALLOCATE matchesCursor	
		SET @json = @json + ']}'

		FETCH NEXT FROM teamsCursor INTO @TeamId, @TeamName
		IF @@FETCH_STATUS = 0
			SET @json = @json + ','
	END
	CLOSE teamsCursor
	DEALLOCATE teamsCursor

	SET @json = @json + ']}'
	RETURN @json
END
GO

SELECT dbo.fn_TeamsJSON()

