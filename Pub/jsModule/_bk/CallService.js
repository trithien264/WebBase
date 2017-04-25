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
        options.cfpLoadingBar.start();
        options.scope.fireFlag = true;
        return options.http({ method: 'GET', url: NgJs.Url.get(options.url, options.params) })
                  .success(function (data, status, headers, config) {
                      if (data.AjaxError == 0) {
                          options.cfpLoadingBar.complete();
                          options.scope.fireFlag = false;
                          return data.Result;
                      }
                      else {
                          options.cfpLoadingBar.complete();
                          options.toastrConfig.closeButton = true;
                          options.scope.fireFlag = false;
                          options.toastr["error"](data.Message, "Error Notification!!!");

                          return null;
                      }
                  })
                  .error(function (data, status, headers, config) {
                      options.cfpLoadingBar.complete();
                      options.toastrConfig.closeButton = true;
                      options.scope.fireFlag = false;
                      options.toastr["error"](data, "Error Notification!!!");
                      return null;
                  });

    }
    return this.setCallService();

});

