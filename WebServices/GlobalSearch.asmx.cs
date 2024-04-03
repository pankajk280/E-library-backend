using Library.CommonClasses;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Library.WebServices
{
    /// <summary>
    /// Summary description for GlobalSearch
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class GlobalSearch : System.Web.Services.WebService
    {

        [WebMethod]
        public List<globalSearch> Search(string inputVal)
        {
            globalSearch g=new globalSearch();
            return g.search(inputVal);
        }
    }
}
