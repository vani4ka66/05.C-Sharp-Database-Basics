update Employees 
   set Salary *= 1.12
 where DepartmentId IN 
	(select d.DepartmentId 
	   from Departments d
	  where [Name] IN 
		('Engineering', 'Tool Design', 'Marketing', 'Information Services'))
	
	
	
select e.Salary from Employees e
