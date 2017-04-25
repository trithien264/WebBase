<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="ngManager_Menu_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Control/NgGrid.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Config.js" type="text/javascript"></script>
    <div ng-controller="MainPageCtrl">
    </div>
    <script>

        var optionsPage = {
            ctrlId: "MainPageCtrl",
            gridId: "ngGridMenu",
            url: "WebBase.Base.Menu.treeJSONMenu",
            params: [{}]
        }

        appMaster.controller(optionsPage.ctrlId, function ($scope, $http, toastr, toastrConfig, cfpLoadingBar) {

            getData = function () {
                var callService = NgJs.callService({
                    url: optionsPage.url,
                    params: optionsPage.params,
                    http: $http,
                    toastr: toastr,
                    toastrConfig: toastrConfig,
                    cfpLoadingBar: cfpLoadingBar,
                    scope: $scope
                });

                callService.then(function (data) {
                    document.write(data.data.Result)
                });
            }

            getData();

        });





    </script>
</asp:Content>
