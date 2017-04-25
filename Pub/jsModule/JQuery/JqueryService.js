
var JqueryService = function () {

    this.callService = function (servicesPath,URL, arrParams, callbackResult) {

   
        var JsService = {};
        JsService.service = servicesPath;
        JsService.params = arrParams;
        
        $.ajax({
            type: "POST",
            url: URL,
            data: $.param({ JsService: JSON.stringify(JsService) }),
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            dataType: "json",
            async: false,
            success: function (data) {                
                if (typeof callbackResult !== 'undefined') {
                    callbackResult(data);
                }                
            },
            error: function (e) {
                debugger
            }
        });
    }

    this.getService = function (servicesPath, arrParams, callbackResult) {
        var URLSvr = 'http://localhost/WebBase/WebServicesBase.asmx/Run';

        /*var srvURL = URLSvr + servicesPath + '"}&ServiceKind=View';
        if (arrParams)
            srvURL = URLSvr + servicesPath + '","params":' + JSON.stringify(arrParams) + '}&ServiceKind=View';*/


        this.callService(servicesPath,URLSvr, arrParams, callbackResult);
    }

    this.getSqlService = function (servicesPath, arrParams, callbackResult) {

        var vParam = arrParams;
        vParam.push(servicesPath);
        //vParam.push("");
        vParam.reverse();
        var URLSQLSvr = 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"WebBase.Common.Query2SQL.Query"';
        var srvURL = URLSQLSvr + '}&ServiceKind=View';
        if (arrParams)
            srvURL = URLSQLSvr + ',"params":' + JSON.stringify(vParam) + '}&ServiceKind=View';

        this.callService(srvURL, callbackResult);
    }


}

var Jquery = new JqueryService();

