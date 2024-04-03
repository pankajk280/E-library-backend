using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library.CommonClasses;

namespace Library
{
    public partial class AuthorLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public void btn_OnClick(object sender, EventArgs e)
        {
            string email = TextBox1.Text;
            string pass = TextBox3.Text;
            AdminClass admin1 = new AdminClass(email, pass);
            int mess=admin1.validateUser_Login();
            Response.Write("<script>alert('" + mess + "')</script>");
        }

    }
}