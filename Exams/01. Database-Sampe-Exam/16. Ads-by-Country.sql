16.1
create table Countries(
  Id int not null Identity Primary key,
  Name nvarchar(50) not null
  )
  Go

ALTER TABLE Towns 
   ADD CountryId int
   GO

ALTER TABLE Towns 
   ADD CONSTRAINT FK_Towns_Countries  FOREIGN KEY(CountryId) REFERENCES Countries(Id)
   GO
   
16.3
  UPDATE Ads
  SET TownId = (SELECT Id FROM Towns WHERE Name='Paris')
  WHERE DATENAME(WEEKDAY, Date) = 'Friday'
  
16.4
   UPDATE Ads
   SET TownId = (SELECT Id FROM Towns WHERE Name='Hamburg')
   WHERE DATENAME(WEEKDAY, Date) = 'Thusday'

16.5
  DELETE FROM Ads
  FROM Ads a
  JOIN AspNetUsers u 
  ON a.OwnerId = u.Id
  JOIN AspNetUserRoles ur 
  ON u.Id = ur.UserId
  JOIN AspNetRoles r 
  ON r.Id = ur.RoleId
  WHERE r.Name = 'Partner'

16.6
INSERT INTO Ads(Title, Text, Date, OwnerId, StatusId)
  VALUES ('Free Book', 'Free C# Book', GETDATE(), 
  (SELECT Id FROM AspNetUsers WHERE UserName='nakov'), 
  (SELECT Id FROM AdStatuses WHERE Status='Waiting Approval'))
  
16.7
SELECT
  t.Name as Town,
  c.Name as Country,
  COUNT(a.Id) as AdsCount
FROM
  Ads a
  FULL OUTER JOIN Towns t
  ON a.TownId = t.Id
  FULL OUTER JOIN Countries c 
  ON t.CountryId = c.Id
GROUP BY t.Name, c.Name
ORDER BY t.Name, c.Name


   
