create table Categories(
Id int identity ,
Category nvarchar(30) not null,
DailyRate float not null,
WeeklyRate float not null,
MonthlyRate float not null,
WeekendRate float not null
constraint PK_Categories_Id primary key (Id)
)

  
create table Cars(
Id int identity,
PlateNumber int not null, 
Make nvarchar(30) not null,
Model nvarchar(30) not null,
CarYear smalldatetime not null,
CategoryId int not null,
Doors tinyint not null,
Picture image null,
Condititon nvarchar(30) not null,
Available bit not null
constraint PK_Cars_Id primary key (Id)
constraint FK_Cars_Categories foreign key (CategoryId) references Categories(Id)
)

  
create table Employees(
Id int identity,
FirstName nvarchar(50) not null,
LastName nvarchar(50) not null,
Title nvarchar(30) not null,
Notes nvarchar(200) null
constraint PK_Employee_Id primary key (Id)
)

  
create table Customers(
Id int identity,
DriverLicenceNumber int not null,
FullName nvarchar(100) not null,
Address nvarchar(60) not null,
City nvarchar(30) not null,
ZipCode char(10) not null,
Notes nvarchar(200) null
constraint PK_Customers_Id primary key (Id)
)

  
create table RentalOrders(
Id int identity,
EmployeeId int not null,
CustomerId int not null,
CarId int not null,
CarCondition nvarchar(100) not null,
TankLevel int not null, 
KilometrageStart int not null,
KilometrageEnd int not null,
TotalKilometrage int not null,
StartDate smalldatetime not null,
EndDate smalldatetime not null,
TotalDays int not null,
RateApplied int not null,
TaxRate int not null,
OrderStatus nvarchar(50) not null,
Notes nvarchar(200) null
constraint PK_RentaOrders_Id primary key (Id)
constraint FK_RentaOrders_Employees foreign key (EmployeeId) references Employees(Id),
constraint FK_RentaOrders_Customers foreign key (CustomerId) references Customers(Id),
constraint FK_RentaOrders_Cars foreign key (CarId) references Cars(Id)
)

  
insert into Categories(Category, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
values
('a', 1,2,3,4),
('b', 2,3,4,5),
('c', 3,4,5,6)


insert into Cars(PlateNumber, Make, Model, CarYear, CategoryId, Doors, Picture, Condititon, Available)
values
(1, 'Germany', 'Volkswagen', '19990520', 3, 4, null, 'good', 1),
(2, 'Italy', 'Opel', '19980520', 1, 4, null, 'bad', 0),
(3, 'Russia', 'Lada', '19970520', 2, 2, null, 'super', 1)


insert into Employees(FirstName, LastName, Title)
values
('Ivan', 'Ivanov', 'professor'),
('Pesho', 'Peshev', 'dekan'),
('Gosho', 'Goshev', 'professor')


insert into Customers(DriverLicenceNumber, FullName, Address, City, ZipCode)
values
(1234567890, 'Ivan Ivanovich', 'ul. Poduqne 25', 'Varna', 1200),
(1234567899, 'Dragan Draganov', 'ul. Shipka 50', 'Bourgas', 1574),
(1234567898, 'Pesho Petrov', 'ul. Hubavka 55', 'Sofia', 1000)


insert into RentalOrders(EmployeeId, CustomerId, CarId, CarCondition, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus)
values
(1, 1, 1, 'good', 3, 0, 500, 500, '20101010', '20111010', 365, 5, 5, 'good'),
(2, 2, 2, 'bad', 5, 500, 1000, 500, '20101010', '20111010', 365, 6, 6, 'very bad'),
(3, 3, 3, 'good', 8, 1000, 1500, 500, '20101010', '20111010', 365, 8, 8, 'good')
