DB:DatabaseApp


WITH locs(QUERY_MENU_ID,RIGHT_LEVEL,MENU_ID,UP_MENU_ID)
AS
(
	--抓出某人直接擁有的權限選單
	SELECT a.MENU_ID,0 RIGHT_LEVEL,a.MENU_ID,a.UP_MENU_ID
	FROM base_menu a
	join base_userrights r on r.right_kind='menu' and r.menu_id = a.menu_id	
	WHERE r.user_id=*USERID*  AND group_type='M' 

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

select  TOP 1 1
from locs a
inner join base_menu b on a.MENU_ID=b.menu_id
where link=*LINK*

