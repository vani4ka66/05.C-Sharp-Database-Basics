SELECT 
  PeakName, MountainRange as Mountain, Elevation
FROM 
  Peaks p 
  JOIN Mountains m 
ON p.MountainId = m.Id
ORDER BY Elevation DESC, PeakName
