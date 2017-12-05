select p.PeakName, m.MountainRange as Mountain, p.Elevation
from Peaks p
join Mountains m
on m.Id = p.MountainId
order by p.Elevation desc, p.PeakName
