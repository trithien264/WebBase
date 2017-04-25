using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;


class App
{
    public const string AppNo = "WebBase";
    public const string Key_CookieLangs = "LANGUAGE";

    //Qui định loại rewrite url cho menu
    public static DataRowCollection GetLinkKind()
    {
        DataTable dt = new DataTable();
        FnCommon.AddRow(ref dt, "aspx", "aspx");       
        return dt.Rows;
    }


    public static DataRowCollection GetLanguages()
    {
        DataTable dt = new DataTable();
        FnCommon.AddRow(ref dt, "vn", "Tiếng Việt");
        FnCommon.AddRow(ref dt, "en", "English");
        return dt.Rows;
    }
}
