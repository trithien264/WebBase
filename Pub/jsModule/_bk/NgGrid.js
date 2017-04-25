var NgJs = NgJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

NgJs.grid = (function (options) {
    var defaults = {
        url: "",
        params: [{}],
        http: {},
        toastr: {},
        toastrConfig: {},
        ngFactortyId: "ngFactortyId",
        cfpLoadingBar: {},
        scope: {},
        paginationPageSize: 5,
        paginationPageSizes: [5, 10, 100],
        columnDefs: [],
        gridId: "ngDefaultGridID"
    };

    var options = $.extend(defaults, options);
    this.setCallGrid = function () {
        options.scope[options.gridId] = {
            paginationPageSizes: options.paginationPageSizes,
            paginationPageSize: options.paginationPageSize,
            columnDefs: options.columnDefs
        }

        options.scope.ngBtnSearchData = function () {
            options.params = [options.scope.modelsData];
            callData();
        }
        

        callData = function () {
            options.cfpLoadingBar.start();
            options.scope.fireFlag = true;
            return options.http({ method: 'GET', url: NgJs.Url.get(options.url, options.params) })
                  .success(function (data, status, headers, config) {
                      if (data.AjaxError == 0) {
                          options.cfpLoadingBar.complete();
                          options.scope.fireFlag = false;

                          if (data && data.AjaxError == 0) {
                              if (data.Result == null) {
                                  options.scope[options.gridId].data.length = 0;
                              }
                              else {
                                  options.scope[options.gridId].data = data.Result;
                              }
                          }
                      }
                      else {
                          options.scope[options.gridId].data.length = 0;

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

        callData();

    }
    return this.setCallGrid();

});

