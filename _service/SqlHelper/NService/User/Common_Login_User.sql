DB:DatabaseApp

SELECT b.user_id,b.user_desc,b.email,'' pwd,'30' ExpiresDays, end_mk as disable_mk
FROM base_user b 
WHERE user_id=*UserID*	