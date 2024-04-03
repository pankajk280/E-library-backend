using Library.CommonClasses;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Services;
using static Library.Forgot_Password;
using System.Web.UI.WebControls;
using System.Threading;
using Newtonsoft.Json;
using System.Threading.Tasks;
using System.Net;
using System.Net.Http;


namespace Library
{
    /// <summary>
    /// Summary description for CreateUser
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class CreateUser : System.Web.Services.WebService
    {

        [WebMethod]
        public string insertData(string userData)
        {
            userDetails user=new userDetails();
            user = JsonConvert.DeserializeObject<userDetails>(userData);
            CreateUserClass u=  new CreateUserClass();
            return u.insertData(user);
        }
        
        [WebMethod]
        public object Login(string userData)
        {
            userDetails ud = new userDetails();
            ud = JsonConvert.DeserializeObject<userDetails>(userData);
            CreateUserClass u1 = new CreateUserClass();
            CreateUserClass data= new CreateUserClass();
            data=u1.login(ud);
            return data;
        }
        [WebMethod]
        public string reset_password(string password,string email_id)
        {
            CreateUserClass u1 = new CreateUserClass();
            return u1.updatePass(password,email_id);
        }

        [WebMethod]
        public List<tblData> getData()
        {
           CreateUserClass u1=new CreateUserClass();
           return u1.getData();
        }

        [WebMethod]
        public string validateAddress(string addressData)
        {
            validateAddressDataClass v1=new validateAddressDataClass();
            v1=JsonConvert.DeserializeObject<validateAddressDataClass>(addressData);
            validateAddressClass validates=new validateAddressClass();
            return validates.validateAddress(v1);
        }

        [WebMethod]
        public string signUp(string userData)
        {
            signUpdata d1=new signUpdata();
            d1=JsonConvert.DeserializeObject<signUpdata>(userData);
            UserClasses u1 = new UserClasses();
            return u1.validateUser_SignUp(d1);
            
        }
    }
    

}
