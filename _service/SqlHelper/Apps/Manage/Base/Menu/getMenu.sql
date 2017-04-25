DB:DatabaseApp

WITH locs(QUERY_MENU_ID,RIGHT_LEVEL,MENU_ID,UP_MENU_ID)
	AS
	(
		SELECT MENU_ID,0 RIGHT_LEVEL,MENU_ID,UP_MENU_ID
		FROM base_menu
		WHERE UP_MENU_ID = 0

		UNION ALL

		--這個選單的所有上層選單
		SELECT p.QUERY_MENU_ID,p.RIGHT_LEVEL-1,a.MENU_ID,a.UP_MENU_ID
		from base_menu a
			JOIN locs p ON  a.UP_MENU_ID = P.MENU_ID 
		WHERE right_level <=0
	)
SELECT * FROM  locs a 
INNER JOIN base_menu b on a.menu_id=b.menu_id
where  1=1  and
b.group_type=*group_type*
@AndEmptyLike(b.menu_nm)   	