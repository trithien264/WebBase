using NService;
using NService.Tools;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using WebBaseServices.Common;

namespace WebBaseServices.OOP
{
    public class LoginUI
    {
        public string ActiveRecoveryPwd(Dictionary<string, object> args)
        {

            FnCommon.ThrowInfoIsEmpty(args, "reg_code", "Nhập vào mã kích hoạt!!!");
            FnCommon.ThrowInfoIsEmpty(args, "pwd", "Nhập vào mật khẩu mới!!!");
            FnCommon.ThrowInfoIsEmpty(args, "textCaptChar", "Nhập vào mã xác nhận!!!");

            if (FnEncypt.rpHash(args["textCaptChar"].ToString()) != args["textCaptCharHash"].ToString())
                throw new NService.NSInfoException("Mã xác thực không hợp lệ!!!");

            args.Add("upd_date", System.DateTime.Now.ToString("yyyyMMddHHmmss"));

            //Get OverActiveDays
            args = FnCommon.MergeDic(args, FnConfig.dicApps("User"));


            //kiem tra reg code phu hop khong
            DataTable dtUserIsActive = DBHelper.Instance.Query("Apps.Manage.Base.Users.rec_GetUserIsActive", args).Tables[0];
            if (dtUserIsActive.Rows.Count < 1)
            {
                throw new NService.NSInfoException("Mã kích hoạt không hợp lệ!!!");
            }
            else
            {
                if (dtUserIsActive.Rows[0]["is_active"].ToString() == "Y")
                {
                    throw new NService.NSInfoException("Yêu cầu thay đổi mật khẩu của bạn đã được sử dụng, nếu muốn tiếp tục thay đổi mật khẩu. Vui lòng sử dụng chức năng [Quên mật khẩu]!!!");
                }
            }

            args["pwd"] = FnSecurity.GeneratePassword(args["pwd"].ToString());

            //Insert Data
            DBHelper.Instance.Execute("Apps.Manage.Base.Users.rec_ActiveRecoveryUser", args);
            return "1";
        }

        public string RegisterRecoveryPwd(Dictionary<string, object> args)
        {

            FnCommon.ThrowInfoIsEmpty(args, "email", "Nhập vào thông tin Email!!!");
            FnCommon.ThrowInfoIsEmpty(args, "textCaptChar", "Nhập vào mã xác nhận!!!");

            if (FnEncypt.rpHash(args["textCaptChar"].ToString()) != args["textCaptCharHash"].ToString())
                throw new NService.NSInfoException("Mã xác thực không hợp lệ!!!");

            string reg_code = Guid.NewGuid().ToString();
            args.Add("upd_date", System.DateTime.Now.ToString("yyyyMMddHHmmss"));
            args.Add("reg_code", reg_code);

            //Get content config file
            string strFileActive = FnConfig.getFileConfig("Template", "User.RecoveryPassword.html");
            Dictionary<string, object> dicAppsInfo = FnConfig.dicApps("Info");

            //Merge to Main Dic
            args = FnCommon.MergeDic(args, dicAppsInfo);
            args = FnCommon.MergeDic(args, FnConfig.dicApps("User"));

            //Check valid email
            DataTable dtUser = DBHelper.Instance.Query("Apps.Manage.Base.Users.GetUsersByEmail", args).Tables[0];
            if (dtUser.Rows.Count < 1)
            {
                throw new NService.NSInfoException("Tài khoản của bạn không tồn tại, Vui lòng kiểm tra lại thông tin email !!!");
            }


            args["AppLinkActive"] = args["Config_AppLink"] + "/Apps/ui/User/UserInfo.aspx#/activerecoverypwd/regcode/" + reg_code + "?email=" + args["email"].ToString();
            //Replace content email
            string str = FnCommon.ReplaceBetWeenStr(strFileActive, "===", args);

            //Insert Data
            DBHelper.Instance.Execute("Apps.Manage.Base.Users.rec_RegisterUser", args);

            string subject = "Khôi phục mật khẩu tài khoản " + dicAppsInfo["ShortAppName"].ToString();

            //Send Mail
            Tool.SendMail(dicAppsInfo["ShortAppName"].ToString(), subject, args["email"].ToString(), "", str, null);


            return "1";
        }

        public Dictionary<string, object> RememerUserInfo(Dictionary<string, object> args)
        {
            CookieAuthenticateModule cookieUser = new CookieAuthenticateModule();
            Dictionary<string, object> dicUser = new Dictionary<string, object>();
            Dictionary<string, object> dicUserNew = new Dictionary<string, object>();



            string UserID = AuthenticateHelper.Instance.UserID;//User da login roi cho phep dang nhap tu dong
            if (!string.IsNullOrEmpty(UserID))
            {
                dicUserNew.Add("UserID", UserID);
                dicUserNew.Add("autologin", "true");//use cookie pwd
                return dicUserNew;
            }

            return null;

            #region AutoLogin
            /*try
            {
                string UserID = cookieUser.GetAutoLogin();
                if (!string.IsNullOrEmpty(UserID))
                {
                    dicUserNew.Add("UserID", UserID);
                    dicUserNew.Add("autologin", "true");//use cookie pwd
                    return dicUserNew;
                }

            }
            catch
            {
                return null;
            }*/
            #endregion

            #region RememberPwd
            /*try
            {
                dicUser = Tool.ToDic(cookieUser.GetUserMemoryUser());
                if (dicUser != null && dicUser.Count > 0)
                {
                    dicUserNew.Add("email", dicUser["email"].ToString());
                    dicUserNew.Add("pwd", "********");
                    dicUserNew.Add("isrememberpwd", "true");
                    dicUserNew.Add("rememberpwd", true);
                    return dicUserNew;
                }
            }
            catch
            {
                return null;
            }*/

            #endregion

            return null;
        }

        #region Login and Logout
        [RightsAccess(AccessType.AllCanCall)]
        public string LogoutUser(Dictionary<string, object> args)
        {
            AuthenticateHelper.Instance.Logout();
            return "ok";
        }


        public DataRow LoginUser(Dictionary<string, object> args)
        {
            FnCommon.ThrowInfoIsEmpty(args, "email", "Nhập vào thông tin Email!!!");
            FnCommon.ThrowInfoIsEmpty(args, "pwd", "Nhập vào mật khẩu!!!");
            args["pwd"] = FnSecurity.GeneratePassword(args["pwd"].ToString());

            DataRow dr = Tool.ToRow(DBHelper.Instance.Query("Apps.Manage.Base.Users.LoginUser", args));
            if (dr == null)
            {              
                throw new NService.NSInfoException("Tài khoản đăng nhập hoặc mật khẩu không hợp lệ!!!");
            }          

            NService.AuthenticateHelper.Instance.Login(dr["user_id"].ToString());

            args.Add("user_id", dr["user_id"].ToString());
            args.Add("last_login", System.DateTime.Now.ToString("yyyyMMddHHmmss"));

            DBHelper.Instance.Execute("Apps.Manage.Base.Users.UpdateLoginInfo", args);
            return dr;
        }
        
        #endregion

        public string RegisterUsers(Dictionary<string, object> args)
        {
            FnCommon.ThrowInfoIsEmpty(args, "user_desc", "<n-lang code='REQUIRE_USER_DESC'>Nhập vào họ tên!!!</n-lang>");
            FnCommon.ThrowInfoIsEmpty(args, "email", "<n-lang code='REQUIRE_EMAIL'>Nhập vào thông tin Email!!!</n-lang>");
            FnCommon.ThrowInfoIsEmpty(args, "pwd", "<n-lang code='REQUIRE_PASSWORD'>Nhập vào mật khẩu!!!</n-lang>");
            FnCommon.ThrowInfoIsEmpty(args, "textCaptChar", "Nhập vào mã xác nhận!!!");

            if (FnEncypt.rpHash(args["textCaptChar"].ToString()) != args["textCaptCharHash"].ToString())
                throw new NService.NSInfoException("Mã xác thực không hợp lệ!!!");



            string reg_code = Guid.NewGuid().ToString();
            args.Add("upd_date", System.DateTime.Now.ToString("yyyyMMddHHmmss"));
            args.Add("reg_code", reg_code);

            //Get content config file
            string strFileActive = FnConfig.getFileConfig("Template", "User.ActiveAccount.html");
            Dictionary<string, object> dicAppsInfo = FnConfig.dicApps("Info");

            //Merge to Main Dic
            args = FnCommon.MergeDic(args, dicAppsInfo);
            args = FnCommon.MergeDic(args, FnConfig.dicApps("User"));

            //Check Valid
            DataTable dtActive = DBHelper.Instance.Query("Apps.Manage.Base.Users.GetUserWaitingActive", args).Tables[0];
            if (dtActive.Rows.Count > 0)
            {
                throw new NService.NSInfoException("Email của bạn đã đăng ký, đang chờ được kích hoạt. Xin kiểm tra hộp thư của bạn");
            }

            DataTable dtUser = DBHelper.Instance.Query("Apps.Manage.Base.Users.GetUsersByEmail", args).Tables[0];
            if (dtUser.Rows.Count > 0)
            {
                throw new NService.NSInfoException("Email của bạn đã được đăng ký");
            }


            args["AppLinkActive"] = args["Config_AppLink"] + "/Apps/User/UserInfo.aspx#/activeusers/regcode/" + reg_code + "?email=" + args["email"].ToString();
            //Replace content email
            string str = FnCommon.ReplaceBetWeenStr(strFileActive, "===", args);

            args["pwd"] = FnSecurity.GeneratePassword(args["pwd"].ToString());

            //Insert Data
            DBHelper.Instance.Execute("Apps.Manage.Base.Users.RegisterUsers", args);

            string subject = "Kích hoạt tài khoản " + dicAppsInfo["ShortAppName"].ToString();

            //Send Mail
            Tool.SendMail(dicAppsInfo["ShortAppName"].ToString(), subject, args["email"].ToString(), "", str, null);


            return "1";
        }

        public string ActiveUser(Dictionary<string, object> args)
        {
            FnCommon.ThrowInfoIsEmpty(args, "reg_code", "Nhập vào mã kích hoạt!!!");

            args.Add("upd_date", System.DateTime.Now.ToString("yyyyMMddHHmmss"));

            //Get OverActiveDays
            args = FnCommon.MergeDic(args, FnConfig.dicApps("User"));

            //kiem tra reg code phu hop khong
            DataTable dtUserIsActive = DBHelper.Instance.Query("Apps.Manage.Base.Users.reg_GetUserIsActive", args).Tables[0];
            if (dtUserIsActive.Rows.Count < 1)
            {
                throw new NService.NSInfoException("Mã kích hoạt không hợp lệ!!!");
            }
            else
            {
                if (dtUserIsActive.Rows[0]["is_active"].ToString() == "Y")
                {
                    throw new NService.NSInfoException("Email của bạn đã được kích hoạt!!!");
                }
            }

            //Kiem tra user nay da dang ky chua
            DataTable dtUser = DBHelper.Instance.Query("Apps.Manage.Base.Users.reg_GetUsersByReg", args).Tables[0];
            if (dtUser.Rows.Count > 0)
            {
                throw new NService.NSInfoException("Email của bạn đã được đăng ký");
            }


            //Insert Data
            DBHelper.Instance.Execute("Apps.Manage.Base.Users.reg_ActiveUser", args);

            //Send Mail
            //Tool.SendMail(dicAppsInfo["ShortAppName"].ToString(), args["user_desc"].ToString(), args["email"].ToString(), "", str, null);


            return "1";
        }


        //Tam thoi khong luu tru thong tin cookie
        public DataRow LoginUser_Cookie(Dictionary<string, object> args)
        {
            FnCommon.ThrowInfoIsEmpty(args, "email", "Nhập vào thông tin Email!!!");
            FnCommon.ThrowInfoIsEmpty(args, "pwd", "Nhập vào mật khẩu!!!");

            bool saveCookie = false;
            #region RememberPwd
            if (FnCommon.TryGetValue(args, "isrememberpwd").ToLower() == "true") //Get pwd from cookie.Pwd is config empty in sql file
            {

                CookieAuthenticateModule cookieUser = new CookieAuthenticateModule();
                Dictionary<string, object> dicUser = new Dictionary<string, object>();
                try
                {
                    dicUser = Tool.ToDic(cookieUser.GetUserMemoryUser());
                    args["pwd"] = dicUser["pwd"].ToString();

                }
                catch
                {
                    args["pwd"] = "";
                }
            }
            else
            {
                args["pwd"] = FnSecurity.GeneratePassword(args["pwd"].ToString());
                CookieAuthenticateModule cookieUser = new CookieAuthenticateModule();
                cookieUser.ClearRememberUserMemory();
            }

            //Save Cookie
            if (FnCommon.TryGetValue(args, "rememberpwd").ToLower() == "true") //Get pwd from cookie.Pwd is config empty in sql file
            {
                saveCookie = true;
            }

            #endregion


            DataRow dr = Tool.ToRow(DBHelper.Instance.Query("Apps.Manage.Base.Users.LoginUser", args));
            if (dr == null)
            {
                CookieAuthenticateModule cookieUser = new CookieAuthenticateModule();
                cookieUser.ClearUserMemory();
                throw new NService.NSInfoException("Tài khoản đăng nhập hoặc mật khẩu không hợp lệ!!!");
            }
            else
            {
                #region AutoLogin
                if (FnCommon.TryGetValue(args, "autologin").ToLower() == "true") //Load pwd from cookie
                {
                    CookieAuthenticateModule cookieUser = new CookieAuthenticateModule();
                    cookieUser.SetAutoLogin(dr["user_id"].ToString());
                }
                #endregion
            }

            NService.AuthenticateHelper.Instance.Login(dr["user_id"].ToString(), saveCookie);
            return dr;
        }
    }
}
