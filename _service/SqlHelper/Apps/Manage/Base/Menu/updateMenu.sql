DB:DatabaseApp

UPDATE base_menu
SET MENU_NM=*menu_nm*,
	LINK=*link*,
	UP_MENU_ID = *up_menu_id*,
	stop_mk=*stop_mk*,
	link_kind=*link_kind*,
	group_type=*group_type*,
	icon=*icon*,
	menu_nm_eng=*menu_nm_eng*
WHERE MENU_ID=*menu_id*