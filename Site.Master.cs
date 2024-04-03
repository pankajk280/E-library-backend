using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Library
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] != null)
            {
                if (Convert.ToInt32(Session["role"]) == 10)
                {

                }
                else
                {

                }
            }

        }

        protected void view_books(object sender, EventArgs e)
        {
            Response.Redirect("BookInventory");
        }

        protected void u_login(object sender, EventArgs e)
        {
            Response.Redirect("Login");
        }

        protected void u_signup(object sender, EventArgs e)
        {
            Response.Redirect("user_signup");
        }

        protected void u_logout(object sender, EventArgs e)
        {
            Response.Redirect("userLogin2");

        }

        protected void home_Page(object sender, EventArgs e)
        {
            Response.Redirect("Default");
        }
        protected void admin_login(object sender, EventArgs e)
        {
            Response.Redirect("AuthorLogin");
        }
    }
}