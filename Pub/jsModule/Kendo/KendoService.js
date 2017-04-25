

var KendoService = function () {


    var URLSvr = 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"';
    var URLSQLSvr = 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"WebBase.Common.Query2SQL.Query"';
    this.getService = function (servicesPath, arrParams) {
    
        var srvURL = URLSvr + servicesPath + '"}&ServiceKind=View';
        if (arrParams)
            srvURL = URLSvr + servicesPath + '","params":' + kendo.stringify(arrParams) + '}&ServiceKind=View';

        return srvURL;
    }

    this.getSqlService = function (servicesPath, arrParams) {

        var vParam = arrParams;
        vParam.push(servicesPath);
        //vParam.push("");
        vParam.reverse();

        var srvURL = URLSQLSvr + '}&ServiceKind=View';
        if (arrParams)
            srvURL = URLSQLSvr + ',"params":' + kendo.stringify(vParam) + '}&ServiceKind=View';
        return srvURL;
    }

}
var Kendo = new KendoService();

