create table Teachers(
TeacherID int identity(101,1),
Name nvarchar(50) not null,
ManagerID int null
constraint FK_Teachers_Teachers_ManagerId foreign key (ManagerId) references Teachers(TeacherId)
)

insert into Teachers(Name, ManagerID)
values ('John', null), ('Maya', 106), ('Silvia', 106),
 ('Ted', 105), ('Mark', 101), ('Greta', 101)


 alter table Teachers
 add constraint PK_Teachers_TeacherID primary key (TeacherID)


 alter table Teachers
 add constraint FK_Teachers_ManagerID foreign key (ManagerID) references Teachers (TeacherID)

