select w.DepositGroup,
Max(w.MagicWandSize) as [LongestMagicWand]
from WizzardDeposits w
group by w.DepositGroup
