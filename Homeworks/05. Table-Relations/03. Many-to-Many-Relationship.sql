create table Students(
StudentID int identity(1,1),
Name nvarchar(50) not null
)

create table Exams(
ExamID int identity(101,1),
Name nvarchar(50) not null
)

create table StudentsExams(
StudentID int not null,
ExamID int not null
)

insert into Students(Name)
values ('Mila'), ('Toni'), ('Ron')

insert into Exams(Name)
values ('Spring MVC'), ('Neo4j'), ('Oracle 11g')

insert into StudentsExams(StudentID, ExamID)
values (1, 101), (1, 102), (2,101), (3, 103), (2, 102), (2, 103)

alter table Students
add primary key (StudentID)

alter table Exams
add primary key (ExamID)

alter table StudentsExams
add constraint PK_StudentExam primary key (StudentID, ExamID), 
constraint FK_StudentsExans_Students foreign key (StudentID) references Students(StudentID),
constraint FK_StudentsExams_Exams foreign key (ExamID) references Exams(ExamID)


