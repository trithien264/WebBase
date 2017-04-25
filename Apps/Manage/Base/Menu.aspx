<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true"
    CodeFile="Menu.aspx.cs" Inherits="ngManager_Menu_MenuInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <link rel="stylesheet" href="http://khan4019.github.io/tree-grid-directive/src/treeGrid.css">
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/treeview/tree-grid-directive.js"></script>

    <link href="<%= ResolveClientUrl("~/")%>Pub/libAngular/contextMenu/styles.css" rel="stylesheet" />
    <%--<script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/contextMenu/app.js"></script>--%>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/contextMenu/contextMenu.js"></script>
    <style>
        @charset "UTF-8";

        table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
            border-spacing: 0;
        }

        .table-nested {
            background: #fff;
            border: 2px solid #444;
            text-align: left;
        }

            .table-nested th {
                background-color: aqua;
            }

            .table-nested th, .table-nested td {
                padding: 0;
            }

                .table-nested th + th, .table-nested th + td, .table-nested td + th, .table-nested td + td {
                    padding-left: 5px;
                }

            .table-nested td {
                border-top: 1px solid;
            }

                .table-nested td[colspan] {
                    border: none;
                }

            .table-nested .cell-input {
                width: 20px;
                border-right: 1px solid;
            }

            .table-nested .cell-members {
                width: 100px;
            }

            .table-nested .indent {
                display: inline-block;
            }

            .table-nested .parent > .cell-name {
                cursor: pointer;
            }

                .table-nested .parent > .cell-name > .indent {
                    margin-right: 5px;
                }

                    .table-nested .parent > .cell-name > .indent:before {
                        /*content: "";*/
                        content: "+";
                        font-family: FontAwesome;
                        display: inline-block;
                        -moz-transition: -moz-transform 0.3s;
                        -o-transition: -o-transform 0.3s;
                        -webkit-transition: -webkit-transform 0.3s;
                        transition: transform 0.3s;
                    }

            .table-nested .children {
                display: none;
            }

            .table-nested .opened > tr > .cell-name > .indent:before {
                /*-moz-transform: rotate(90deg);
                -ms-transform: rotate(90deg);
                -webkit-transform: rotate(90deg);
                transform: rotate(90deg);*/
                content: "-";
                font-family: FontAwesome;
                display: inline-block;
                -moz-transition: -moz-transform 0.3s;
                -o-transition: -o-transform 0.3s;
                -webkit-transition: -webkit-transform 0.3s;
                transition: transform 0.3s;
            }

            .table-nested .opened > .children {
                display: table-row;
            }
    </style>
    <link href="<%= ResolveClientUrl("~/")%>Pub/libAngular/contextMenu/styles.css" rel="stylesheet" />

    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/contextMenu/contextMenu.js"></script>
    <div class="wrapper" ng-controller="MainPageCtrl">
        <table class="table table-bordered" style="width:auto">
            <tr>
                 <th><n-lang>GROUP_TYPE</n-lang>: </th><td><input id="txtgroup_type"  type="text" ng-model="model.group_type" /></td>
                <td>
                <button type="button" ng-click="Search()" class="btn-primary"><n-lang>SEARCH</n-lang></button>               
        </td>
            </tr>
        </table>

        <table class="table-nested">
            <thead>
                <tr>
                    <th><n-lang>MENU_NAME</n-lang></th>
                    <th><n-lang>LINK_MENU</n-lang></th>
                    <th><n-lang>LINK_KIND</n-lang></th>
                    <th><n-lang>DISABLED</n-lang></th>
                    <th class="cell-members"><n-lang>CHILD_COUNT</n-lang></th>

                </tr>
            </thead>
            <tbody ng-class="{opened: item.opened}" ng-include="&#39;table_tree.html&#39;" ng-repeat="item in list"></tbody>
        </table>
        <script id="table_tree.html" type="text/ng-template">
    <tr ng-class="{parent: item.children}" ng-init="parentScope = $parent.$parent; initCheckbox(item, parentScope.item)" context-menu="menuOptions" >
      
      <td class="cell-name" ng-click="item.opened = !item.opened" >
        <div class="indent" style="padding-left: {{15*level}}px"></div>
        {{item.menu_name}}
      </td>
      <td>
        {{item.link}}
      </td>
       <td>
        {{item.link_kind}}
      </td>
       <td>
        {{item.stop_mk}}
      </td>
      <td class="cell-members">
        {{item.children.length}}
      </td>
      
    </tr>
    <tr class="children" ng-if="item.children &amp;&amp; item.children.length &gt; 0">
      <td colspan="5">
        <table>
          <tbody ng-class="{opened: item.opened}" ng-include="&#39;table_tree.html&#39;" ng-init="level = level + 1" ng-repeat="item in item.children"></tbody>
        </table>
      </td>
    </tr>
        </script>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true" class="">×   </span><span class="sr-only">Close</span>

                    </button>
                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>

                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <link href="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-material.css" rel="stylesheet" />
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-route.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-aria.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-messages.min.js"></script>
    <script src="<%= ResolveClientUrl("~/")%>Pub/libAngular/angular-material/angular-material.js"></script>
    <script>
        (function () {
            var app, list;

            app = angular.module('ngMasterAg', ['ui.bootstrap.contextMenu', 'toastr', 'chieffancypants.loadingBar', 'ngAnimate', 'ngMaterial']);
            NgJs.Language.onLoad(app, '<%= ResolveClientUrl("~/")%>');

            app.controller('MainPageCtrl',

                function ($scope, $filter, $http, toastr, toastrConfig, cfpLoadingBar, $mdDialog) {
                    model = {};
                    model.group_type = "M";
                    model.icon = "glyphicon glyphicon-file";
                  
                    $scope.model = model;

                    BindTree = function () {

                        entity = $scope.model;
                        if (!entity) entity = {};                       
                       
                       NgJs.callService({
                            url: "Apps.Manage.Base.Menu.treeJSONMenu",
                            params: [entity],
                            http: $http,
                            toastr: toastr,
                            toastrConfig: toastrConfig,
                            cfpLoadingBar: cfpLoadingBar,
                            scope: $scope
                        }).then(function (data) {
                            jmenu = data.data.Result;
                            if (jmenu == "")
                                jmenu = {};
                            else
                                jmenu = JSON.parse(data.data.Result);
                            $scope.list = [jmenu];
                        });
                    }

                    $scope.Search = function () {
                        BindTree();
                    }
                    

                    $scope.menuOptions = [
                        ['New', function ($itemScope, ev) {
                            
                            dataModel = $itemScope.item;
                            dataModel.group_type = $scope.model.group_type;                           
                            
                            dataModel._typeDialog = "new";
                            $mdDialog.show({
                                locals: { dataToPass: dataModel, http: $http, toastr: toastr, toastrConfig: toastrConfig, cfpLoadingBar: cfpLoadingBar },
                                controller: DialogController,//($scope, dataModel, $mdDialog, $http, toastr, toastrConfig, cfpLoadingBar),
                                controllerAs: 'manageMenu',
                                templateUrl: 'Menu/MenuInfo/EditMenu.aspx',
                                parent: angular.element(document.body),
                                targetEvent: ev,
                                //clickOutsideToClose: true,
                                //scope: $scope
                                fullscreen: true // Only for -xs, -sm breakpoints.
                            })
                            .then(function (answer, obj) {
                                if (answer == "save") {
                                    BindTree();

                                    //$scope.status = 'You said the information was "' + answer + '".';
                                    //debugger
                                }
                                //$scope.status = 'You said the information was "' + answer + '".';
                            }, function () {
                                //$scope.status = 'You cancelled the dialog.';
                            });


                        }]
                       , ['Modify', function ($itemScope, ev) {                           
                           dataModel = $itemScope.item;
                           if (dataModel.parentId == "-1")
                           {
                               toastr["error"]("Not Edit ROOT!!!", "Error Notification!!!");
                               return;
                           }
                           dataModel._typeDialog = "modify";

                           $mdDialog.show({
                               locals: { dataToPass: dataModel, http: $http, toastr: toastr, toastrConfig: toastrConfig, cfpLoadingBar: cfpLoadingBar },
                               controller: DialogController,//($scope, dataModel, $mdDialog, $http, toastr, toastrConfig, cfpLoadingBar),
                               controllerAs: 'manageMenu',
                               templateUrl: 'Menu/MenuInfo/EditMenu.aspx',
                               parent: angular.element(document.body),
                               targetEvent: ev
                               //clickOutsideToClose: true,
                               //scope: $scope
                               //fullscreen: $scope.customFullscreen // Only for -xs, -sm breakpoints.
                           })
                           .then(function (answer, obj) {
                               if (answer == "save") {                                   
                                   BindTree();

                                   //$scope.status = 'You said the information was "' + answer + '".';
                                   //debugger
                               }
                               //$scope.status = 'You said the information was "' + answer + '".';
                           }, function () {
                               //$scope.status = 'You cancelled the dialog.';
                           });
                       }]
                       , ['Delete', function ($itemScope, ev) {
                           dataModel = $itemScope.item;
                           if (dataModel.parentId == "-1") {
                               toastr["error"]("Not Delete ROOT!!!", "Error Notification!!!");
                               return;
                           }

                           dataModel._typeDialog = "delete";
                           var confirm = $mdDialog.confirm()
                          .title('Infomation!!!')
                          .textContent('Delete???')
                          .targetEvent(ev)
                          .ok('OK')
                          .cancel('Cancel');

                           $mdDialog.show(confirm).then(function () {
                               (function () {
                                   var callService = NgJs.callService({
                                       url: "Apps.Manage.Base.Menu.deleteMenu",
                                       params: [{ "menu_id": dataModel.menu_id }],
                                       http: $http,
                                       toastr: toastr,
                                       toastrConfig: toastrConfig,
                                       cfpLoadingBar: cfpLoadingBar,
                                       scope: $scope
                                   }).then(function (data) {
                                       BindTree();
                                   });



                               }())
                           }, function () {
                               //debugger
                               //$scope.status = 'You decided to keep your debt.';
                           })
                           .then(function (answer, obj) {
                               if (answer == "save") {
                                   (function () {
                                       var callService = NgJs.callService({
                                           url: "Apps.Manage.Base.Menu.treeJSONMenu",
                                           params: [{}],
                                           http: $http,
                                           toastr: toastr,
                                           toastrConfig: toastrConfig,
                                           cfpLoadingBar: cfpLoadingBar,
                                           scope: $scope
                                       });

                                       callService.then(function (data) {
                                           $scope.list = [JSON.parse(data.data.Result)];
                                       });
                                   }())

                                   //$scope.status = 'You said the information was "' + answer + '".';
                                   //debugger
                               }
                               //$scope.status = 'You said the information was "' + answer + '".';
                           }, function () {
                               //$scope.status = 'You cancelled the dialog.';
                           });


                       }]

                    ];

                    BindTree();

                    //Load treeview
                    /*(function () {
                        var callService = NgJs.callService({
                            url: "Apps.Manage.Base.Menu.treeJSONMenu",
                            params: [{}],
                            http: $http,
                            toastr: toastr,
                            toastrConfig: toastrConfig,
                            cfpLoadingBar: cfpLoadingBar,
                            scope: $scope
                        });

                        callService.then(function (data) {
                            $scope.list = [JSON.parse(data.data.Result)];
                        });
                    }())*/


                    $scope.toggleAllCheckboxes = function ($event) {
                        var i, item, len, ref, results, selected;
                        selected = $event.target.checked;
                        ref = $scope.list;
                        results = [];
                        for (i = 0, len = ref.length; i < len; i++) {
                            if (window.CP.shouldStopExecution(1)) {
                                break;
                            }
                            item = ref[i];
                            item.selected = selected;
                            if (item.children != null) {
                                results.push($scope.$broadcast('changeChildren', item));
                            } else {
                                results.push(void 0);
                            }
                        }
                        window.CP.exitedLoop(1);
                        return results;
                    };
                    $scope.initCheckbox = function (item, parentItem) {
                        return item.selected = parentItem && parentItem.selected || item.selected || false;
                    };
                    $scope.toggleCheckbox = function (item, parentScope) {
                        if (item.children != null) {
                            $scope.$broadcast('changeChildren', item);
                        }
                        if (parentScope.item != null) {
                            return $scope.$emit('changeParent', parentScope);
                        }
                    };
                    $scope.$on('changeChildren', function (event, parentItem) {
                        var child, i, len, ref, results;
                        ref = parentItem.children;
                        results = [];
                        for (i = 0, len = ref.length; i < len; i++) {
                            if (window.CP.shouldStopExecution(2)) {
                                break;
                            }
                            child = ref[i];
                            child.selected = parentItem.selected;
                            if (child.children != null) {
                                results.push($scope.$broadcast('changeChildren', child));
                            } else {
                                results.push(void 0);
                            }
                        }
                        window.CP.exitedLoop(2);
                        return results;
                    });
                    return $scope.$on('changeParent', function (event, parentScope) {
                        var children;
                        children = parentScope.item.children;
                        parentScope.item.selected = $filter('selected')(children).length === children.length;
                        parentScope = parentScope.$parent.$parent;
                        if (parentScope.item != null) {
                            return $scope.$broadcast('changeParent', parentScope);
                        }
                    });
                }
            );
            app.filter('selected', [
                '$filter',
                function ($filter) {
                    return function (files) {
                        return $filter('filter')(files, { selected: true });
                    };
                }
            ]);
        }.call(this));

        //function DialogController($scope, dataModel, $mdDialog, $http, toastr, toastrConfig, cfpLoadingBar) {
        function DialogController($scope, $mdDialog, dataToPass, http, toastr, toastrConfig, cfpLoadingBar) {


            if (dataToPass._typeDialog == "modify") {
                (function () {
                    var callService = NgJs.callService({
                        url: "Apps.Manage.Base.Menu.GetMenuByCond",
                        params: [{ "menu_id": dataToPass.menu_id }],
                        http: http,
                        toastr: toastr,
                        toastrConfig: toastrConfig,
                        cfpLoadingBar: cfpLoadingBar,
                        scope: $scope
                    });

                    callService.then(function (data) {
                        if (data && data.data.AjaxError == 0) {
                            $scope.model = data.data.Result.dataMenu[0];
                            $scope.model.dataLindKind = data.data.Result.dataLindKind;
                            $scope.model._typeDialog = dataToPass._typeDialog;
                        }
                    });
                }.call(this))
            }
            else if (dataToPass._typeDialog == "new") {             
                
                (function () {

                    var callService = NgJs.callService({
                        url: "Apps.Manage.Base.Menu.GetMenuByCond",
                        params: [{ "menu_id": "-1" }],
                        http: http,
                        toastr: toastr,
                        toastrConfig: toastrConfig,
                        cfpLoadingBar: cfpLoadingBar,
                        scope: $scope
                    }).then(function (data) {
                        if (data && data.data.AjaxError == 0) {
                            $scope.model = {};
                            $scope.model.dataLindKind = data.data.Result.dataLindKind;
                            $scope.model.up_menu_id = dataToPass.menu_id;
                            $scope.model._typeDialog = dataToPass._typeDialog;
                            $scope.model.group_type = dataToPass.group_type;

                            $scope.model.icon = "glyphicon glyphicon-file";
                        }
                    });
                }.call(this))

            }




            $scope.hide = function () {

                $mdDialog.hide();
            };
            $scope.cancel = function () {

                $mdDialog.cancel();
            };

            $scope.answer = function (answer, obj) {

                if (answer == "close") {
                    $mdDialog.hide(answer);
                    return;
                }


                var url = "";
                if (obj._typeDialog == "new") {
                    url = "Apps.Manage.Base.Menu.insertMenu"
                }
                else {
                    url = "Apps.Manage.Base.Menu.updateMenu";
                }

                obj.stop_mk = "N";
                if (obj.disabled_mk && obj.disabled_mk == true)
                    obj.stop_mk = "Y";
                delete obj.disabled_mk;


                (function () {
                    
                    NgJs.callService({
                        url: url,
                        params: [obj],
                        http: http,
                        toastr: toastr,
                        toastrConfig: toastrConfig,
                        cfpLoadingBar: cfpLoadingBar,
                        scope: $scope
                    }).then(function (data) {
                        $scope.list = [JSON.parse(data.data.Result)];

                        $mdDialog.hide(answer);
                    });
                }())

                

               
            };
        }
        //# sourceURL=pen.js
    </script>

</asp:Content>

