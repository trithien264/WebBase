DB:DatabaseApp

INSERT INTO dbo.base_user_reg
           (email           
           ,upd_date
		   ,reg_code		   
		   ,is_active		   
		   ,reg_kind
          )
     VALUES
           (*email*           
           ,*upd_date*
		   ,*reg_code*		
		   ,'N'		  
		   ,'recoverypwd'
          )