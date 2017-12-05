select w.DepositGroup,
sum(w.DepositAmount) as TotalSum
from WizzardDeposits w
where w.MagicWandCreator = 'Ollivander family'
group by w.DepositGroup
having sum(w.DepositAmount) < 150000
order by TotalSum desc
