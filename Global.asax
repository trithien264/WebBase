<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        NService.AppEventHanlder.Instance.OnStart();

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown
        NService.AppEventHanlder.Instance.OnEnd();

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs
        NService.AppEventHanlder.Instance.OnError();

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started
        //NService.AppEventHanlder.Instance.OnSessionStart();

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

    void Application_PreRequestHandlerExecute(object sender, EventArgs e)
    {
        //int a = 0;
        //int b = 0;
        NService.AppEventHanlder.Instance.OnRequest();
    }

    void Application_EndRequest(object sender, EventArgs e)
    {
        //int a = 0;
        //int b = 0;
        NService.AppEventHanlder.Instance.OnEndRequest();
    }
       
</script>
