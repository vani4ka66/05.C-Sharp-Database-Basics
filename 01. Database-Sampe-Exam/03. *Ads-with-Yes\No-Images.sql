SELECT 
	Title,
	[Date],
	CASE 
		WHEN ImageDataUrl IS NOT NULL THEN 'yes'
		WHEN ImageDataUrl IS NULL THEN 'no'
	END
	AS [Has Image] 
FROM Ads
ORDER BY Id
