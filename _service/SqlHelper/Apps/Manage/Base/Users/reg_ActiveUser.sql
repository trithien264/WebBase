DB:DatabaseApp

INSERT INTO dbo.base_user
           (pwd
           ,user_desc
           ,email           
           ,upd_date
		   ,end_mk
          )
SELECT top 1 pwd
	  ,user_desc
      ,email
      ,upd_date      
	  ,'N'
FROM dbo.base_user_reg t
where reg_code=*reg_code*
AND reg_kind='register'
AND NOT EXISTS(SELECT 1 FROM dbo.base_user t1 where t1.email=t.email);

UPDATE dbo.base_user_reg
SET is_active='Y'
WHERE reg_code=*reg_code*;