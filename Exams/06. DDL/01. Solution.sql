--Task 1/1

create table Flights(
	
FlightID int primary key,
DepartureTime datetime not null,
ArrivalTime datetime not null,
[Status] varchar(9) check (Status='Departing' or Status='Delayed' or Status = 'Arrived' or Status = 'Cancelled'),
OriginAirportID int,
DestinationAirportID int,
AirlineID int,
constraint FK_Flights_Airlines foreign key (AirlineID) references Airlines (AirlineID),
constraint FK_Flights_OriginAirportID foreign key (OriginAirportID) references Airports (AirportID),
constraint FK_Flights_DestinationAirportID foreign key (DestinationAirportID) references Airports (AirportID)
)

create table Tickets(
TicketID int primary key,
Price decimal(8,2) not null,
Class varchar(6) check (Class='First' or Class='Second' or Class = 'Third'),
Seat varchar(5) not null,
CustomerID int,
FlightID int,
constraint FK_Tickets_Customers foreign key (CustomerID) references Customers (CustomerID),
constraint FK_Tickets_Flights foreign key (FlightID) references Flights (FlightID)
)



--Task 2/1 - Data Insertion

insert into Flights(FlightID, DepartureTime, ArrivalTime, [Status], OriginAirportID, DestinationAirportID, AirlineID)
values --(1, cast('2016-10-13 06:00:00' as datetime), cast('2016-10-13 10:00:00' as datetime), 'Delayed', 1, 4, 1),
       --(2, cast('2016-10-12 12:00:00' as datetime), cast('2016-10-12 12:01:00' as datetime), 'Departing', 1, 3, 2),
       (3, cast('2016-10-14 03:00:00' as datetime), cast('2016-10-20 4:00:00'as datetime), 'Delayed', 4, 2, 4),
       (4, cast('2016-10-12 01:24:00' as datetime), cast('2016-10-12 4:31:00' as datetime), 'Departing', 3, 1, 3),
       (5, cast('2016-10-12 08:11:00' as datetime), cast('2016-10-12 11:22:00' as datetime), 'Departing', 4, 1, 1),
       (6, cast('1995-06-21 12:30:00' as datetime), cast('1995-06-22 8:30:00' as datetime), 'Arrived', 2, 3, 5),
       (7, cast('2016-10-12 11:34:00' as datetime), cast('2016-10-13 03:00:00' as datetime), 'Departing', 2, 4, 2),
       (8, cast('2016-11-11 01:00:00' as datetime), cast('2016-11-12 10:00:00' as datetime), 'Delayed', 4, 3, 1),
       (9, cast('2015-10-01 12:00:00' as datetime), cast('2015-12-01 01:00:00' as datetime), 'Arrived', 1, 2, 1),
       (10, cast('2016-10-12 07:30:00' as datetime), cast('2016-10-13 12:30:00' as datetime), 'Departing', 2, 1, 7)


insert into Tickets(TicketID, Price, Class, Seat, CustomerID, FlightID)
values (1, 3000.00, 'First', '233-A', 3, 8),
	          (2, 1799.90, 'Second', '123-D', 1, 1),
	          (3, 1200.50, 'Second', '12-D', 2, 5),
	          (4, 410.68, 'Third', '45-Q', 2, 8),
	          (5, 560.00, 'Third', '201-R', 4, 6),
	          (6, 2100.00, 'Second', '13-T', 1, 9),
	          (7, 5500.00, 'First', '98-O', 2, 7)




--Task 2/2 

update Flights
set AirlineID = 1
where Status = 'Arrived'


--Task 2/3 – Update Tickets

update  Tickets 
 set Price = Price + (Price * 50/100)
 from Airlines a
 join Flights f
 on f.AirlineID = a.AirlineID
 join Tickets t
 on t.FlightID = f.FlightID
 where a.Rating = (select max(Rating) from Airlines)


--Task 2/4
create table CustomerReviews(
ReviewID int primary key,
ReviewContent varchar(255) not null,
ReviewGrade int check (ReviewGrade in (0,10)),
AirlineID int,
CustomerID int,
constraint FK_CustomersReviews_Airlines foreign key (AirlineID) references Airlines (AirlineID),
constraint FK_CustomersReviews_Customers foreign key (CustomerID) references Customers (CustomerID)
)

create table CustomerBankAccounts(
AccountID int primary key,
AccountNumber varchar(10) unique not null,
Balance decimal(10,2) not null,
CustomerID int,
constraint FK_CustomerBankAccounts_Customers foreign key (CustomerID) references Customers (CustomerID)
)


--Task 2/5
insert into CustomerReviews(ReviewID, ReviewContent, ReviewGrade, AirlineID, CustomerID)
values (1, 'Me is very happy. Me likey this airline. Me good.', 10, 1, 1),
(2, 'Ja, Ja, Ja... Ja, Gut, Gut, Ja Gut! Sehr Gut!', 10, 1, 4),
(3, 'Meh...', 5, 4, 3),
(4, 'Well I''ve seen better, but I’ve certainly seen a lot worse…', 7, 3, 5)

insert into CustomerBankAccounts(AccountID, AccountNumber, Balance, CustomerID)
values (1, '123456790', 2569.23, 1),
(2, '18ABC23672', 14004568.23, 2),
(3, 'F0RG0100N3', 19345.20, 5)


--Task 3/1//
select t.TicketID, t.Price, t.Class, t.Seat
from Tickets t


--Task 3/2//
select c.CustomerID, 
c.FirstName + ' ' + c.LastName as [FullName],
c.Gender
from Customers c
order by [FullName], c.CustomerID asc


--Task 3/3//
select
f.FlightID, f.DepartureTime, f.ArrivalTime
 from Flights f
 where f.Status = 'Delayed'
 order by f.FlightID asc


--Task 3/4//
 select top 5
  (a.AirlineID),
  max(a.AirlineName) as AirlineName,
   max(a.Nationality) as Nationality,
    max(a.Rating) as Rating
 from Airlines a
 join Flights f
 on f.AirlineId = a.AirlineID
 where f.FlightID is not null
 group by a.AirlineID
 order by max(a.Rating) desc, a.AirlineID asc
 
 
 
 --Task 5//
 select t.TicketID, 
 a.AirportName as Destination,
 c.FirstName +  ' ' + c.LastName as CustomerName
 from Tickets t
  join Customers c
 on c.CustomerID = t.CustomerID
  join Flights f
 on f.FlightID = t.FlightID
  join Airports a
 on a.AirportID = f.DestinationAirportID
 where t.Price < 5000 and t.Class = 'First'
 order by t.TicketID asc


 --Task 6//
select distinct(c.CustomerID), 
c.FirstName + ' ' + c.LastName as FullName, t.TownName
from Customers c
join Towns t
on t.TownID = c.HomeTownID
join Tickets tc
on tc.CustomerID = c.CustomerID
join Flights f
on f.FlightID = tc.FlightID
where f.Status = 'Departing'
order by c.CustomerID


--Task 7//
select distinct(c.CustomerID), c.FirstName + ' ' + c.LastName as FullName,
DATEDIFF(year, c.DateOfBirth, getdate()) as Age
from Customers c
join Tickets t
on t.CustomerID = c.CustomerID
join Flights f
on f.FlightID = t.FlightID
where f.Status= 'Departing'
order by Age, c.CustomerID asc

--Task 8//
select top 3 c.CustomerID, 
c.FirstName + ' ' + c.LastName as FullName,
t.Price,
a.AirportName
from Customers c
join Tickets t
on t.CustomerID = c.CustomerID
join Flights f
on f.FlightID = t.FlightID
join Airports a
on a.AirportID = f.DestinationAirportID
where f.Status = 'Delayed'
order by t.Price desc, c.CustomerID

--Task 9/
select top 5 f.FlightID, 
f.DepartureTime, 
f.ArrivalTime, 
a.AirportName,
aa.AirportName
from Flights f
join Airports a
on a.AirportID = f.OriginAirportID
join Airports aa
on aa.AirportId = f.DestinationAirportID
where f.Status = 'Departing'
order by f.DepartureTime asc, f.FlightID asc

--Task 10//
select c.CustomerID,
c.FirstName + ' ' + c.LastName as FullName,
datediff(year, c.DateOfBirth, getdate()) as Age
from Customers c
left join Tickets t
on c.CustomerID = t.CustomerID
left join Flights f
on f.FlightID = t.FlightID
where datediff(year, c.DateOfBirth, getdate()) < 21 
and f.Status = 'Arrived'
and t.TicketID is not null
order by Age desc, c.CustomerID

--Task 11/
select a.AirportID, a.AirportName,
count(distinct(c.CustomerID)) as Passengers
from Airports a
join Towns t
on t.TownID = a.TownID
join Customers c
on c.HomeTownID = t.TownID
join Tickets tk
on tk.CustomerID = c.CustomerID 
join Flights f
on f.FlightID = c.CustomerID
where f.Status = 'Departing'  and tk.TicketID is not null
group by  a.AirportID, a.AirportName
 having count(c.CustomerID) is not null


--Task 4/1
create proc usp_SubmitReview(
@CustomerID int ,@ReviewContent varchar(255),@ReviewGrade int , @AirlineName varchar(30)
)
as 
begin

if @AirlineName not in (select a.AirlineName from  Airlines a)
	raiserror ('Airline does not exist.', 16,1)
	Rollback 
end

--Task 4/2
create proc usp_PurchaseTicket(
@CustomerID int,
 @FlightID int, 
 @TicketPrice decimal(8,2),
  @Class varchar(6), @Seat varchar(5))
as
begin
	if @TicketPrice > (select cb.Balance from CustomerBankAccounts cb where @CustomerID = cb.CustomerID)
	raiserror ('Insufficient bank account balance for ticket purchase.', 16, 1)
	else
	begin 
		insert into Tickets(CustomerID, FlightID, Price, Class, Seat)
		values (@CustomerID, @FlightID, @TicketPrice, @Class, @Seat)

		update CustomerBankAccounts
		set Balance -= @TicketPrice
	end
end









