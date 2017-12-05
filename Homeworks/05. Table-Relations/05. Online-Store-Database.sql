create table Cities(
CityId int identity primary key,
Name nvarchar(50) not null
)

create table Customers(
CustomerId int identity primary key,
Name varchar(50) not null,
Birthday date not null,
CityId int not null,
constraint FK_Customers_Cities foreign key (CityId) references Cities(CityId)
)

create table Orders(
OrderId int identity primary key,
CustomerId int not null,
constraint FK_Orders_Customers foreign key (CustomerId) references Customers(CustomerId)
)

create table ItemTypes(
ItemTypeId int identity primary key,
Name varchar(50) not null
)

create table Items(
ItemId int identity primary key,
Name varchar(50) not null,
ItemTypeId int not null,
constraint FK_Items_ItemTypes foreign key (ItemTypeId) references ItemTypes(ItemTypeId)
)

create table OrderItems(
OrderId int,
ItemId int,
constraint PK_OrderItems primary key (OrderId, ItemId),
constraint FK_OrderItems_Orders foreign key (OrderId) references Orders(OrderId),
constraint FK_OrderItems_Items foreign key (ItemId) references Items(ItemId)
)
