create database Hotel
use Hotel


create table Employees(
Id int identity,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
Title nvarchar(50) not null,
Notes nvarchar(200) null,
constraint PK_Employees_Id primary key (Id)
)

  
create table Customers(
AccountNumber char(20) not null,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
PhoneNumber char(20) not null,
EmergencyName nvarchar(50) not null,
EmergencyNumber char(20) not null,
Notes nvarchar(50) null,
constraint PK_Customers_AccountNumber primary key (AccountNumber)
)

  
create table RoomStatus(
RoomStatus nvarchar(50) not null,
Notes nvarchar(50) null
constraint PK_RoomStatus primary key (RoomStatus)
)

  
create table RoomTypes(
RoomType nvarchar(50) not null,
Notes nvarchar(50) null
constraint PK_RoomTypes primary key (RoomType)
)

  
create table BedTypes(
BedType nvarchar(50) not null,
Notes nvarchar(50) null
constraint PK_BedTypes primary key (BedType)
)

  
create table Rooms(
RoomNumber int identity,
RoomType nvarchar(50) not null,
BedType nvarchar(50) not null,
Rate int not null,
RoomStatus nvarchar(50) not null,
Notes nvarchar(50) null,
constraint PK_Rooms_RoomNumber primary key (RoomNumber),
constraint FK_Rooms_RoomType foreign key (RoomType) references RoomTypes(RoomType),
constraint FK_Rooms_BedType foreign key (BedType) references BedTypes(BedType),
constraint FK_Rooms_RoomStatus foreign key (RoomStatus) references RoomStatus(RoomStatus)
)

  
create table Payments(
Id int identity,
EmployeeId int not null,
PaymentDate smalldatetime not null, 
AccountNumber char(20) not null,
FirstDateOccupied smalldatetime not null,
LastDateOccupied smalldatetime not null,
TotalDays int not null,
AmountCharged float not null,
TaxRate float not null,
TaxAmount float not null,
PaymentTotal float not null,
Notes nvarchar(50) null,
constraint PK_Payments_Id primary key (Id),
constraint FK_Payments_Employees foreign key (EmployeeId) references Employees(Id),
constraint FK_Payments_Customers foreign key (AccountNumber) references Customers(AccountNumber),
)

  
create table Occupancies(
Id int identity, 
EmployeeId int not null,
DateOccupied smalldatetime not null,
AccountNumber char(20) not null, 
RoomNumber int not null, 
RateApplied float not null,
PhoneCharge bit not null,
Notes nvarchar(200) null,
constraint PK_Occupancies_Id primary key (Id),
constraint FK_Occupancies_Employees foreign key (EmployeeId) references Employees(Id),
constraint FK_Occupancies_Customers foreign key (AccountNumber) references Customers(AccountNumber),
constraint FK_Occupancies_Rooms foreign key (RoomNumber) references Rooms(RoomNumber)
)

  
insert into Employees(FirstName, LastName, Title)
values
('Ivan', 'Ivanov', 'a'),
('Gosho','Goshev','b'),
('Pesho','Peshev','c')


insert into Customers(AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber)
values
('12345678901112134569', 'Ivan', 'Ivanov', '359889857', 'Pencho', '359878656565'),
('12345678901112134568', 'Gosho', 'Goshev', '359889856', 'Petko', '359878656564'),
('12345678901112134567', 'Ivan', 'Ivanov', '359889855', 'Gancho', '359878656563')


insert into RoomStatus(RoomStatus)
values
('available'),
('not available'),
('still cleaning')


insert into RoomTypes(RoomType)
values
('double'),
('appartment'),
('single')


insert into BedTypes(BedType)
values
('single'),
('double'),
('bedroom')

insert into Rooms(RoomType, BedType, Rate, RoomStatus)
values
('double', 'double', 5, 'available'),
('single', 'single', 6, 'available'),
('appartment', 'bedroom', 8, 'not available')

insert into Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal)
values
(1, '20140606', '12345678901112134569', '19990505', '20100505', 3650, 60, 8, 12, 6500),
(2, '20140605', '12345678901112134568', '19990504', '20100504', 3651, 60, 8, 12, 6500),
(3, '20140604', '12345678901112134567', '19990503', '20100503', 3652, 60, 8, 12, 6500)


insert into Occupancies(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge)
values
(1, GETDATE(), '12345678901112134569', 1, 5, 0),
(2, GETDATE(), '12345678901112134568', 2, 6, 1),
(3, GETDATE(), '12345678901112134567', 3, 6, 0)
