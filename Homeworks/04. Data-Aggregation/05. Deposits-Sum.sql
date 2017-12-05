select w.DepositGroup,
sum(w.DepositAmount) as [TotalSum]
from WizzardDeposits w
group by w.DepositGroup
