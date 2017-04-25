DB:DatabaseApp

/*SELECT a.user_id,b.user_nm,b.user_desc,b.email
FROM base_userrights a
inner join base_user b on a.user_id=b.user_id*/

WITH locs(query_menu_id,right_level,menu_id,up_menu_id)
AS
(
	SELECT menu_id,0 right_level,menu_id,up_menu_id
	FROM base_menu
	WHERE menu_id = *menu_id*

    UNION ALL

	--這個選單的所有上層選單
    SELECT p.query_menu_id,p.right_level-1,a.menu_id,a.up_menu_id
	from base_menu a
        JOIN locs p on a.menu_id = p.up_menu_id 
	WHERE right_level <= 0
)
SELECT r.user_id,isnull(right_level,-999) userlevel,isnull(a.menu_id,0) menu_id,isnull(m.menu_nm,'Root') menu_nm,user_desc,email
FROM base_userrights r 
left join locs a on a.menu_id = r.menu_id 
left join base_menu m on a.menu_id = m.menu_id
inner join [base_user] u on r.user_id=u.user_id
where  a.menu_id is not null
@AndEmptyEqual(u.user_id) 
@AndEmptyLike(u.email)
order by r.user_id,menu_id