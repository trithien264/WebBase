var Kendo = {
    _dataSourceMain: null,
    URLSvr:'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"'
    , URLSQLSvr: 'http://localhost/WebBase/AjaxServiceNew.ashx?JsonService={"service":"WebBase.Common.Query2SQL.Query"'
    , getService:function (servicesPath, arrParams) {
       
        var srvURL = this.URLSvr + servicesPath + '"}&ServiceKind=View';
        if (arrParams)
            srvURL = this.URLSvr + servicesPath + '","params":' + kendo.stringify(arrParams) + '}&ServiceKind=View';

        return srvURL;
    }
    , getSqlService : function (servicesPath, arrParams) {

        var vParam = arrParams;
        vParam.push(servicesPath);
        //vParam.push("");
        vParam.reverse();

        var srvURL = this.URLSQLSvr + '}&ServiceKind=View';
        if (arrParams)
            srvURL = this.URLSQLSvr + ',"params":' + kendo.stringify(vParam) + '}&ServiceKind=View';
        return srvURL;
    }
    , dataSource: function (callbackTransport, callbackSchema) {
        dataSource1 = new kendo.data.DataSource({
            transport: callbackTransport,
            batch: true,
            pageSize: 20,
            schema: callbackSchema
        });
        this.dataSourceMain = dataSource1;
        //return dataSource1;
    },
    setDataSource: function (callbackTransport, callbackSchema) {      
        this.dataSource(callbackTransport, callbackSchema);      
        return this.dataSourceMain;
    }

}