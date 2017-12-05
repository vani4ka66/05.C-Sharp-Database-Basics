create table Manufacturers(
ManufacturerID int identity not null,-- primary key,
Name nvarchar(50) not null,
EstablishedOn smalldatetime not null	
)


create table Models(
ModelID int identity(101,1),-- primary key,
Name nvarchar(50) not null,
ManufacturerID int not null,
constraint FK_Models_Manufacturers foreign key (ManufacturerID) references Manufacturers(ManufacturerID)
)


insert into Manufacturers( Name, EstablishedOn)
values ( 'BMW', '1916/03/07'), ( 'Tesla','2003/01/01'), ( 'Lada','1966/05/01')


insert into Models(Name, ManufacturerID )
values ( 'X1', 1), ('i6', 1), ('Model S', 2), 
       ( 'Model X', 2), ( 'Model 3', 2), ('Nova', 3)

begin tran
alter table Manufacturers 
add constraint PK_Manufacturers primary key (ManufacturerID) 

alter table Models
add constraint PK_Models primary key (ModelID) 

alter table Models
add constraint FK_Models_Manufacturers foreign key (ManufacturerID) references Manufacturers(ManufacturerID)
