DB:DatabaseApp



WITH locs(QUERY_MENU_ID,RIGHT_LEVEL,MENU_ID,UP_MENU_ID,RIGHT_USERID)
AS
(
	--抓出某人直接擁有的權限選單
	SELECT a.MENU_ID,0 RIGHT_LEVEL,a.MENU_ID,a.UP_MENU_ID,r.user_id
	FROM base_menu a
	join base_userrights r on r.right_kind='menu' and r.menu_id = a.menu_id	
	WHERE r.user_id=*user_id*  AND group_type=*group_type*

    UNION ALL
	
    SELECT p.QUERY_MENU_ID,p.RIGHT_LEVEL-1,a.MENU_ID,a.UP_MENU_ID,aa.user_id
	from base_menu a
        JOIN locs p ON a.MENU_ID = P.UP_MENU_ID 
		OUTER APPLY (select * from base_userrights r where p.UP_MENU_ID=r.menu_id)aa
	WHERE right_level <=0 

	UNION ALL

    SELECT p.QUERY_MENU_ID,p.RIGHT_LEVEL+1,a.MENU_ID,a.UP_MENU_ID,aa.user_id
	from base_menu a
        JOIN locs p ON a.UP_MENU_ID = p.MENU_ID 
		OUTER APPLY (select * from base_userrights r where p.QUERY_MENU_ID=r.menu_id)aa
	WHERE right_level >=0  
)

select max(right_level) RIGHT_LEVEL,  a.MENU_ID,b.MENU_NM,b.MENU_NM_ENG,b.UP_MENU_ID,b.LINK,b.LINK_KIND,b.STOP_MK,
CASE 
	WHEN a.RIGHT_USERID IS NULL THEN 'N'
	ELSE 'Y'
END rights_mk

from locs a
inner join base_menu b on a.MENU_ID=b.menu_id
where exists(select * from locs b where b.up_menu_id = 0 and b.query_menu_id = a.query_menu_id)
group by a.MENU_ID,b.MENU_NM,b.MENU_NM_ENG,b.UP_MENU_ID,b.LINK,b.LINK_KIND,b.STOP_MK,a.RIGHT_USERID
order by max(right_level)
