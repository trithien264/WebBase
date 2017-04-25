<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true" CodeFile="UserInfo.aspx.cs" Inherits="Apps_Manage_Base_User_UserInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .form-group .control-label {
            padding-top: 7px;
        }
        .auto-style1 {
            color: #FF0000;
        }
    </style>
    <div class="container">
        <div ng-view=""></div>
       
    </div>


    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angularjs/angular-route.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angularjs/angular-cookies.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libJquery/Jquery/jquery.plugin.js"></script>    <link rel="stylesheet" href="<%= ResolveClientUrl("~/")%>Pub/libJquery/Captchar/jquery.realperson.css">
    <script src="<%= ResolveClientUrl("~/")%>Pub/libJquery/Captchar/jquery.realperson.js"></script>
   

    <script>

        app = angular
            .module('ngMasterAg', ['ngRoute',  'ngCookies', 'ngAnimate', 'ui.bootstrap', 'toastr', 'chieffancypants.loadingBar', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.selection'])
            .config(configRoot);
        NgJs.Language.onLoad(app, '<%= ResolveClientUrl("~/")%>');

        configRoot.$inject = ['$routeProvider', '$locationProvider'];
        function configRoot($routeProvider, $locationProvider) {

            $locationProvider.html5Mode({ enabled: false, requireBase: false });
            $routeProvider   
                .when('/', {
                    controller: 'ManageUserCtrl',
                    templateUrl: 'template/ManageUserModal.html'
                });
        };

        app.factory('SharedService', SharedService);
        function SharedService($rootScope) {
            return {
                entity: {}
            }
        }
                
 
        //login user page
        app.controller('ManageUserCtrl', function ($scope, $routeParams, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants) {
             
            NgJs.callService({
                url: "Apps.Manage.Base.User.UserInfo.GetUsers",
                params: [{}],
                http: $http,
                toastr: toastr,
                toastrConfig: toastrConfig,
                cfpLoadingBar: cfpLoadingBar,
                scope: $scope
            }).then(function (res) {                
                if (res && res.data && res.data.Result) {                    
                        $scope.entity = res.data.Result[0];
                }
            });         


            $scope.Save = function (answer, entity) {
                
                entity = $scope.entity;
                if (!entity) entity = {};                
               
                NgJs.callService({
                    url: "Apps.Manage.Base.User.UserInfo.updateUser",
                    params: [entity],
                    http: $http,
                    toastr: toastr,
                    toastrConfig: toastrConfig,
                    cfpLoadingBar: cfpLoadingBar,
                    scope: $scope
                }).then(function (res) {                    
                    if (res && res.data && res.data.Result && res.data.Result=="ok") {
                        toastr["info"]("Save successfull!!!", "Notification!!!");
                    }

                });
            };
        });


     

    </script>

</asp:Content>

