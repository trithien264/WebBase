<%@ Page Language="C#" AutoEventWireup="true" %>


        <md-dialog aria-label="Mango (Fruit)">
        <form ng-cloak>
            <md-toolbar>
                <div class="md-toolbar-tools">
                    <h2>Manage Menu</h2>
                    <span flex></span>
                    <md-button class="md-icon-button" ng-click="cancel()">
                        <md-icon md-svg-src="../../../../Pub/libAngular/angular-material/img/icon/ic_close_24px.svg" aria-label="Close dialog"></md-icon>
                    </md-button>
                </div>
            </md-toolbar>

            <md-dialog-actions layout="row">               
               <%-- <span flex></span>
                <md-button ng-click="answer('save',model)">
                    Save
                </md-button>--%>
                <md-button ng-click="answer('close')" >
                    <n-lang>CANCEL</n-lang>
                </md-button>
            </md-dialog-actions>

            <md-dialog-content>
                <div class="md-dialog-content">
                   <table cellpadding="2" border="0" cellspacing="2"  class="table table-bordered">                      
                       <tr>
                           <th style="text-align:right; width:15%; white-space:nowrap" ><n-lang>USER_ID</n-lang>: </th><td><input  type="text" ng-model="modelsData.user_id" style="width:100%"/></td>
                           <th style="text-align:right; width:15%; white-space:nowrap" ><n-lang>EMAIL</n-lang>: </th><td><input  type="text" ng-model="modelsData.email"  style="width:100%"/></td>
                           <td>                             
                               <md-button ng-click="answer('search',modelsData)" class="md-raised md-primary"><n-lang>SEARCH</n-lang></md-button></td>
                       </tr>
                   </table>
                    <div ui-grid="ngGridMenuRights" ui-grid-pagination class="grid"  ui-grid-selection >
                </div>
            </md-dialog-content>
           
           
        </form>
    </md-dialog>
    
