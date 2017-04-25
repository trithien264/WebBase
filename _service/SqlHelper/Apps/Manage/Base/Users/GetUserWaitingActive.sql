DB:DatabaseApp

SELECT top 1 1
FROM base_user_reg b 
where  substring(b.upd_date,1,8) between   CONVERT(char(8), dateadd(day,-(CONVERT(INT,*OverActiveDays*)) ,GETDATE()),112) AND CONVERT(char(8), GETDATE(),112)
and email = *email*
and is_active='N'
AND reg_kind='register'