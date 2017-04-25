﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using NService.Tools;
using System.Xml;
using System.IO;
using System.Xml.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System.Web;
using NService;

namespace Apps.Manage.Base
{
    class Index
    {
        [NService.RightsAccess(NService.AccessType.LoginUser)]
        public void RecordMenuAccess(int menuID)
        {
            ClientTool.Instance.RecordMenuAccess(menuID);
            
        }

       
        #region GetMenu_Bootrap
        [NService.RightsAccess(NService.AccessType.LoginUser)]
        public Dictionary<string, object> GetIndexInfo(Dictionary<string, object> args)
        {
            return CallTransLanguage();

        }

        public string GetLanguage()
        {
            return FnLanguage.GetLanguage();

        }

        private Dictionary<string, object> CallTransLanguage()
        {
            Dictionary<string, object> dicUser = NService.AuthenticateHelper.Instance.User;
            Dictionary<string, object> dicUserNew = new Dictionary<string, object>();
            dicUserNew.Add("user_desc", dicUser["user_desc"]);
            dicUserNew.Add("email", dicUser["email"]);
            dicUserNew.Add("user_id", dicUser["user_id"]);

            Dictionary<string, object> dic = new Dictionary<string, object>();
            dic.Add("Languages", GenLanguage());
            dic.Add("UserInfo", dicUserNew);
            dic.Add("MenuInfo", GetMenuManager_Bootrap());
            return dic;             
        }
        private string GenLanguage()
        {
            DataRowCollection langList = App.GetLanguages();
            StringBuilder sb = new StringBuilder();
            //sb.AppendLine("<ul id='ulContainerLanguage'>");
            string CookieLang = FnLanguage.GetLanguage();           
            FnLanguage.SetLanguage(CookieLang);

            for (int i = 0; i < langList.Count; i++)
            {
                if (langList[i]["key"].ToString() == CookieLang)
                {
                    sb.Append(String.Format(@"<li><a href='#' ng-click='changeLang(""{0}"")'><span class='menuicon glyphicon glyphicon-flag'></span>{1}</a>", langList[i]["key"], langList[i]["value"]));
                }
                else
                    sb.Append(String.Format(@"<li><a href='#' ng-click='changeLang(""{0}"")'><span class='menuicon'></span>{1}</a>", langList[i]["key"], langList[i]["value"]));
            }

            //sb.Append("</ul>");
            return sb.ToString();
        }
        public void ChangeLanguage(Dictionary<string, object> args)
        {
            FnLanguage.SetLanguage(args["lang_value"].ToString());
            //return CallTransLanguage();
        }
        public string GetMenuManager_Bootrap()
        {
            Dictionary<string, object> args = new Dictionary<string, object>();
            string MENU_NM = FnLanguage.GetMenuNmByLang();
            FnCommon.TryUpdateValue(args, "user_id", NService.AuthenticateHelper.Instance.UserID);
            FnCommon.TryUpdateValue(args, "group_type", "M");

            DataTable table = new DataTable();
            if (NService.DBRightsProvider.Instance.HasSuperManager(NService.AuthenticateHelper.Instance.UserID))
                table = DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenuManageSuperAdmin", args).Tables[0];
            else
                table = DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenuManage", args).Tables[0];

            if (table.Rows.Count < 1) return "";
            DataRow[] parentMenus = table.Select("UP_MENU_ID = 0");

            var sb = new StringBuilder();
            string HTML = "";
            
            foreach (DataRow dr in parentMenus)
            {
                if (dr["stop_mk"].ToString() == "Y") continue;

                HTML += "<li>";
                HTML += "<a href='#'><span class='menuicon " + dr["ICON"].ToString() + "'></span>" + dr[MENU_NM].ToString() + "</a>";
                DataRow[] childMenus = table.Select("UP_MENU_ID = " + dr["MENU_ID"]);
                string unorderedList = GenerateUL_Bootrap(childMenus, table, sb);
                HTML += unorderedList;
                HTML += "</li>";
            }
            return HTML;
        }        

        private string GenerateUL_Bootrap(DataRow[] menu, DataTable table, StringBuilder sb)
        {
            string MENU_NM = FnLanguage.GetMenuNmByLang();
            sb.AppendLine("<ul>");

            if (menu.Length > 0)
            {
                foreach (DataRow dr in menu)
                {
                    if (dr["stop_mk"].ToString() == "Y") continue;

                    string menuText = dr[MENU_NM].ToString();
                    string link = dr["LINK"].ToString();

                    string line = String.Format(@"<li><a href='#'><span class='menuicon " + dr["ICON"].ToString() + "'></span>{0}</a>", menuText);
                    if (!string.IsNullOrEmpty(link))
                    {
                        string link_kind = dr["LINK_KIND"].ToString();
                        switch (link_kind.ToLower())
                        {
                            case "aspx":
                                link = link.Replace(".", "/") + ".aspx";
                                break;
                        }

                        line = String.Format(@"<li><a href='#' class='menu_Link' mnuid='" + dr["MENU_ID"] + "' mnulink='" + link + "'    mnuname='" + dr[MENU_NM] + "'><span class='menuicon " + dr["ICON"].ToString() + "'></span>{0}</a>", menuText);
                    }

                    sb.Append(line);

                    string menu_id = dr["MENU_ID"].ToString();
                    string parentId = dr["UP_MENU_ID"].ToString();

                    DataRow[] subMenu = table.Select(String.Format("UP_MENU_ID = {0}", menu_id));
                    if (subMenu.Length > 0 && !menu_id.Equals(parentId))
                    {
                        var subMenuBuilder = new StringBuilder();
                        sb.Append(GenerateUL_Bootrap(subMenu, table, subMenuBuilder));
                    }
                    sb.Append("</li>");
                }
            }
            sb.Append("</ul>");
            return sb.ToString();
        }
        #endregion
    }
}
