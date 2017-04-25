DB:DatabaseApp

SELECT *,
CASE stop_mk 
	WHEN 'Y' THEN  CAST('TRUE' as bit) 
	ELSE CAST('FALSE' as bit) 
END disabled_mk
FROM  base_menu a 
where MENU_ID=*menu_id*