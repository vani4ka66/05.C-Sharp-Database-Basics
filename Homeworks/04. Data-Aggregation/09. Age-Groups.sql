select 
case when w.Age>=0 and w.Age <= 10 then '[0-10]'
     when w.Age>=11 and w.Age <= 20 then '[11-20]'
	 when w.Age>=21 and w.Age <= 30 then '[21-30]'
	 when w.Age>=31 and w.Age <= 40 then '[31-40]'
	 when w.Age>=41 and w.Age <= 50 then '[41-50]'
	 when w.Age>=51 and w.Age <= 60 then '[51-60]'
	 else '[61+]'
	 end as [AgeGroup],
	 count(w.Age) as [WizardCount]
from WizzardDeposits w
group by (case when w.Age>=0 and w.Age <= 10 then '[0-10]'
     when w.Age>=11 and w.Age <= 20 then '[11-20]'
	 when w.Age>=21 and w.Age <= 30 then '[21-30]'
	 when w.Age>=31 and w.Age <= 40 then '[31-40]'
	 when w.Age>=41 and w.Age <= 50 then '[41-50]'
	 when w.Age>=51 and w.Age <= 60 then '[51-60]'
	 else '[61+]' end)
