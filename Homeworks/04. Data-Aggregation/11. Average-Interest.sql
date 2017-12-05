select w.DepositGroup,
w.IsDepositExpired,
avg(w.DepositInterest) as AverageInterest
from WizzardDeposits w
where w.DepositStartDate > '19850101'
group by w.DepositGroup, w.IsDepositExpired
order by w.DepositGroup desc
