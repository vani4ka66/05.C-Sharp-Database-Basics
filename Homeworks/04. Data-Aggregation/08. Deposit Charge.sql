select w.DepositGroup,
 w.MagicWandCreator,
min(w.DepositCharge) as MinDepositCharge
 from WizzardDeposits w
  group by w.DepositGroup,w.MagicWandCreator
 order by w.MagicWandCreator, w.DepositGroup
