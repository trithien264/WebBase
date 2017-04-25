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

namespace Apps.Manage.Base
{
    public class Menu
    {
        public DataRowCollection GetMenuInfo(Dictionary<string, object> args)
        {
            //Thread.Sleep(10000);
            DataRowCollection drs = Tool.ToRows(DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenu", args));
            return drs;

        }
        public Dictionary<string, object> GetMenuByCond(Dictionary<string, object> args)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            DataRowCollection drs = Tool.ToRows(DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenuByCond", args));
            dic.Add("dataLindKind", App.GetLinkKind());
            dic.Add("dataMenu", drs);

            //Thread.Sleep(10000);

            return dic;
        }

        public string insertMenu(Dictionary<string, object> args)
        {
            if (!args.ContainsKey("link"))
            {
                args["link"] = "";
            }

            if(!string.IsNullOrEmpty(args["link"].ToString()))
                FnCommon.ThrowInfoIsEmpty(args, "link_kind", "Nhập vào link_kind!!!");

            if (!args.ContainsKey("link_kind"))
            {
                args["link_kind"] = "";
            }

            FnCommon.ThrowInfoIsEmpty(args, "group_type", "Nhập vào group_type!!!");

            //Check parentID hop le
            string up_menu_id = FnCommon.TryGetValue(args, "up_menu_id");
            if(up_menu_id!="0" && up_menu_id!="-1")
            {
                DataTable dtMenuParent = DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenuByCond", Tool.ToDic("menu_id", up_menu_id)).Tables[0];
                if (dtMenuParent.Rows.Count < 1)
                    throw new NService.NSErrorException("Không tồn UP_MENU_ID");
            }

            

            /*string stop_mk = FnCommon.TryGetValue(args, "disabled_mk").ToLower() == "true" ? "Y" : "N";
            args = FnCommon.TryUpdateValue(args, "stop_mk", stop_mk);  */


            //Thread.Sleep(10000);
            DBHelper.Instance.Execute("Apps.Manage.Base.Menu.insertMenu", args);
            return "1";

        }

        public string deleteMenu(Dictionary<string, object> args)
        {
            //Thread.Sleep(10000);
            DBHelper.Instance.Execute("Apps.Manage.Base.Menu.deleteMenu", args);
            return "1";

        }

        public string updateMenu(Dictionary<string, object> args)
        {
            FnCommon.ThrowInfoIsEmpty(args, "group_type", "Nhập vào group_type!!!");

            if (FnCommon.TryGetValue(args,"link")!="")
                FnCommon.ThrowInfoIsEmpty(args, "link_kind", "Nhập vào link_kind!!!");


            //Check parentID hop le
            string up_menu_id = FnCommon.TryGetValue(args, "up_menu_id");
            if (up_menu_id != "0" && up_menu_id != "-1")
            {
                DataTable dtMenuParent = DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenuByCond", Tool.ToDic("menu_id", up_menu_id)).Tables[0];
                if (dtMenuParent.Rows.Count < 1)
                    throw new NService.NSErrorException("Không tồn UP_MENU_ID");
            }

            if (!args.ContainsKey("link"))
            {
                args["link"] = "";
            }

             if (!args.ContainsKey("link_kind"))
             {
                 args["link_kind"] = "";
             }
            /*string stop_mk = FnCommon.TryGetValue(args, "disabled_mk").ToLower() == "true" ? "Y" : "N";
            args = FnCommon.TryUpdateValue(args, "stop_mk", stop_mk);  */

            //Thread.Sleep(10000);
            DBHelper.Instance.Execute("Apps.Manage.Base.Menu.updateMenu", args);
            return "1";

        }
      


        #region GetMenuV1
        public string GetMenu(Dictionary<string, object> args)
        {
            DataTable table = DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenu", args).Tables[0];
            DataRow[] parentMenus = table.Select("UP_MENU_ID = 0");

            var sb = new StringBuilder();
            string HTML = "";
            HTML += "<ul class='nav'>";
            foreach (DataRow dr in parentMenus)
            {
                HTML += "<li class='dropdown'>";
                HTML += "<a href='#'>" + dr["MENU_NM"].ToString() + "</a>";
                DataRow[] childMenus = table.Select("UP_MENU_ID = " + dr["MENU_ID"]);
                string unorderedList = GenerateUL(childMenus, table, sb);
                HTML += unorderedList;
                HTML += "</li>";
            }
            HTML += "</ul>";

            /* string str = @" <ul class='nav'>
                                 <a id='dLabel' role='button' data-toggle='dropdown' class='btn btn-start' data-target='#'
                                     href='#'>Start <span class='caret'></span></a>
                              " + unorderedList.ToString()
                            + @"</ul>";*/
            return HTML;
        }
        private string GenerateUL(DataRow[] menu, DataTable table, StringBuilder sb)
        {

            sb.AppendLine("<ul class='sub'>");

            if (menu.Length > 0)
            {
                foreach (DataRow dr in menu)
                {

                    string menuText = dr["MENU_NM"].ToString();

                    string line = String.Format(@"<li class='dropdown'><a href='#'>{0}</a>", menuText);
                    if (!string.IsNullOrEmpty(dr["LINK"].ToString()))
                        line = String.Format(@"<li><a href='#' class='menu_Link' mnuid='" + dr["MENU_ID"] + "' mnulink='" + dr["LINK"] + "'    mnuname='" + dr["MENU_NM"] + "'>{0}</a>", menuText);
                    sb.Append(line);

                    string menu_id = dr["MENU_ID"].ToString();
                    string parentId = dr["UP_MENU_ID"].ToString();

                    DataRow[] subMenu = table.Select(String.Format("UP_MENU_ID = {0}", menu_id));
                    if (subMenu.Length > 0 && !menu_id.Equals(parentId))
                    {
                        var subMenuBuilder = new StringBuilder();
                        sb.Append(GenerateUL(subMenu, table, subMenuBuilder));
                    }
                    sb.Append("</li>");
                }
            }
            sb.Append("</ul>");
            return sb.ToString();
        }
        #endregion


        #region NoUse
        public string treeJSONMenu(Dictionary<string, object> args)
        {
            FnCommon.ThrowInfoIsEmpty(args, "group_type", "Nhập vào group_type!!!");

            DataTable dtMenu = DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenu", args).Tables[0];
            List<objMenu> menus = new List<objMenu>();
            Dictionary<int, objMenu> dict=new Dictionary<int,objMenu>();
            menus.Add(new objMenu { menu_id = 0, parentId = -1, menu_name = "ROOT", link = "",stop_mk="", opened = true });

            if (dtMenu.Rows.Count > 0)
            {              
                for (int i = 0; i < dtMenu.Rows.Count; i++)
                {
                    DataRow dr = dtMenu.Rows[i];
                    menus.Add(new objMenu { menu_id = int.Parse(dr["MENU_ID"].ToString()), parentId = int.Parse(dr["UP_MENU_ID"].ToString()), menu_name = dr["MENU_NM"].ToString(), link = dr["LINK"].ToString(), link_kind = dr["LINK_KIND"].ToString(), stop_mk = dr["stop_mk"].ToString(), opened = true });

                }
                dict = menus.ToDictionary(loc => loc.menu_id);

                foreach (objMenu loc in dict.Values)
                {
                    if (loc.parentId != loc.menu_id  && loc.parentId != -1)
                    {
                        objMenu parent = dict[loc.parentId];
                        parent.children.Add(loc);
                    }
                }                
            }
            else
            {
                dict = menus.ToDictionary(loc => loc.menu_id);
            }

            objMenu root = dict.Values.First(loc => loc.parentId == -1);                      

            JsonSerializerSettings settings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver(),
                Formatting = Newtonsoft.Json.Formatting.Indented
            };
            string json = JsonConvert.SerializeObject(root, settings);

            return json;

            /*IEnumerable<objMenu> menus = new List<objMenu>
            {                
                new objMenu { menu_id = 1, parentId = -1, menu_name = "Start" },
                new objMenu { menu_id = 2, parentId = 1, menu_name = "Loc1" },
                new objMenu { menu_id = 3, parentId = 1, menu_name = "Loc2" },
                new objMenu { menu_id = 4, parentId = 2, menu_name = "Loc1A" },
                new objMenu { menu_id = 5, parentId = 3, menu_name = "Loc1A" },
                new objMenu { menu_id = 6, parentId = 3, menu_name = "Loc1A" },
                new objMenu { menu_id = 7, parentId = 3, menu_name = "Loc1A" },
                new objMenu { menu_id = 8, parentId = 3, menu_name = "Loc1A" },
                new objMenu { menu_id = 9, parentId = 6, menu_name = "Loc1A" },
                new objMenu { menu_id = 10, parentId = 7, menu_name = "Loc1A" },
                new objMenu { menu_id = 11, parentId = 6, menu_name = "Loc1A" },
                new objMenu { menu_id = 12, parentId = 11, menu_name = "Loc1A" },
                new objMenu { menu_id = 13, parentId = 12, menu_name = "Loc1A" },
                new objMenu { menu_id = 14, parentId = 13, menu_name = "Loc1A" },
                new objMenu { menu_id = 15, parentId = 1, menu_name = "TopLoc" },
            };*/

            return "";
        }
        #endregion



    }

    class objMenu
    {
        public objMenu()
        {
            children = new List<objMenu>();
        }

        public int menu_id { get; set; }
        public int parentId { get; set; }
        //public int UP_MENU_ID { get; set; }
        public string menu_name { get; set; }
        public string link { get; set; }
        public string link_kind { get; set; }
        public string stop_mk { get; set; }
        public bool opened { get; set; }

        public List<objMenu> children { get; set; }
    }
}

