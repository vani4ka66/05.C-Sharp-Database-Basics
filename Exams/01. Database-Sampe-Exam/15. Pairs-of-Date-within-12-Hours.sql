SELECT 
a.Date AS FirstDate,
 b.Date AS SecondDate
FROM Ads a, Ads b
WHERE
  b.Date > a.Date AND
  DATEDIFF(second, a.Date, b.Date) < 12 * 60 * 60
ORDER BY a.Date, b.Date
