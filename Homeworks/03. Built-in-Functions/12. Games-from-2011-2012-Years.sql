select top 50 g.Name as Game, 
 FORMAT(Start, 'yyyy-MM-dd')  as S
 from Games g
 where year(g.Start)= 2011 or year(g.Start) =  2012
 order by g.Start, g.Name
