select a.DepositGroup
from 
(select w.DepositGroup,
 avg(w.MagicWandSize) as Zaplata 
from WizzardDeposits w
 group by w.DepositGroup) a
 where a.Zaplata = (select min(av.Zaplata) as MinZaplata from 
  (select  wd.DepositGroup, avg(wd.MagicWandSize) as Zaplata 
from WizzardDeposits wd
 group by wd.DepositGroup ) as av)



SELECT DepositGroup FROM – sa6toto
  (SELECT DepositGroup, AVG(MagicWandSize) AS AverageMagicWandSize
   FROM [dbo].[WizzardDeposits]
  GROUP BY DepositGroup) as avgm
  WHERE AverageMagicWandSize = ( SELECT MIN(AverageMagicWandSize) MinAverageMagicWandSize 
								   FROM
								(SELECT DepositGroup, AVG(MagicWandSize) AS AverageMagicWandSize
								   FROM [dbo].[WizzardDeposits]
								  GROUP BY DepositGroup) AS av)
