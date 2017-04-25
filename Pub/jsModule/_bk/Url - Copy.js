var NgJs = NgJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

NgJs.Url = (function () {
    var _valueSrv = 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"';
    var _valueSQLSrv = 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"WebBase.Common.Query2SQL.Query"';

    this.get = function (servicesPath, arrParams) {
        var srvURL = _valueSrv + servicesPath + '"}&ServiceKind=View';
        if (arrParams)
            srvURL = _valueSrv + servicesPath + '","params":' + JSON.stringify(arrParams) + '}&ServiceKind=View';
            
        return srvURL;
    }

    this.getSql = function (servicesPath, arrParams) {
        var vParam = arrParams;
        vParam.push(servicesPath);
        //vParam.push("");
        vParam.reverse();

        var srvURL = _valueSQLSrv + '}&ServiceKind=View';
        if (arrParams)
            srvURL = _valueSQLSrv + ',"params":' + JSON.stringify(vParam) + '}&ServiceKind=View';
        return srvURL;
    }


    return {
        get: this.get
        , getSql: this.getSql
    };

});

NgJs.Url = new NgJs.Url();