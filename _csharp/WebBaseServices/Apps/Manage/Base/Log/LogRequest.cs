using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Apps.Manage.Base.Log
{
    class LogRequest
    {
        public DataRowCollection getLogRequest(Dictionary<string, object> args)
        {           
            return NService.ClientTool.Instance.getLogRequest(args);
        } 
    }
}
