create table Users(
Id int identity primary key,
Username nvarchar(30) not null,
Password nvarchar(26) not null,
ProfilePicture image null,
LastLoginTime smalldatetime,
isDeleted bit null
)

	
insert into Users(Username, Password, ProfilePicture,LastLoginTime, isDeleted)
values ('go666', '12345', null, GETDATE(), 1),
	   ('pesh55', '23456', null, GETDATE(), 0),
	   ('maria88', '34567', null, GETDATE(), 1),
       ('minka99', '45678', null, GETDATE(), 0),
	    ('gancho33', '56789', null, GETDATE(), 1)
