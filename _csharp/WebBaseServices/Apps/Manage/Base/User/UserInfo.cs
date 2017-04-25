using NService.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Apps.Manage.Base.User
{
    [NService.RightsAccess(NService.AccessType.LoginUser)]
    class UserInfo
    {
        public DataRowCollection GetUsers(Dictionary<string, object> args)
        {
            args.Add("user_id", NService.AuthenticateHelper.Instance.UserID);
            DataRowCollection drs = Tool.ToRows(DBHelper.Instance.Query("Apps.Manage.Base.Users.UserInfo.GetUsers", args));
            return drs;
        }

        public string updateUser(Dictionary<string, object> args)
        {
            args.Add("upd_date", System.DateTime.Now.ToString("yyyyMMddHHmmss"));
            args = FnCommon.TryUpdateValue(args, "user_id", NService.AuthenticateHelper.Instance.UserID);

            DBHelper.Instance.Execute("Apps.Manage.Base.Users.UserInfo.updateUsers", args);
            return "ok";

        }
    }
}
