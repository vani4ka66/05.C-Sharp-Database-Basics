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
