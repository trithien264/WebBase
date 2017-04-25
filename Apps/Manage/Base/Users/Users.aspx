<%@ Page Title="" Language="C#" MasterPageFile="~/ManagerAg.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="ngManager_Users_Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="<%= ResolveClientUrl("~/")%>Pub/jsModule/Angular/Control/NgGrid.js"></script>
    <style>
        .modal .modal-dialog { width: 70%; }
    </style>
    <div ng-controller="MainPageCtrl">
        <table>
            <tr>
                <td>
                    <input type="button" ng-click="newRow()" value="Add Rights" style="display:none">
                    <div ui-grid="ngGridUser" ui-grid-pagination class="grid" style="width: 800px">
                </td>
            </tr>
        </table>
    </div>




    <script>

        app = angular.module('ngMasterAg', ['ngAnimate', 'ui.bootstrap', 'toastr', 'chieffancypants.loadingBar', 'ngTouch', 'ui.grid', 'ui.grid.pagination', 'ui.grid.selection']);
        NgJs.Language.onLoad(app, '<%= ResolveClientUrl("~/")%>');
        app.controller('MainPageCtrl', function ($scope, $modal, $timeout, $http, toastr, toastrConfig, cfpLoadingBar, uiGridConstants) {
            var optionsGrid = {
                gridId: "ngGridUser",
                url: "Apps.Manage.Base.Users.GetUsers",
                params: [{}],
                http: $http,
                toastr: toastr,
                toastrConfig: toastrConfig,
                cfpLoadingBar: cfpLoadingBar,
                scope: $scope,
                columnDefs: [
                      {
                          name: 'h1',
                          displayName: '',
                          cellTemplate: '<%= ResolveClientUrl("~/")%>Apps/Manage/Base/templateControl/editButton.html',
                          width: 60
                      },
                      <%--{
                          name: 'h2',
                          displayName: '',
                          cellTemplate: '<%= ResolveClientUrl("~/")%>Apps/Manage/Base/templateControl/deleteButton.html',
                          width: 70
                      },--%>
                      { name: 'user_id', headerCellTemplate: "<n-lang>USER_ID</n-lang>" },
                      { name: 'email', headerCellTemplate: "<n-lang>EMAIL</n-lang>" },
                      { name: 'user_desc', headerCellTemplate: "<n-lang>USER_DESC</n-lang>" },
                      { name: 'disabled_mk', headerCellTemplate: "<n-lang>STOP_MK</n-lang>" },
                      { name: 'last_login', headerCellTemplate: "<n-lang>LAST_LOGIN</n-lang>" },
                     


                ]
            }

            NgJs.grid(optionsGrid);



            $scope.editRow = function (grid, row) {
                if (!row.entity._typeModal)
                    row.entity._typeModal = "_edit";
                var modalInstance = $modal.open({
                    templateUrl: '../templateControl/editorWindowModal.html',
                    controller: ['$http', '$modalInstance', 'grid', 'row', ModalInstanceCtrl],
                    scope: $scope,
                    backdrop: "static",
                    resolve: {
                        grid: function () {
                            return grid;
                        },
                        row: function () {
                            return row;
                        }
                    }
                });

            }

            $scope.newRow = function () {
                entity = {
                    _typeModal: "_new",
                };
                var row_tmp = {};
                row_tmp.entity = entity;
                $scope.editRow(optionsGrid, row_tmp);
            }


            $scope.deleteRow = function (grid, row) {
                row.entity._typeModal = "_delete";
                var modalInstance = $modal.open({
                    templateUrl: '../templateControl/deleteModal.html',
                    controller: ['$http', '$modalInstance', 'grid', 'row', ModalInstanceCtrl],
                    scope: $scope,
                    backdrop: "static",
                    resolve: {
                        grid: function () {
                            return grid;
                        },
                        row: function () {
                            return row;
                        }
                    }
                });

            }

           

            var ModalInstanceCtrl = function ($http, $modalInstance, grid, row) {
                $scope.entity = angular.copy(row.entity);
                $scope.ok = function (answer, entity) {
                    if (answer == "ok") {
                        if (entity._typeModal == "_edit") {
                            entity.end_mk = "N";
                            if (entity.disabled_mk && entity.disabled_mk == true)
                                entity.end_mk = "Y";
                            delete entity.disabled_mk;
                            
                            NgJs.callService({
                                url: "Apps.Manage.Base.Users.UpdateUsers",
                                params: [entity],
                                http: $http,
                                toastr: toastr,
                                toastrConfig: toastrConfig,
                                cfpLoadingBar: cfpLoadingBar,
                                scope: $scope
                            }).then(function (data) {
                                NgJs.grid(optionsGrid);
                                
                            });
                        }
                        else if (entity._typeModal == "_new") {                            
                            NgJs.callService({
                                url: "Apps.Manage.Base.Users.AddUsers",
                                params: [entity],
                                http: $http,
                                toastr: toastr,
                                toastrConfig: toastrConfig,
                                cfpLoadingBar: cfpLoadingBar,
                                scope: $scope
                            }).then(function (data) {
                                NgJs.grid(optionsGrid);
                            });
                        }
                        else if (entity._typeModal == "_delete") {
                            NgJs.callService({
                                url: "Apps.Manage.Base.Users.DeleteUsers",
                                params: [entity],
                                http: $http,
                                toastr: toastr,
                                toastrConfig: toastrConfig,
                                cfpLoadingBar: cfpLoadingBar,
                                scope: $scope
                            }).then(function (data) {
                                NgJs.grid(optionsGrid);

                            });
                        }
                    }

                    $modalInstance.close();
                };
                $scope.cancel = function () {
                    $modalInstance.dismiss('cancel');
                };
            };


        });



              app.directive('myDragabledialog', function () {
                  return {
                      restrict: 'A',
                      link: function (scope, elem, attr) {
                          $(elem.parent()).draggable();
                      }
                  }
              });
              app.directive('myBodydialog', function () {
                  return {
                      restrict: 'A',
                      templateUrl: 'template/editUsersModal.html'

                  }
              });

              /*app.directive('myDragable', function ($document) {
                  "use strict";
                  return function (scope, element) {
                      var startX = 0,
                        startY = 0,
                        x = 0,
                        y = 0;
                      element.css({
                          position: 'fixed',
                          cursor: 'move'
                      });
                      element.on('mousedown', function (event) {
                          // Prevent default dragging of selected content
                          event.preventDefault();
                          startX = event.screenX - x;
                          startY = event.screenY - y;
                          $document.on('mousemove', mousemove);
                          $document.on('mouseup', mouseup);
                      });
      
                      function mousemove(event) {
                          y = event.screenY - startY;
                          x = event.screenX - startX;
                          element.css({
                              top: y + 'px',
                              left: x + 'px'
                          });
                      }
      
                      function mouseup() {
                          $document.unbind('mousemove', mousemove);
                          $document.unbind('mouseup', mouseup);
                      }
                  };
              });*/



    </script>
</asp:Content>

