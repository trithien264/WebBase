DB:DatabaseApp

SELECT b.user_id,b.user_desc,b.email,'' pwd,last_login,
CASE end_mk 
	WHEN 'Y' THEN  CAST('TRUE' as bit) 
	ELSE CAST('FALSE' as bit) 
END disabled_mk
FROM base_user b 
WHERE 1=1
@AndEmptyEqual(email)   	