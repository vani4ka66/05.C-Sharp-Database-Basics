SELECT 
  MIN(u.UserName) as UserName, 
  COUNT(a.Id) as AdsCount,
  (CASE WHEN admins.UserName IS NULL THEN 'no' ELSE 'yes' END) AS IsAdministrator
FROM 
  AspNetUsers u
  LEFT JOIN Ads a 
  ON u.Id = a.OwnerId
  LEFT JOIN (
    SELECT DISTINCT u.UserName
	FROM AspNetUsers u
	  LEFT JOIN AspNetUserRoles ur 
         ON ur.UserId = u.Id
	  LEFT JOIN AspNetRoles r 
         ON ur.RoleId = r.Id
	WHERE r.Name = 'Administrator'
  ) AS admins 
ON u.UserName = admins.UserName
GROUP BY OwnerId, u.UserName, admins.UserName
ORDER BY u.UserName
