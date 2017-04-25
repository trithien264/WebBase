DB:DatabaseApp

SELECT top 1 *
FROM base_user_reg b 
where  email = *email*
and reg_code=*reg_code*
AND reg_kind='register'
AND  substring(b.upd_date,1,8) between   CONVERT(char(8), dateadd(day,-(CONVERT(INT,*OverActiveDays*)) ,GETDATE()),112) AND CONVERT(char(8), GETDATE(),112)