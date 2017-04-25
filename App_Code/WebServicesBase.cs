using NService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for WebServicesBase
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebServicesBase : System.Web.Services.WebService {

    public WebServicesBase () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }



    [WebMethod]
    public void Run(string JsService)
    {
        Context.Response.Clear();
        Context.Response.ContentType = "application/json";        
        NService.HttpService.Instance.RunWs(JsService);       
        //Context.Response.Write("test");
    }



    
}
