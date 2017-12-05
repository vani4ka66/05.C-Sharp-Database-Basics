Problem 1: Album’s Name and Description
select a.Name,
 ISNULL(a.Description, 'No description') as Description
from Albums a
order by a.Name

Problem 2: Photographs and Albums
select p.Title, a.Name
from Photographs p
join AlbumsPhotographs ap
on p.Id = ap.PhotographId
join Albums a
on a.Id = ap.AlbumId
order by a.Name, p.Title desc

Problem 3: Photographs with Category and Author
select p.Title, p.Link, p.Description, c.Name as CategoryName, u.FullName as Author
from Photographs p
join Categories c 
on p.CategoryId = c.Id
join Users u
on p.UserId = u.Id
where p.Description is not null
order by p.Title


Problem 4: Users Born in January
select u.Username, u.FullName, u.BirthDate,
 ISNULL(p.Title, 'No photos') as Photo
from Photographs p
right join Users u
on p.UserId = u.Id
where month(u.BirthDate) = 1
order by u.FullName


Problem 5: Photographs with Equipment
select p.Title, c.Model as CameraModel, l.Model as LensModel
from Photographs p
join Equipments e
on e.Id = p.EquipmentId
join Cameras c
on c.Id = e.CameraId
join Lenses l
on l.Id = e.LensId
order by p.Title



Problem 6: *Most Expensive Photos
--SELECT
  p.Title,
  c.Name as [Category Name],
  cm.Model,
  m.Name [Manufacturer Name],
  cm.Megapixels,
  cm.Price
FROM
  Photographs AS p
  JOIN Categories AS c ON p.CategoryId = c.Id
  JOIN Equipments AS e ON p.EquipmentId = e.Id
  JOIN Cameras AS cm ON e.CameraId = cm.Id
  JOIN Manufacturers AS m ON cm.ManufacturerId = m.Id
WHERE
  cm.Price = (SELECT
                MAX(cm1.Price)
			  FROM
			    Cameras AS cm1
				JOIN Equipments AS e1 ON cm1.Id = e1.CameraId
				JOIN Photographs AS p1 ON e1.Id = p1.EquipmentId
			  WHERE
			    p1.CategoryId = p.CategoryId)
ORDER BY 
  cm.Price DESC,
  p.Title ASC



Problem 7: Price Larger Than Average
select m.Name,
c.Model as Model, c.Price
from Cameras c
join Manufacturers m
on c.ManufacturerId = m.Id
where c.Price >  (select avg(c1.Price) from Cameras c1 where c1.Price is not null ) 
order by c.Price desc, c.Model


Problem 8: Total Price of Lenses
select m.Name,  !!!
sum(l.Price) as [Total Price]
from Lenses l
join Manufacturers m
on l.ManufacturerId = m.Id
group by m.Name
order by m.Name


SELECT DISTINCT  !!!
  m.Name,
  (SELECT SUM(l1.Price) FROM Lenses AS l1
	 JOIN Manufacturers AS m1 ON l1.ManufacturerId = m1.Id
	WHERE 
	  m1.Id = m.Id AND
	  l1.Price IS NOT NULL) AS [Total Price]
FROM
  Manufacturers AS m
  JOIN Lenses AS l ON m.Id = l.ManufacturerId
ORDER BY
  m.Name ASC



Problem 9: Users with Old Cameras
select u.FullName,
m.Name as Manufacturer,
c.Model as [Camera Model],
c.Megapixels
from Manufacturers m
join Cameras c
on c.ManufacturerId = m.Id
join Equipments e
on e.CameraId = c.Id
join Users u
on u.EquipmentId = e.Id
where (c.Year) < 2015
order by u.FullName


Problem 10: Lenses per Type
select l.Type, count(l.Type) as Count
from Lenses l
group by l.Type
order by count(l.Type) desc, l.Type


Problem 11: Sort Users
select u.UserName, u.FullName
from Users u
order by len(u.Username + u.FullName), u.BirthDate desc


Problem 12: Manufacturers without Products
SELECT 
  m.Name
FROM
  Manufacturers AS m
WHERE
  m.Id NOT IN (SELECT l.ManufacturerId FROM Lenses AS l) AND
  m.Id NOT IN (SELECT c.ManufacturerId FROM Cameras AS c)
ORDER BY
  m.Name ASC
  
  
Problem 13: Cameras rise
UPDATE 
	c
SET 
	c.Price = 
		c.Price + 
		(
		    (SELECT AVG(Price) FROM Cameras WHERE ManufacturerId = c.ManufacturerId) 
			* (
		    (SELECT LEN(Name)/100.00 FROM Manufacturers WHERE Id = c.ManufacturerId)
	                 )
		)
FROM Cameras c


SELECT rs.Model,rs.Price,rs.ManufacturerId  !!!
FROM (
    SELECT Model,Price,ManufacturerId, Rank() 
        over (Partition BY ManufacturerId
            ORDER BY Price DESC ) AS Rank
    FROM Cameras
    ) rs WHERE Rank <= 3 AND Price IS NOT NULL



Problem 14: Most cameras for given cash
DECLARE @T TABLE(Id Int, ManufacturerId int, Model nvarchar(max), Year int, Price money, Megapixels int)
DECLARE @Money money = 54187
DECLARE CUR CURSOR FOR SELECT Id, ManufacturerId, Model, Year, Price, Megapixels FROM Cameras  WHERE Price IS NOT NULL ORDER BY Price ASC, Id DESC
OPEN CUR

DECLARE @Id int
DECLARE @ManId int
DECLARE @Model nvarchar(max)
DECLARE @Year int
DECLARE @Price money
DECLARE @Megapixels int

FETCH NEXT FROM CUR INTO @Id, @ManId, @Model, @Year, @Price, @Megapixels


WHILE (@Money >= 0 AND @@FETCH_STATUS = 0)
BEGIN
	IF (@Price > @Money)
		BREAK

	SET @Money = @Money - @Price

	INSERT INTO @T VALUES (@Id, @ManId, @Model, @Year, @Price, @Megapixels)
	FETCH NEXT FROM CUR INTO @Id, @ManId, @Model, @Year, @Price, @Megapixels
END

CLOSE CUR
DEALLOCATE CUR

SELECT * FROM @T ORDER BY Year DESC, ManufacturerId DESC, Id ASC


Problem 15: Stored procedure for creating equipment
CREATE PROCEDURE dbo.usp_CreateEquipment @modelName VARCHAR(max)
AS BEGIN
    DECLARE CamerasCur CURSOR FOR SELECT Id, ManufacturerId, Model, Year, Price, Megapixels FROM Cameras WHERE Model = @modelName
    OPEN CamerasCur

	DECLARE @Id int
	DECLARE @ManId int
	DECLARE @Model nvarchar(max)
	DECLARE @Year int
	DECLARE @Price money
	DECLARE @Megapixels int

	DECLARE @MaxManId INT = 0;
	DECLARE ManCursor CURSOR FOR SELECT MAX(Id) FROM Manufacturers
	OPEN ManCursor
	FETCH NEXT FROM ManCursor INTO @MaxManId
	CLOSE ManCursor
	DEALLOCATE ManCursor

	FETCH NEXT FROM CamerasCur INTO @Id, @ManId, @Model, @Year, @Price, @Megapixels

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @CurrentManId INT = @ManId
		WHILE (@CurrentManId <= @MaxManId)
		BEGIN
			DECLARE LensesCurCount CURSOR FOR SELECT COUNT(*) FROM Lenses WHERE ManufacturerId = @CurrentManId
			OPEN LensesCurCount
			DECLARE @CNT int = 0
			FETCH NEXT FROM LensesCurCount INTO @CNT
			IF (@CNT <= 0)
			BEGIN
				SET @CurrentManId = @CurrentManId + 1
				CLOSE LensesCurCount
				DEALLOCATE LensesCurCount
				CONTINUE
			END
			CLOSE LensesCurCount
			DEALLOCATE LensesCurCount

			DECLARE LensesCur CURSOR FOR SELECT Id FROM Lenses WHERE ManufacturerId = @CurrentManId
			OPEN LensesCur
			DECLARE @LenseId int = 0
			FETCH NEXT FROM LensesCur INTO @LenseId

			DECLARE @ToExit BIT = 0;
			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				DECLARE @EquipExists int = 0;
				DECLARE EquipExistsCur CURSOR FOR SELECT COUNT(*) FROM Equipments WHERE CameraId = @Id AND LensId = @LenseId
				OPEN EquipExistsCur
				FETCH NEXT FROM EquipExistsCur INTO @EquipExists
				IF (@EquipExists > 0)
				BEGIN
					FETCH NEXT FROM LensesCur INTO @LenseId
					CLOSE EquipExistsCur
					DEALLOCATE EquipExistsCur
					CONTINUE
				END
				CLOSE EquipExistsCur
				DEALLOCATE EquipExistsCur

				INSERT INTO Equipments (CameraId, LensId) VALUES (@Id, @LenseId)

				SET @ToExit = 1
				FETCH NEXT FROM LensesCur INTO @LenseId
			END

			CLOSE LensesCur
			DEALLOCATE LensesCur

			IF (@ToExit > 0)
				BREAK

			SET @CurrentManId = @CurrentManId + 1
		END

		FETCH NEXT FROM CamerasCur INTO @Id, @ManId, @Model, @Year, @Price, @Megapixels
	END

	CLOSE CamerasCur
	DEALLOCATE CamerasCur
END

EXEC usp_CreateEquipment 'XG-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XG-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XG-1'
EXEC usp_CreateEquipment 'XG-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XH-1'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ2'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ2'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'XQ3'
EXEC usp_CreateEquipment 'X30'
EXEC usp_CreateEquipment 'X30'
EXEC usp_CreateEquipment 'X30'
EXEC usp_CreateEquipment 'X30'
EXEC usp_CreateEquipment 'X30'
EXEC usp_CreateEquipment 'X30'
EXEC usp_CreateEquipment 'X30'
EXEC usp_CreateEquipment 'X Vario'
EXEC usp_CreateEquipment 'X Vario'
EXEC usp_CreateEquipment 'NX30'
EXEC usp_CreateEquipment 'Alpha 7'

SELECT * FROM Equipments ORDER BY Id ASC





  





