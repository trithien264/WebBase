using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

    class FnCommon
    {
        #region Xu ly chuoi

        public static string ReplaceBetWeenStr(string source, string strchar, Dictionary<string, object> args)
        {
            string str = source;
            string keyBetween = "";
            for (int i = 0; i < 10000; i++)
            {
                keyBetween = GetStringInBetween(str, strchar, strchar, false, false);
                if (keyBetween.Length < 1) break;
                str = str.Replace(strchar + keyBetween + strchar, TryGetValue(args, keyBetween));
            }

            return str;

        }

        public static string GetStringInBetween(string strSource, string strBegin, string strEnd, bool includeBegin, bool includeEnd)
        {
            string[] result = { string.Empty, string.Empty };
            int iIndexOfBegin = strSource.IndexOf(strBegin);

            if (iIndexOfBegin != -1)
            {
                // include the Begin string if desired 
                if (includeBegin)
                    iIndexOfBegin -= strBegin.Length;

                strSource = strSource.Substring(iIndexOfBegin + strBegin.Length);

                int iEnd = strSource.IndexOf(strEnd);
                if (iEnd != -1)
                {
                    // include the End string if desired 
                    if (includeEnd)
                        iEnd += strEnd.Length;
                    result[0] = strSource.Substring(0, iEnd);
                    // advance beyond this segment 
                    if (iEnd + strEnd.Length < strSource.Length)
                        result[1] = strSource.Substring(iEnd + strEnd.Length);
                }
            }
            else
                // stay where we are 
                result[1] = strSource;
            return result[0];
        } 
        #endregion

        #region DataTable
        public static void AddRow(ref DataTable dt, string key, string value)
        {
            if (dt == null || dt.Columns.Count < 1)
            {
                dt = new DataTable();
                dt.Columns.Add("key");
                dt.Columns.Add("value");
            }

            DataRow dr = dt.NewRow();
            dr["key"] = key;
            dr["value"] = value;
            dt.Rows.Add(dr);
        } 
        #endregion


        #region Dictionary
        public static Dictionary<string, object> MergeDic(Dictionary<string, object> dicA, Dictionary<string, object> dicB)
        {
            try
            {
                return dicA.Concat(dicB)
                  .GroupBy(kvp => kvp.Key, kvp => kvp.Value)
                  .ToDictionary(g => g.Key, g => g.Last());
            }
            catch (Exception)
            {
            }
            return dicA;


        }
        public static string TryGetValue(Dictionary<string, object> args, string key)
        {
            string str = "";
            try
            {
                str = args[key].ToString();
            }
            catch (Exception)
            {
            }
            return str;
        }

        public static Dictionary<string, object> TryUpdateValue(Dictionary<string, object> args, string key, string value)
        {
            Dictionary<string, object> dic = args;
            try
            {
                dic.Add(key, value);
            }
            catch (Exception)
            {
                dic[key] = value;
            }
            return dic;
        }

        public static string ThrowInfoIsEmpty(Dictionary<string, object> args, string key, string message)
        {
            string str = "";
            try
            {
                str = args[key].ToString();
            }
            catch (Exception)
            {
            }
            if (str.Length < 1)
                throw new NService.NSInfoException(message);

            return str;
        } 
        #endregion
    }

    class FnEncypt
    {
        public static string rpHash(string value)
        {
            int hash = 5381;
            value = value.ToUpper();
            for (int i = 0; i < value.Length; i++)
            {
                hash = ((hash << 5) + hash) + value[i];
            }
            return hash.ToString();
        } 
    }

    class FnCookie
    {
        public static void SetCookie(string key, string value, double ExpiresDays, bool HttpOnly)
        {
            HttpCookie obj_cookie = new HttpCookie(key, value);
            if (HttpOnly)//True readonly server, False read server and client
            {
                obj_cookie.HttpOnly = true;
                obj_cookie.Path = "/";
            }            
            obj_cookie.Expires = DateTime.Now.AddDays(ExpiresDays);    
            HttpContext.Current.Response.Cookies.Add(obj_cookie);
        }

        public static void ClearCookie(string key)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[key];          
            if (cookie != null)
            {
                cookie.Expires = DateTime.Now.AddDays(-1);
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
        }

        public static string GetCookie(string key)
        {
            //記得還要加密哦
            HttpCookie cookie = HttpContext.Current.Request.Cookies[key];
            if (cookie != null && cookie.Value != null)
            {
                try
                {
                    string ret = cookie.Value;
                    return ret;
                }
                catch
                {
                    return null;
                }
            }
            return null;
        }
    }

class FnLanguage
{
    public static void SetLanguage(string lang_value)
    {
        FnCookie.SetCookie(App.Key_CookieLangs, lang_value, 1,false);
    }

    public static string GetLanguage()
    {
        string str = FnCookie.GetCookie(App.Key_CookieLangs);
        if (string.IsNullOrEmpty(str))
        {
            //Set Default: dong dau tien la default
            return App.GetLanguages()[0]["key"].ToString();
        }
        return str;

    }
    public static string GetMenuNmByLang()
    {
        if (GetLanguage() == "en")
        {
            return "MENU_NM_ENG";
        }
        else
        {
            return "MENU_NM";
        }
    }
}