DB:DatabaseApp


WITH locs(QUERY_MENU_ID,RIGHT_LEVEL,MENU_ID,UP_MENU_ID)
AS
(
	--抓出某人直接擁有的權限選單
	SELECT a.MENU_ID,0 RIGHT_LEVEL,a.MENU_ID,a.UP_MENU_ID
	FROM base_menu a	
	WHERE group_type=*group_type* 

    UNION ALL
	
    SELECT p.QUERY_MENU_ID,p.RIGHT_LEVEL-1,a.MENU_ID,a.UP_MENU_ID
	from base_menu a
        JOIN locs p ON a.MENU_ID = P.UP_MENU_ID 
	WHERE right_level <=0 

	UNION ALL

    SELECT p.QUERY_MENU_ID,p.RIGHT_LEVEL+1,a.MENU_ID,a.UP_MENU_ID
	from base_menu a
        JOIN locs p ON a.UP_MENU_ID = P.MENU_ID 
	WHERE right_level >=0  
)

select max(right_level) RIGHT_LEVEL,  a.MENU_ID,b.MENU_NM,b.MENU_NM_ENG,b.UP_MENU_ID,b.LINK,b.LINK_KIND,b.STOP_MK,b.ICON
from locs a
inner join base_menu b on a.MENU_ID=b.menu_id
where exists(select * from locs b where b.up_menu_id = 0 and b.query_menu_id = a.query_menu_id)
group by a.MENU_ID,b.MENU_NM,b.MENU_NM_ENG,b.UP_MENU_ID,b.LINK,b.LINK_KIND,b.STOP_MK,b.ICON
order by max(right_level)

/*

WITH locs(QUERY_MENU_ID,RIGHT_LEVEL,MENU_ID,UP_MENU_ID)
	AS
	(
		SELECT MENU_ID,0 RIGHT_LEVEL,MENU_ID,UP_MENU_ID
		FROM base_menu
		WHERE group_type=*group_type*
		AND UP_MENU_ID = 0

		UNION ALL

		--這個選單的所有上層選單
		SELECT p.QUERY_MENU_ID,p.RIGHT_LEVEL-1,a.MENU_ID,a.UP_MENU_ID
		from base_menu a
			JOIN locs p ON  a.UP_MENU_ID = P.MENU_ID 
		WHERE right_level <=0
		AND group_type=*group_type*
	)	
SELECT a.MENU_ID,b.MENU_NM,b.UP_MENU_ID,b.LINK,b.LINK_KIND,b.STOP_MK
FROM  locs a 
INNER JOIN base_menu b on a.menu_id=b.menu_id
--INNER JOIN [dbo].[base_userrights] t2 ON b.menu_id=t2.menu_id 
where  1=1  
--AND group_type=*group_type*
--AND t2.user_id=*user_id*1
@AndEmptyLike(b.menu_nm)   	*/