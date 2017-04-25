DB:DatabaseApp

SELECT b.user_id,b.user_desc,b.email,b.pwd
FROM base_user b 
INNER JOIN base_user_reg c on b.email=c.email
WHERE c.reg_code=*reg_code*
and c.is_active='N'
AND c.reg_kind='register'