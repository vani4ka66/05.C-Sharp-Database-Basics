create table Passports(
PassportID int identity primary key,
PassportNumber nvarchar(50) not null
)


create table Persons(
PersonID int identity,
FirstName nvarchar(50) not null, 
Salary money not null,
PassportID int not null
)


SET IDENTITY_INSERT Passports ON


insert into Passports(PassportID, PassportNumber)
values (101, 'N34FG21B'), (102, 'K65LO4R7'), (103, 'ZE657QP2')
SET IDENTITY_INSERT Passports Off


SET IDENTITY_INSERT Persons ON


insert into Persons(PersonID, FirstName, Salary, PassportID)
values (1, 'Roberto', 43300, 102) ,
 (2, 'Tom', 56100, 103) ,
 (3, 'Yana', 60200, 101) 


SET IDENTITY_INSERT Persons OFF


alter table Persons
add primary key (PersonID)


alter table Persons 
add foreign key (PassportID) references Passports(PassportID)


