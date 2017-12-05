select u.Username, 
substring(u.Email, (CHARINDEX('@', u.Email) + 1), len(u.Email)) as [Email Provider]
 from Users u
 order by [Email Provider], u.Username
