create database Movies
use Movies


create table Directors(
Id int identity primary key,
DirectorName nvarchar(50) not null,
Notes nvarchar(200) not null
)

  
create table Genres(
Id int identity primary key,
GenreName nvarchar(50) not null,
Notes nvarchar(200)not  null
)

  
create table Categories(
Id int identity primary key,
CategoryName nvarchar(50) not null,
Notes nvarchar(200) not null
)

  
create table Movies(
Id int identity primary key,
Title nvarchar(30) not null,
DirectorId int not null,
CopyrightYear smalldatetime not null,
Length float not null,
GenreId int not null,
CategoryId int not null,
Rating float not null,
Notes nvarchar(200) not null
constraint FK_Movies_Directors foreign key(DirectorId) references Directors(Id),
constraint FK_Movies_Genres foreign key(GenreId) references Genres(Id),
constraint FK_Movies_Categories foreign key(CategoryId) references Categories(Id)
)

  
insert into Directors(DirectorName, Notes)
values 
('Spilberg', 'a'), ('Ivan', 'b'), ('Asen', 'c'), ('Gosho', 'd'), ('Pesho', 'f')

  
insert into Genres(GenreName, Notes)
values
('comedy', 'a'), ('drama', 'b'), ('fantasy', 'c'), ('music', 'd'), ('horror', 'f')

  
insert into Categories(CategoryName, Notes)
values
('good', 'a'), ('bad', 'b'), ('awsome', 'c'), ('fantastic', 'd'),('auful', 'f')

  
insert into Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId,Rating, Notes)
values
('The Good, the bad and the evel', 1, '19990710', 122, 1, 1, 5, 'a'),
('Cindarella', 2, '19981202', 120, 2, 2, 10, 'b'),
('Batman', 3, '19881005', 110, 3, 3, 6, 'c'),
('Lie to me', 4, '19870606', 80, 4, 4, 9, 'd'),
('Game of hunger', 5, '19860505', 95, 5, 5, 8, 'f')
