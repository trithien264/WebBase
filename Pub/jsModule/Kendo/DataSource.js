var KendoJs = KendoJs || {}; //x = a || b; (a, b đều là object) thì x = a nếu a khác null trái lại x = b.

KendoJs.dataSource = (function (options) {
    var defaults = {
        transport: {}
        , schema: {}
        , batch: true        
    };

    var options = $.extend(defaults, options);


    /*var objsuccess = {
        complete: function (data) {         
            var jData = JSON.parse(data.responseText);
            if (jData.AjaxError != "0")//Error Exception
            {
                alert(jData.Message);
                //that.cancelRow();
            }
        }
    };
   
    if (!options.transport.read.complete)
        options.transport.read.complete = objsuccess.complete;
    if (!options.transport.create.complete)
        options.transport.create.complete = objsuccess.complete;
    if (!options.transport.update.complete)
        options.transport.update.complete = objsuccess.complete;
    if (!options.transport.destroy.complete)
        options.transport.destroy.complete = objsuccess.complete;
    */

    this.setDataSource = function () {
        var _ds;
        if (options.pageSize) {
            _ds = new kendo.data.DataSource({
                transport: options.transport,
                batch: options.batch,
                pageSize: options.pageSize,
                schema: options.schema
                , requestStart: function (e) {
                    kendo.ui.progress($("#kendoPopupNotification"), true);
                }
                , requestEnd: function (e) {
                    var response = e.response;
                    var type = e.type;
                    kendo.ui.progress($("#kendoPopupNotification"), false);
                    if (response.AjaxError != "0")//Error Exception
                    {                       
                        var kendoPopupNotification = $("#kendoPopupNotification").kendoNotification({
                            position: {
                                top: 0,
                                rigth:0
                            }
                        }).data("kendoNotification");
                       
                        kendoPopupNotification.show(response.Message, "error");
                    }
                    
                }
            });
        }
        else {
            _ds = new kendo.data.DataSource({
                transport: options.transport,
                batch: options.batch,               
                schema: options.schema
            });
        }


        return _ds;
    }

    return this.setDataSource();

});

