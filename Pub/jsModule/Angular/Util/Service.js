var NgJs = NgJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

NgJs.callService = (function (options) {
    var defaults = {
        url: "",
        params: [{}],
        http: {},
        toastr: {},
        toastrConfig: {},
        ngFactortyId: "ngFactortyId",
        cfpLoadingBar: {},
        scope: {}
    };

    var options = $.extend(defaults, options);
    this.setCallService = function () {
        //loading tool
        var haveLoading = false;
        try {
            options.cfpLoadingBar.start();
            haveLoading = true;
        } catch (e) { }

        //toas tool
        var haveToastr = false;
        try {
            var a = options.toastrConfig.closeButton
            options.toastrConfig.allowHtml = true;
            haveToastr = true;
        } catch (e) { }
       
        options.scope.fireFlag = true;


        var JsService = {};
        JsService.service = options.url;
        JsService.params = options.params;
       
        
        //return options.http({ method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, url: NgJs.Url.get(), data: $.param({ service: options.url, JsParams: JSON.stringify(options.params) }) })
        return options.http({ method: 'POST', headers: { 'Content-Type': 'application/x-www-form-urlencoded' }, url: NgJs.Url.get(), data: $.param({ JsService: JSON.stringify(JsService) }) })
                  .success(function (data, status, headers, config) {

                      if (data.AjaxError == 0) {
                          if (haveLoading)
                            options.cfpLoadingBar.complete();
                          options.scope.fireFlag = false;
                          return data.Result;
                      }
                      else {
                          if (haveLoading)
                              options.cfpLoadingBar.complete();
                          if (haveToastr)
                          {
                              //call Fun language       

                              //Show toast
                              options.toastrConfig.closeButton = true;
                              var objMessage=data.Message;                    

                              //change language
                              if (data.Message.toString().indexOf("n-lang") != -1)
                              {
                                  var lang = NgJs.Language.getLang();
                                  options.http.get(NgJs.Url.getHost() + "/Pub/Common/Languages/" + lang + ".js", { cache: true }).success(function (obj_lang) {                                      
                                      var iElement = angular.element(objMessage);    
                                      var iElementHeader = angular.element("<n-lang code='MsgHeader'>Error Notification!!!<n-lang>");
                                      var msgLang = NgJs.Language._ChangeElemLang(options.scope, iElement, iElement[0].attributes, null, obj_lang);                                      
                                      var msgHeader = NgJs.Language._ChangeElemLang(options.scope, iElementHeader, iElementHeader[0].attributes, null, obj_lang);                                      
                                      options.toastr["error"](msgLang, msgHeader); 
                                  }).error(function (response) {
                                      options.toastr["error"](objMessage, "Notification!!!");
                                  });
                              }
                              else
                              {
                                  options.toastr["error"](objMessage, "Notification!!!");
                              }
                              
                          }
                         
                          options.scope.fireFlag = false;
                          return null;                        
                      }
                  })
                  .error(function (data, status, headers, config) {
                      if (haveLoading)
                          options.cfpLoadingBar.complete();
                      if (haveToastr) {
                          options.toastrConfig.closeButton = true;                          
                          options.toastr["error"](data, "Notification!!!");
                      }
                      options.scope.fireFlag = false;
                      return null;
                  });

    }
    return this.setCallService();

});

