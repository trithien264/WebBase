DB:DatabaseApp

SELECT b.user_id,b.user_desc,b.email
FROM base_user b 
WHERE email=*email*	
and pwd=*pwd*