DB:DatabaseApp

UPDATE dbo.base_user 
SET pwd=*pwd*
WHERE email IN(
	SELECT TOP 1 t1.email
	FROM dbo.base_user_reg t1
	WHERE reg_code=*reg_code*
	AND reg_kind='recoverypwd'
);

UPDATE dbo.base_user_reg
SET is_active='Y'
WHERE reg_code=*reg_code*;