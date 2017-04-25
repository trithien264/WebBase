using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using NService.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Apps.Manage.Base.Rights
{
    class RightsMenu
    {
        public string treeJSONMenuRights(Dictionary<string, object> args)
        {
            FnCommon.TryUpdateValue(args, "group_type", "M");
            FnCommon.TryUpdateValue(args, "user_id", NService.AuthenticateHelper.Instance.UserID);
            //DataTable dtMenu = DBHelper.Instance.Query("Apps.Manage.Base.Rights.GetListUserRights", args).Tables[0];

            DataTable dtMenu = new DataTable();
            bool isSupperAdmin = false;
            if (NService.DBRightsProvider.Instance.HasSuperManager(NService.AuthenticateHelper.Instance.UserID))
            {
                dtMenu = DBHelper.Instance.Query("Apps.Manage.Base.Menu.getMenuManageSuperAdmin", args).Tables[0];
                isSupperAdmin = true;
            }
            else
                dtMenu = DBHelper.Instance.Query("Apps.Manage.Base.Rights.getMenuRights", args).Tables[0];


            if (dtMenu.Rows.Count > 0)
            {
                List<objMenu> menus = new List<objMenu>();
                string rights_mk = "", menu_nm;
                DataRow dr;
                for (int i = 0; i < dtMenu.Rows.Count; i++)
                {
                    dr = dtMenu.Rows[i];
                    if (isSupperAdmin)
                    {
                        rights_mk = "Y";
                    }
                    else
                    {
                        try
                        {
                            rights_mk = dr["rights_mk"].ToString();
                        }
                        catch
                        {
                        }
                    }

                    menu_nm = dr["MENU_NM"].ToString();

                    if (rights_mk == "Y")
                    {
                        menu_nm = dr["MENU_NM"].ToString() + "  ►";
                    }
                    else
                        menu_nm = dr["MENU_NM"].ToString();


                    menus.Add(new objMenu { menu_id = int.Parse(dr["MENU_ID"].ToString()), parentId = int.Parse(dr["UP_MENU_ID"].ToString()), label = menu_nm, link = dr["LINK"].ToString(), rights_mk = rights_mk });

                }


                Dictionary<int, objMenu> dict = menus.ToDictionary(loc => loc.menu_id);

                foreach (objMenu loc in dict.Values)
                {
                    if (loc.parentId != loc.menu_id && loc.parentId != 0)
                    {
                        objMenu parent = dict[loc.parentId];
                        parent.children.Add(loc);
                    }
                }

                objMenu root = dict.Values.First(loc => loc.parentId == 0);

                JsonSerializerSettings settings = new JsonSerializerSettings
                {
                    ContractResolver = new CamelCasePropertyNamesContractResolver(),
                    Formatting = Newtonsoft.Json.Formatting.Indented
                };
                string json = JsonConvert.SerializeObject(root, settings);

                return json;
            }



            return "";
        }

        public DataRowCollection GetUserRights(Dictionary<string, object> args)
        {
            if (!args.ContainsKey("menu_id"))
                args["menu_id"] = "-1";
            DataRowCollection drs = Tool.ToRows(DBHelper.Instance.Query("Apps.Manage.Base.Rights.GetUserRights", args));
            return drs;
        }

        public DataRowCollection GetListUserRights(Dictionary<string, object> args)
        {
            if (!args.ContainsKey("menu_id"))
                args["menu_id"] = "0";
            DataRowCollection drs = Tool.ToRows(DBHelper.Instance.Query("Apps.Manage.Base.Rights.GetListUserRights", args));
            return drs;
        }



        public string SaveMenuRights(Dictionary<string, object> args)
        {
            if (args["isSelected"].ToString().ToLower() == "true")
            {
                args["right_kind"] = "menu";
                DBHelper.Instance.Execute("Apps.Manage.Base.Rights.insertMenuRights", args);
            }
            else
                DeleteMenuRights(args);

            return "1";

        }

        public string DeleteMenuRights(Dictionary<string, object> args)
        {
            DBHelper.Instance.Execute("Apps.Manage.Base.Rights.deleteMenuRights", args);
            return "1";

        }
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
        public string label { get; set; }
        public string link { get; set; }
        public string rights_mk { get; set; }

        public List<objMenu> children { get; set; }
    }
}
