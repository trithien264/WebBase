<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true" CodeFile="RightsMenu.aspx.cs" Inherits="ngManager_Rights_RightsMenu_RightsMenuUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--http://www.jqueryrain.com/?_nwM_3Ln--%>
  
    <link rel="stylesheet" href="<%= ResolveClientUrl("~/")%>Pub/libAngular/treeview/abn_tree_directive/abn_tree.css">
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Control/NgGrid.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Config.js" type="text/javascript"></script>
    <%--    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/treeview/abn_tree_directive/test_page.js"></script>--%>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/treeview/abn_tree_directive.js"></script>


    <link href="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-material.css" rel="stylesheet" />
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-route.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-aria.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-messages.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-material.js"></script>


    <div ng-controller="MainPageCtrl">    
        <table width="100%" border="0">
            <tr>
                <td style="vertical-align: top; width: 10%">
                    <div style="width: 250px; background: whitesmoke; border: 1px solid lightgray; border-radius: 5px;">
                        <abn-tree tree-data="my_data" tree-control="my_tree" on-select="my_tree_handler(branch)" expand-level="0"></abn-tree>
                    </div>
                </td>
                <td style="padding: 20px; vertical-align: top;">
                    <button type="button" class="btn-primary" ng-click="fnAddnew()" ng-show="fnAddRights"><n-lang>ADD</n-lang></button>     
                 
                    <div ui-grid="ngGridMenu" ui-grid-pagination class="grid" style="width:100%" >
                </td>
            </tr>
        </table>
    </div>


    <script>

        app = angular.module('ngMasterAg', ['ngAnimate', 'angularBootstrapNavTree', 'toastr', 'chieffancypants.loadingBar', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ngMaterial', 'ui.grid.selection']);
        NgJs.Language.onLoad(app, '<%= ResolveClientUrl("~/")%>');

        app.controller('MainPageCtrl', function ($scope, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, $mdDialog, uiGridConstants) {
            $scope.my_tree = tree = {};

            var optionsGrid = {
                gridId: "ngGridMenu",
                url: "Apps.Manage.Base.Rights.RightsMenu.GetUserRights",
                params: [{}],
                http: $http,
                toastr: toastr,
                toastrConfig: toastrConfig,
                cfpLoadingBar: cfpLoadingBar,
                scope: $scope,
                columnDefs: [
                      {
                          name: 'Delete',
                          headerCellTemplate: "<n-lang>DELETE</n-lang>",
                          width: '70',                          
                          //cellTemplate: '<input type="button" ng-click="grid.appScope.Delete(row)" value="Delete">'
                          cellTemplate: '<div style="text-align: center; vertical-align: bottom"><span  class="glyphicon glyphicon-trash" ng-click="grid.appScope.Delete(row)" style="cursor: pointer"></span></div>'
                      },
                      { name: 'user_id', headerCellTemplate: "<n-lang>USER_ID</n-lang>" },
                      { name: 'email', headerCellTemplate: "<n-lang>EMAIL</n-lang>" },
                      { name: 'user_desc', headerCellTemplate: "<n-lang code='USER_DESC'>USER_DESC</n-lang>" },
                      { name: 'menu_nm', headerCellTemplate: "<n-lang>RIGHT_MENU</n-lang>" }
                ]
            }

            fnClearGirdRights = function () {
                $scope[optionsGrid.gridId] = {                 
                    columnDefs: optionsGrid.columnDefs
                }

                $scope[optionsGrid.gridId].data = [];
                $scope[optionsGrid.gridId].data.length = 0;
                $scope.fnAddRights = false;
            }
            //No Load Default
            fnClearGirdRights();

            $scope.Delete = function (row) {
                //debugger
                //var index = $scope.gridOptions.data.indexOf(row.entity);
                //$scope.gridOptions.data.splice(index, 1);

                var info = row.entity;                
                var callService = NgJs.callService({
                    url: "Apps.Manage.Base.Rights.RightsMenu.DeleteMenuRights",
                    params: [info],
                    http: $http,
                    toastr: toastr,
                    toastrConfig: toastrConfig,
                    cfpLoadingBar: cfpLoadingBar,
                    scope: $scope
                }).then(function (data) {

                    NgJs.grid(optionsGrid);
                    //$scope.list = [JSON.parse(data.data.Result)];
                });
            };

            


            var callService = NgJs.callService({
                url: "Apps.Manage.Base.Rights.RightsMenu.treeJSONMenuRights",
                params: [{}],
                http: $http,
                toastr: toastr,
                toastrConfig: toastrConfig,
                cfpLoadingBar: cfpLoadingBar,
                scope: $scope
            }).then(function (data) {
                LoadTree(data);
            });


            var LoadTree = function (data) {
                var tree;
                //treeview click event
                $scope.my_tree_handler = function (branch) {
                    if (branch.rights_mk == "Y")
                    {
                        $scope.fnAddRights = true;
                        $scope.tree_menu_id = branch.menu_id;
                        optionsGrid.params = [{ menu_id: branch.menu_id }];
                        NgJs.grid(optionsGrid);
                    }
                    else
                    {
                        fnClearGirdRights();
                    }
                };



                //debugger
                $scope.my_data = [JSON.parse(data.data.Result)];
                $scope.my_tree.expand_all();
                $scope.my_tree.select_first_branch()
                //$scope.my_data = treedata_avm; 

            }
            $scope.my_data = [];

            //Add New
            $scope.fnAddnew = function () {
                //alert($scope.tree_menu_id);

                if (!$scope.tree_menu_id) {
                    alert("Please, choose node!!!")
                    return;
                }
                dataModel = {};
                dataModel.menu_id = $scope.tree_menu_id;
                dataModel._typeDialog = "addnew";


                $mdDialog.show({
                    locals: { dataToPass: dataModel, http: $http, toastr: toastr, toastrConfig: toastrConfig, cfpLoadingBar: cfpLoadingBar },
                    controller: DialogController,//($scope, dataModel, $mdDialog, $http, toastr, toastrConfig, cfpLoadingBar),
                    controllerAs: 'manageMenu',
                    templateUrl: 'RightsMenu/AddRightsMenuUser.aspx',
                    parent: angular.element(document.body),
                    //targetEvent: ev,
                    //clickOutsideToClose: true,
                    //scope: $scope
                    fullscreen: true // Only for -xs, -sm breakpoints.
                }).then(function (answer, obj) {
                    if (answer == "save") {
                        NgJs.grid(optionsGrid);
                    }
                    else if (answer == "close") {
                        NgJs.grid(optionsGrid);
                    }

                }, function () {
                    NgJs.grid(optionsGrid);
                    //$scope.status = 'You cancelled the dialog.';
                });
            }


        });

        function DialogController($scope, $mdDialog, dataToPass, http, toastr, toastrConfig, cfpLoadingBar) {
            $scope.tree_menu_id = dataToPass.menu_id;

            var infoAddgrid = {};
            infoAddgrid.menu_id = dataToPass.menu_id
            
            var optionsGrid = {
                gridId: "ngGridMenuRights",
                url: "Apps.Manage.Base.Rights.RightsMenu.GetListUserRights",
                params: [infoAddgrid],
                http: http,
                toastr: toastr,
                toastrConfig: toastrConfig,
                cfpLoadingBar: cfpLoadingBar,
                scope: $scope,
                enableRowSelection: true,
                enableSelectAll: true,
                multiSelect: true,
                columnDefs: [
                      { name: 'user_id', headerCellTemplate: "<n-lang>USER_ID</n-lang>" },
                      { name: 'email', headerCellTemplate: "<n-lang>EMAIL</n-lang>" },
                      { name: 'user_desc', headerCellTemplate: "<n-lang code='USER_DESC'>USER_DESC</n-lang>" }
                ]
            }




            if (dataToPass._typeDialog == "addnew") {
                (function () {
                    NgJs.grid(optionsGrid);

                }.call(this))
            }


            /* $scope.hide = function () {
                 $mdDialog.hide();
             };
             */



            /*$scope.ngGridMenuRights.onRegisterApi = function (gridApi) {
                debugger
                $scope.gridApi = gridApi;
                $scope.mySelectedRows = $scope.gridApi.selection.getSelectedRows();
            }*/

            $scope.cancel = function () {
                $mdDialog.cancel();
            };

            $scope[optionsGrid.gridId].onRegisterApi = function (gridApi) {
                //set gridApi on scope
                $scope.gridApi = gridApi;
                $scope.selectedGridMenuRights = [];

                gridApi.selection.on.rowSelectionChanged($scope, function (row) {

                    //Save Rights
                    var info = row.entity;
                    info.isSelected = row.isSelected;
                    info.menu_id = $scope.tree_menu_id;

                    var callService = NgJs.callService({
                        url: "Apps.Manage.Base.Rights.RightsMenu.SaveMenuRights",
                        params: [info],
                        http: http,
                        toastr: toastr,
                        toastrConfig: toastrConfig,
                        cfpLoadingBar: cfpLoadingBar,
                        scope: $scope
                    });

                    callService.then(function (data) {
                        //$scope.list = [JSON.parse(data.data.Result)];
                    });

                    //$scope.selectedGridMenuRights.push(row.entity);
                });



                /*gridApi.selection.on.rowSelectionChangedBatch($scope, function (rows) {                   
                    $scope.selectedGridMenuRights.push(row.entity);
                });*/

            }





            $scope.answer = function (answer, obj) {

                // debugger

                var a = $scope.selectedGridMenuRights;
                //var currentSelection = $scope.ngGridMenuRights.isRowSelectable();
                //debugger
                if (answer == "close") {
                    $mdDialog.hide(answer);
                    return;
                }
                else if (answer == "search") {
                    optionsGrid.params = [obj]
                    NgJs.grid(optionsGrid);
                }




            };

        }

    </script>
</asp:Content>

