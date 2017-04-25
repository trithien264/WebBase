DB:DatabaseApp

INSERT INTO dbo.base_user_reg
           (user_desc
           ,email           
           ,upd_date
		   ,reg_code
		   ,pwd
		   ,is_active
		   ,reg_kind
          )
     VALUES
           (*user_desc*
           ,*email*           
           ,*upd_date*
		   ,*reg_code*
		   ,*pwd*
		   ,'N'
		   ,'register'
          )