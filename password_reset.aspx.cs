using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Library.CommonClasses;

namespace Library
{
    public partial class forgot_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string eamail = Session["user_email"].ToString();
            string uniqueKey = "";
            string db_uniqueKey = "";
            if (Request.QueryString["id"] != null)
            {
                 uniqueKey = Request.QueryString["id"].ToString();
            }
            try
            {
                
                using(SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    string query = "select TOKEN from addedNewUsers where EMAIL=@email";
                    using(SqlCommand cmd=new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@email", eamail);
                        using(SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while(reader.Read())
                            {
                                db_uniqueKey = reader.GetString(0);
                            }
                        }
                    }
                }
            }catch(Exception ex)
            {
                Response.Write(ex.Message);
            }
            if (uniqueKey != db_uniqueKey)
            {
                Response.Redirect("Login");
            }
            
            TextBox3.Text = eamail;

        }

        protected void btn_resetPass(object sender, EventArgs e)
        {

            string eamail = Session["user_email"].ToString();
            string new_pass = TextBox1.Text;
            string confirm_pass = TextBox2.Text;
            
            if(new_pass!=confirm_pass)
            {
                Response.Write("<script>Passwords do not match!!</script>");
                return;
            }
            else
            {
                string encrypt_pass=StringCipher.Encrypt(new_pass);

                try
                {

                    using (SqlConnection conn = DataBaseHelper.GetConnection())
                    {
                        string query = "update addedNewUsers set PASSWORD=@pass where EMAIL=@email";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@pass", encrypt_pass);
                            cmd.Parameters.AddWithValue("@email", eamail);
                            cmd.ExecuteNonQuery();
                            
                            Response.Redirect("Login");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }

        }
    }
}