var NgJs = NgJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

NgJs.Url = (function () {
    var _valueSrv = 'http://localhost/WebBase/WebServicesBase.asmx';
  
    this.get = function () {
        var srvURL = _valueSrv + "/Run";
        return srvURL;
    } 


    return {
        get: this.get       
    };

});

NgJs.Url = new NgJs.Url();