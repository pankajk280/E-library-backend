using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;

namespace Library.CommonClasses
{
    public class members
    {
        public string email { get; set; }
        public  int fine { get; set; }
    }

    public class defClass
    {
        public string member_name { get; set; }
        public string book_name { get; set; }
        public string Email { get; set; }
        public int totalDays { get; set; }
        public int fine { get; set; }

    }
    public class defaultersClass
    {
        
        public List<defClass> getDefaulters()
        {
            List<defClass> list = new List<defClass>(); 
            try
            {
                using (SqlConnection con = DataBaseHelper.GetConnection())
                {
                    using(SqlCommand cmd=new SqlCommand("sp_Defaulters", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        using(SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                defClass d = new defClass
                                {
                                    member_name = reader.GetString(0),
                                    book_name = reader.GetString(1),
                                    Email = reader.GetString(2),
                                    totalDays = reader.GetInt32(3),
                                    fine=reader.GetInt32(4)
                                };
                                list.Add(d);
                            }
                            
                        }
                    }
                }
                return list;
            }
            catch (Exception ex) {
                return new List<defClass>();
            }
        }

        public void sendMailFun(string email, int fine)
        {

            string smtpHost = "smtp.gmail.com";
            int smtpPort = 587;
            string smtpUserName = "pankaj.kumar@xorosoft.com";
            string smtpPassword = "Rahul@aps1";
            string subject = "Book Due Date Passed!!";
            string body = $"Your libray due date has passed and You need to Pay fine of Rs. {fine}" + "<br>" +
                "For more details log in to your account.";

            using (MailMessage ms = new MailMessage())
            {
                ms.From = new MailAddress(smtpUserName);
                ms.To.Add(email);
                ms.Subject = subject;
                ms.Body = body;
                ms.IsBodyHtml = true;

                using (SmtpClient smtp = new SmtpClient(smtpHost, smtpPort))
                {
                    smtp.Credentials = new NetworkCredential(smtpUserName, smtpPassword);
                    smtp.EnableSsl = true;
                    smtp.Send(ms);
                }
            }

        }

        public string sendMail(List<members> lst)
        {
            foreach (members member in lst)
            {
                sendMailFun(member.email, member.fine);
            }
            return "Success";
        }

        public string deleteDefaulters(string email)
        {
            try
            {
                using (SqlConnection con = DataBaseHelper.GetConnection())
                {
                    using (SqlCommand cmd = new SqlCommand("deleteDefaulters", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@email", SqlDbType.VarChar,250).Value=email;
                        cmd.ExecuteNonQuery();
                    }
                }
                return "Deleted";
            }catch (Exception ex)
            {
                return ex.Message;
            }
        }

    }

   

}