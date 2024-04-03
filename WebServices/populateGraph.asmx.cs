using Library.CommonClasses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Library.WebServices
{
    /// <summary>
    /// Summary description for populateGraph
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class populateGraph : System.Web.Services.WebService
    {

        [WebMethod]
        public List<populateGraphClass> getIssuedBooksFreq()
        {
            populateGraphClass g=new populateGraphClass();
            return g.getIssuedBooksFreq();
        }

        [WebMethod]
        public List<populateGraphClass> getBooksStocks()
        {
            populateGraphClass g=new populateGraphClass();
            return g.getStocks();
        }
    }
}
