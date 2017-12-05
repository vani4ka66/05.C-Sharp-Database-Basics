create table Minions(
   id int identity,
   Name nvarchar(50) not null,
   Age int,
   Constraint pk_Minions_Id   primary key(Id)
)




create table Towns(
   Id int identity primary key,
   Name nvarchar(50) not null
)
