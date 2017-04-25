<%@ WebHandler Language="C#" Class="AjaxServiceNew" %>

using System;
using System.Web;

public class AjaxServiceNew : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");

        NService.HttpService.Instance.Run();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}