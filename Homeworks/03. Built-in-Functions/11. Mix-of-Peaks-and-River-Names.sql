select  p.PeakName, r.RiverName, lower(concat(p.PeakName, SUBSTRING(r.RiverName, 2, len(r.RiverName)))) as Mix
from Peaks p, Rivers r
where right(p.PeakName, 1) = left(r.RiverName, 1)
order by Mix
