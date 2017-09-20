SELECT 
  p.PeakName, 
  r.RiverName, 
  LOWER(p.PeakName + SUBSTRING(r.RiverName, 2, LEN(r.RiverName))) AS Mix
FROM Peaks p, Rivers r
WHERE RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
ORDER BY Mix
