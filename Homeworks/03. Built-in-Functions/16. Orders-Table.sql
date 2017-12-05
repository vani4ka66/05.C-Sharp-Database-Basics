select  o.ProductName, 
o.OrderDate,
dateadd(day, 3, o.OrderDate) as [Pay Due],
dateadd(month, 1, o.OrderDate) as [Deliver Due],
from Orders o
