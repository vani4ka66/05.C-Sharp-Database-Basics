select
 substring(w.FirstName, 1, 1) as [first letter]
from WizzardDeposits w
where w.DepositGroup = 'Troll Chest'
group by substring(w.FirstName, 1, 1)
order by [first letter]
