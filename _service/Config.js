{
    "Mail":{
        "SmtpServer": "mail.pyv.com.vn"
        ,"FromMail": "web.trithien@pyv.com.vn" 
    }       
    ,"Apps": {
        "Info": {
            "Config_AppName": "WebBase"           
            , "Config_AppLink": "http://localhost/WebBase" 
            , "ShortAppName": "WebBase.vn" /*use to display sender email*/
        }
        ,"User": {
            "OverActiveDays": "2"  
        }
    }  
    , "AppSetup":{
        "LogLevel": "Medium"  /*High: FullLog (Default); Medium: NoSystemLog*/
        ,"AllowLogFile": true
        ,"AllowLogDB": true
        ,"AllowRecordMenu": true
        , "Authority": {
            SuperManager:["10003"]
        }
        ,"Internet": {
                EnableInternetCheck: false
        } 
    }
}