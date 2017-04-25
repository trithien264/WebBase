using NService.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Apps.Manage.Base
{
    public class Users
    {
        public DataRowCollection GetUsers(Dictionary<string, object> args)
        {
            DataRowCollection drs = Tool.ToRows(DBHelper.Instance.Query("Apps.Manage.Base.Users.GetUsers", args));
            return drs;
        }

        public string UpdateUsers(Dictionary<string, object> args)
        {
            args.Add("upd_date", System.DateTime.Now.ToString("yyyyMMddHHmmss"));
            args.Add("upd_id", NService.AuthenticateHelper.Instance.UserID);
            DBHelper.Instance.Execute("Apps.Manage.Base.Users.updateUsers", args);
            return "1";

        }

        /*public string AddUsers(Dictionary<string, object> args)
        {
            args.Add("upd_date", System.DateTime.Now.ToString("yyyyMMddHHmmss"));

            DBHelper.Instance.Execute("Apps.Manage.Base.Users.AddUsers", args);
            return "1";

        }*/
 
        /*public string DeleteUsers(Dictionary<string, object> args)
        {
            DBHelper.Instance.Execute("Apps.Manage.Base.Users.deleteUsers", args);
            return "1";

        }*/
    }
}
