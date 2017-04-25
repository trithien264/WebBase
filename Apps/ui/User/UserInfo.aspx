<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true" CodeFile="UserInfo.aspx.cs" Inherits="Apps_User_UserInfo" %>

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
                .when('/registersuccess', {
                    controller: 'RegisterSuccessCtrl',
                    templateUrl: 'template/RegisterSuccessModal.html',
                    /*resolve: {
                        "check": function ( $location) {   //function to be resolved, accessFac and $location Injected
                            debugger
                            $location.path('/registersuccess');                           
                        }
                    }*/
                })
                .when('/activeusers/regcode/:reg_code', {
                    redirectTo: function (routeParams, path, search) {                       
                        return "/activeuserssuccess/" + search.email + "?regcode=" + routeParams.reg_code;
                    }                    
                })
                .when('/activeuserssuccess/:email', {
                    controller: 'ActiveUserSuccessCtrl',
                    templateUrl: 'template/ActiveUserSucessModal.html'
                })
                .when('/loginuser', {
                    controller: 'LoginUserCtrl',
                    templateUrl: 'template/LoginUserModal.html'
                })
                .when('/loginuser/:email', {
                     controller: 'LoginUserCtrl',
                     templateUrl: 'template/LoginUserModal.html'
                 })
                .when('/registeruser', {
                    controller: 'RegisterUserCtrl',
                    templateUrl: 'template/RegisterUsersModal.html'
                })
                 .when('/regrecoverypwd', {
                     controller: 'RegisterRecoveryPwdCtrl',
                     templateUrl: 'template/RegisterRecoveryPasswordModal.html'
                 })
                 .when('/regrecoverysuccesspwd/:email', {
                     controller: 'RegisterRecoverySuccessPwdCtrl',
                     templateUrl: 'template/RegSuccessRecoveryPasswordModal.html'
                 })
                 .when('/activerecoverypwd/regcode/:reg_code', {
                     controller: 'ActiveRecoveryPwdCtrl',
                     templateUrl: 'template/ActiveRecoveryPasswordModal.html'
                 })
                .when('/completerecoverypwd', {
                    controller: 'CompleteRecoveryPwdSuccessCtrl',
                    templateUrl: 'template/CompleteSuccessRecoveryPassword.html'
                })
                .when('/', {
                    controller: 'LoginUserCtrl',
                    templateUrl: 'template/LoginUserModal.html'
                });
           
               
                    
                /*.when('/activeusersuccess/regcode/:reg_code',  {
                    templateUrl: function (params) {
                        return 'pages/books/' + params.bookId + '.html';
                    }
                })*/
                


        };

        app.factory('SharedService', SharedService);
        function SharedService($rootScope) {
            return {
                entity: {}
            }
        }

        var change_activecode = "<span class='glyphicon glyphicon-refresh' style='font-size: 14px; padding-bottom: 10px; color: red'>Refesh</span>";
        //register user page
        app.controller('RegisterUserCtrl', function ($scope, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants, SharedService) {
            
            $('#textCaptChar').realperson({ regenerate: change_activecode });

            $scope.register = function (answer, entity) {
                if (!entity) entity = {};
                entity.textCaptChar = $('#textCaptChar').val();
                entity.textCaptCharHash = $('#textCaptCharHash').val();

                var callService = NgJs.callService({
                    url: "Apps.ui.Apps.User.Users.RegisterUsers",
                    params: [entity],
                    http: $http,
                    toastr: toastr,
                    toastrConfig: toastrConfig,
                    cfpLoadingBar: cfpLoadingBar,
                    scope: $scope
                }).then(function (res) {
                    
                    if (res && res.data && res.data.Result)
                    {                        
                        $scope.SharedService = SharedService;
                        $scope.SharedService.entity = $scope.entity;
                        $location.path('/registersuccess');
                    }
                    
                });
            };

        });

        //register success page
        app.controller('RegisterSuccessCtrl', function ($scope, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants, SharedService) {
            
            $scope.SharedService = SharedService;
            $scope.email = $scope.SharedService.entity.email;

        });

        //active user page
        app.controller('ActiveUserSuccessCtrl', function ($scope,$routeParams, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants) {         
            
            entity = {};
            entity.email = $routeParams.email;
            entity.reg_code = $routeParams.regcode;
            var callService = NgJs.callService({
                url: "Apps.ui.Apps.User.Users.ActiveUser",
                params: [entity],
                http: $http,
                toastr: toastr,
                toastrConfig: toastrConfig,
                cfpLoadingBar: cfpLoadingBar,
                scope: $scope
            }).then(function (res) {
                if (res && res.data && res.data.Result) {
                    $scope.SharedService = SharedService;
                    $scope.SharedService.entity = $scope.entity;
                    

                    $location.path('/activeuserssuccess/' + entity.email);
                }

            });


            //only pass email to login page
            $scope.register = function (answer, entity) {
                if(answer=="loginback")
                {                    
                    $location.path('/loginuser/' + $routeParams.email);
                }
            }   
        });

        //login user page
        app.controller('LoginUserCtrl', function ($scope, $routeParams, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants) {
            
            //Remember Login
            var callService = NgJs.callService({
                url: "Apps.ui.Apps.User.Users.RememerUserInfo",
                params: [{}],
                http: $http,
                toastr: toastr,
                toastrConfig: toastrConfig,
                cfpLoadingBar: cfpLoadingBar,
                scope: $scope
            }).then(function (res) {                
                if (res && res.data && res.data.Result) { 
                    if (res.data.Result.autologin == "true")
                        window.location.href = '<%= ResolveClientUrl("~/")%>Apps/Manage/IndexNg.aspx'
                    else if (res.data.Result.isrememberpwd == "true")
                        $scope.entity = res.data.Result;
                }
            });

            $scope.changePwd = function (answer, entity) {
                if (!entity) entity = {};
                //user tu nhap vao pwd
                $scope.entity.autologin = "false";
            };


            //only email to login page
            $scope.register = function (answer, entity) {
                if (!entity) entity = {};            

                var callService = NgJs.callService({
                    url: "Apps.ui.Apps.User.Users.LoginUser",
                    params: [entity],
                    http: $http,
                    toastr: toastr,
                    toastrConfig: toastrConfig,
                    cfpLoadingBar: cfpLoadingBar,
                    scope: $scope
                }).then(function (res) {
                    if (res && res.data && res.data.Result) {                      
                        //$location.path('/homepage');
                        window.location.href = '<%= ResolveClientUrl("~/")%>Apps/Manage/IndexNg.aspx'
                    }

                });
            };
        });


        //Recovery
        app.controller('RegisterRecoveryPwdCtrl', function ($scope, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants, SharedService) {
            
            $('#textCaptChar').realperson({ regenerate: change_activecode });

            $scope.register = function (answer, entity) {
                if (!entity) entity = {};
                entity.textCaptChar = $('#textCaptChar').val();
                entity.textCaptCharHash = $('#textCaptCharHash').val();

                var callService = NgJs.callService({
                    url: "Apps.ui.Apps.User.Users.RegisterRecoveryPwd",
                    params: [entity],
                    http: $http,
                    toastr: toastr,
                    toastrConfig: toastrConfig,
                    cfpLoadingBar: cfpLoadingBar,
                    scope: $scope
                }).then(function (res) {
                    if (res && res.data && res.data.Result) {
                        $scope.SharedService = SharedService;
                        $scope.SharedService.entity = $scope.entity;
                        
                        $location.path('/regrecoverysuccesspwd/' + entity.email);
                    }
                });
            };

        });

        

        app.controller('RegisterRecoverySuccessPwdCtrl', function ($scope, $routeParams, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants) {
            var entity = {};            
            entity.email = $routeParams.email;

            $scope.entity = entity;

        });

        app.controller('CompleteRecoveryPwdSuccessCtrl', function ($scope, $routeParams, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants) {
            

        });
        app.controller('ActiveRecoveryPwdCtrl', function ($scope, $routeParams, $location, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants, SharedService) {

            $('#textCaptChar').realperson({ regenerate: change_activecode });

            $scope.register = function (answer, entity) {                

                if (!entity) entity = {};
                entity.textCaptChar = $('#textCaptChar').val();
                entity.textCaptCharHash = $('#textCaptCharHash').val();
                entity.email = $routeParams.email;
                entity.reg_code = $routeParams.reg_code;

                if(entity.pwd != entity.repwd)
                {                    
                    toastr["error"]("Mật khẩu nhập lại không trùng khớp mật khẩu mới !!!", "Error Notification!!!");
                    return null;
                }
                    
                

                var callService = NgJs.callService({
                    url: "Apps.ui.Apps.User.Users.ActiveRecoveryPwd",
                    params: [entity],
                    http: $http,
                    toastr: toastr,
                    toastrConfig: toastrConfig,
                    cfpLoadingBar: cfpLoadingBar,
                    scope: $scope
                }).then(function (res) {                    
                    if (res && res.data && res.data.Result) {
                        $scope.SharedService = SharedService;
                        $scope.SharedService.entity = $scope.entity;
                        $location.path('/completerecoverypwd');
                    }
                });
            };

        });


    </script>

</asp:Content>

