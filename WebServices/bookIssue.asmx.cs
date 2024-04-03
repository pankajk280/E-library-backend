using Library.CommonClasses;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace Library.WebServices
{
    /// <summary>
    /// Summary description for bookIssue
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class bookIssue : System.Web.Services.WebService
    {

        [WebMethod]
        public List<defClass> GetDefaulters()
        {
            defaultersClass d1=new defaultersClass();
            return d1.getDefaulters();
            
        }

        [WebMethod]
        public string mailService(string objEmail)
        {
           
            List<members> memberslst = JsonConvert.DeserializeObject<List<members>>(objEmail);
            defaultersClass m1= new defaultersClass();
            return m1.sendMail(memberslst);
        }

        [WebMethod]
        public List<data> getIssuedBookServ()
        {
            bookIssueClass d1 = new bookIssueClass(); 
            return d1.getIssuedBooks();
        }
        [WebMethod]
        public void validateDetails(string memId,string bookId)
        {

        }
        [WebMethod]
        public string DeleteDefaulters( string defaultersEmail)
        {
            defaultersClass d1 = new defaultersClass();
            return d1.deleteDefaulters(defaultersEmail);

        }

        /*[WebMethod]*/

       /* public string saveDescription()
        {

        }*/

    }
}
