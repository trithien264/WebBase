var NgJs = NgJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

NgJs.Url = (function () {
    var _valueSrv = 'http://localhost/WebBase';
  
    this.get = function () {
        var srvURL = _valueSrv + "/WebServicesBase.asmx/Run";
        return srvURL;
    };

    this.getHost = function () {
        return _valueSrv;
    };

    return {
        get: this.get,
        getHost: this.getHost
    };

}).call(this);

//NgJs.Url = new NgJs.Url();