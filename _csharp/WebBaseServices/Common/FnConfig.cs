using NService.Tools;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WebBaseServices.Common
{
    class FnConfig
    {
        public static Dictionary<string, object> dicApps()
        {
            Dictionary<string, object> dicApps = SystemConfig.Instance.Get<Dictionary<string, object>>("Apps");
            return dicApps;            
        }

        public static Dictionary<string, object> dicApps(string key)
        {
            return (Dictionary<string, object>)dicApps()[key];
        }



        public static string getFileConfig(string folder,string file)
        {
            FileConfig _fileTemplate = new FileConfig(folder, new TextParser());
            return _fileTemplate.Parse<string>(file);
             
        }

        

    }
}
