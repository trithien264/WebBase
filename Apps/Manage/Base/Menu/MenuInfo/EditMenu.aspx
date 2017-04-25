<%@ Page Language="C#" AutoEventWireup="true" %>


        <md-dialog aria-label="Mango (Fruit)">
        <form ng-cloak>
            <md-toolbar>
                <div class="md-toolbar-tools">
                    <h2>Manage Menu</h2>
                    <span flex></span>
                    <md-button class="md-icon-button" ng-click="cancel()">
                        <md-icon md-svg-src="../../../Pub/libAngular/angular-material/img/icon/ic_close_24px.svg" aria-label="Close dialog"></md-icon>
                    </md-button>
                </div>
            </md-toolbar>

            <md-dialog-content>
                <div class="md-dialog-content">
                   <table cellpadding="2" border="0" cellspacing="2"  class="table table-bordered">
                       <tr> 
                           <th style="text-align:right;  white-space:nowrap"  ><n-lang>ID</n-lang>: </th><td><input id="name" readonly="readonly" style="background-color:#eaeaea" type="text" ng-model="model.menu_id" style="text-align:right" /></td>
                           <th style="text-align:right; width:15%; white-space:nowrap" ><n-lang>UP_ID</n-lang>: </th><td><input id="link" type="text" ng-model="model.up_menu_id" /></td>
                       </tr>
                       <tr>
                           <th style="text-align:right; white-space:nowrap" ><n-lang>MENU_NAME</n-lang>(VN): </th><td><input id="name" type="text" ng-model="model.menu_nm" style="width:100%"/></td>
                           <th style="text-align:right; width:15%; white-space:nowrap" ><n-lang>MENU_NAME</n-lang>(ENG): </th><td><input id="name_eng" type="text" ng-model="model.menu_nm_eng" style="width:100%"/></td>
                       </tr>                      
                        <tr>
                           <th style="text-align:right;  white-space:nowrap" ><n-lang>GROUP_TYPE</n-lang>: </th><td><input id="group_type" type="text" ng-model="model.group_type" readonly="readonly" style="background-color:#eaeaea" style="width:100%"/></td>
                           <th style="text-align:right;  white-space:nowrap" ><n-lang>LINK_MENU</n-lang>: </th><td><input id="link" type="text" ng-model="model.link" style="width:100%"/>
                           </td>
                       </tr>
                       <tr>                           
                           <th style="text-align:right;  white-space:nowrap" ><n-lang>LINK_KIND</n-lang>: </th><td>
                               <select ng-model="model.link_kind" 
                                        ng-options="item.value as item.key for item in model.dataLindKind">
                                    <option value="">--- Select ---</option>
                                </select>
                           </td>
                       </tr>

                       <tr>
                           <th style="text-align:right; width:15%; white-space:nowrap" ><n-lang>DISABLED</n-lang>: </th><td><input id="stop_mk" type="checkbox" ng-model="model.disabled_mk" style="width:100%"/></td>                           
                            <th style="text-align:right; width:15%; white-space:nowrap" ><n-lang>ICON</n-lang>: </th><td><input id="imgicon" type="text" ng-model="model.icon" style="width:100%"/><a href="https://www.w3schools.com/bootstrap/bootstrap_ref_comp_glyphs.asp" target="_blank">Icon List</a></td>                           
                       </tr>
                   </table>
                </div>
            </md-dialog-content>
           
            <md-dialog-actions layout="row">               
                <span flex></span>
                <md-button ng-click="answer('save',model)" class="md-raised md-primary">
                    <n-lang>SAVE</n-lang>
                </md-button>
                <md-button ng-click="answer('close')" class="md-raised md-primary">
                    <n-lang>CANCEL</n-lang>
                </md-button>
            </md-dialog-actions>
        </form>
    </md-dialog>
    
