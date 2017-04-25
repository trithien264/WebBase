var KendoJs = KendoJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

KendoJs.Url = (function () {    
    var _valueSrv = 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"';
    var _valueSQLSrv = 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"WebBase.Common.Query2SQL.Query"';
    
    this.getService = function (servicesPath, arrParams) {
        var srvURL = _valueSrv + servicesPath + '"}&ServiceKind=View';
        if (arrParams)
            srvURL = _valueSrv + servicesPath + '","params":' + kendo.stringify(arrParams) + '}&ServiceKind=View';

        return srvURL;
    }

    this.getSqlService = function (servicesPath, arrParams) {
        var vParam = arrParams;
        vParam.push(servicesPath);
        //vParam.push("");
        vParam.reverse();

        var srvURL = _valueSQLSrv + '}&ServiceKind=View';
        if (arrParams)
            srvURL = _valueSQLSrv + ',"params":' + kendo.stringify(vParam) + '}&ServiceKind=View';
        return srvURL;
    }

    
    return {
        getService: this.getService
        , getSqlService: this.getSqlService       
    };

});

KendoJs.Url = new KendoJs.Url();