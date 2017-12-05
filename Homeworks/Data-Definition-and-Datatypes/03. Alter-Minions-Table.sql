alter table Minions
add TownId int not null
constraint FK_Minions_Towns foreign key(TownId) references Towns(Id)
