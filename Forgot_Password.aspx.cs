using System;
using System.Net;
using System.Net.Mail;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.SqlClient;
using Library.CommonClasses;

namespace Library
{
    public partial class Forgot_Password : System.Web.UI.Page
    {

        public static class uniqueId
        {
            public static string id =Guid.NewGuid().ToString();
        }
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void reset_pass(object sender, EventArgs e)
        {
            string email_id = TextBox1.Text;
           /* Session["user_email"]=email_id;*/
            string smtpHost = "smtp.gmail.com";
            int smtpPort = 587;
            string smtpUserName = "pankaj.kumar@xorosoft.com";
            string smtpPassword = "Rahul@aps1";
            string resetpasswordUrl = $"https://localhost:44305/password_reset?id={uniqueId.id}";
            try
            {
                using(SqlConnection con =DataBaseHelper.GetConnection())
                {
                    string query = "update addedNewUsers set TOKEN=@id where EMAIL=@email";
                    using(SqlCommand cmd = new SqlCommand(query,con))
                    {
                        cmd.Parameters.AddWithValue("@email", email_id);
                        cmd.Parameters.AddWithValue("@id", uniqueId.id);
                        cmd.ExecuteNonQuery();
                    }
                }
            }catch (Exception ex)
            {
                Response.Write("<script>alert('"+ex.Message+"')</script>");
            }

            string subject = "Reset Your Password";
            string body = $"Click here to reset your password : {resetpasswordUrl}";
            using(MailMessage ms=new MailMessage())
            {
                ms.From=new MailAddress(smtpUserName);
                ms.To.Add(email_id);
                ms.Subject = subject;
                ms.Body = body;
                ms.IsBodyHtml = true;
                
                using(SmtpClient smtp = new SmtpClient(smtpHost,smtpPort))
                {
                    smtp.Credentials = new NetworkCredential(smtpUserName, smtpPassword);
                    smtp.EnableSsl = true;
                    smtp.Send(ms);
                    Response.Write("<script>alert('Please Check your Email!!')</script>");
                }
            }

        }
    }
}