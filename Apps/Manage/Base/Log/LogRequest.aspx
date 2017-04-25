<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true" CodeFile="LogRequest.aspx.cs" Inherits="Apps_Manage_Base_Log_LogRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Control/NgGrid.js"></script>
    <style>
        .modal .modal-dialog { width: 70%; }
    </style>
    <div ng-controller="MainPageCtrl">
        <table>
            <tr>
                <td>                   
                    <div ui-grid="ngGridLog" ui-grid-expandable ui-grid-pagination class="grid" style="width: 1000px">
                </td>
            </tr>
        </table>
     <script>

         app = angular.module('ngMasterAg', ['ngAnimate','ui.grid.expandable', 'ui.bootstrap', 'toastr', 'chieffancypants.loadingBar', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.selection']);
         NgJs.Language.onLoad(app, '<%= ResolveClientUrl("~/")%>');
         app.controller('MainPageCtrl', function ($scope, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants) {
             var optionsGrid = {
                 gridId: "ngGridLog",
                 url: "Apps.Manage.Base.Log.LogRequest.getLogRequest",
                 params: [{}],
                 http: $http,
                 toastr: toastr,
                 toastrConfig: toastrConfig,
                 cfpLoadingBar: cfpLoadingBar,
                 scope: $scope,
                 gridOptions: {                         
                         columnDefs: [
                           { name: 'RequestID', headerCellTemplate: "<n-lang>RequestID</n-lang>" },
                           { name: 'LogTime', headerCellTemplate: "<n-lang>LogTime</n-lang>" },
                           { name: 'LogType', headerCellTemplate: "<n-lang>LogType</n-lang>" },
                           { name: 'RequestIP', headerCellTemplate: "<n-lang>RequestIP</n-lang>" },
                           { name: 'UserID', headerCellTemplate: "<n-lang>UserID</n-lang>" },
                           { name: 'RefUrl', headerCellTemplate: "<n-lang>RefUrl</n-lang>" },
                           { name: 'InputStream', headerCellTemplate: "<n-lang>InputStream</n-lang>" },
                           { name: 'UserID', headerCellTemplate: "<n-lang>UserID</n-lang>" },
                         ],
                         expandableRowTemplate: '<div ui-grid="row.entity.ngGridLogDetail"  ></div>',
                         expandableRowHeight: 300,
                         onRegisterApi: function (gridApi) {
                             gridApi.expandable.on.rowExpandedStateChanged($scope, function (row) {
                                 //Expand Fact Event
                                 if (row.isExpanded) {
                                     
                                     var optionsGridDetail = {
                                         gridId: "ngGridLogDetail",
                                         gridObject: row,
                                         url: "Apps.Manage.Base.Log.LogRequest.getLogRequest",
                                         params: [{}],
                                         http: $http,
                                         toastr: toastr,
                                         toastrConfig: toastrConfig,
                                         cfpLoadingBar: cfpLoadingBar,
                                         scope: $scope,
                                         gridOptions: {
                                             columnDefs: [
                                               { name: 'RequestID', headerCellTemplate: "<n-lang>RequestID</n-lang>" },
                                               { name: 'LogTime', headerCellTemplate: "<n-lang>LogTime</n-lang>" },
                                               { name: 'LogType', headerCellTemplate: "<n-lang>LogType</n-lang>" },
                                               { name: 'RequestIP', headerCellTemplate: "<n-lang>RequestIP</n-lang>" },
                                               { name: 'UserID', headerCellTemplate: "<n-lang>UserID</n-lang>" },
                                               { name: 'RefUrl', headerCellTemplate: "<n-lang>RefUrl</n-lang>" },
                                               { name: 'InputStream', headerCellTemplate: "<n-lang>InputStream</n-lang>" },
                                               { name: 'UserID', headerCellTemplate: "<n-lang>UserID</n-lang>" },
                                             ]
                                         }
                                     }
                                     NgJs.grid(optionsGridDetail);

                                 }
                             })
                         }
                 }
             }

             NgJs.grid(optionsGrid);
         });
    </script>
</asp:Content>

