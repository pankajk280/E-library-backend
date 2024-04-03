using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Text;
using System.IO;

namespace Library.CommonClasses
{


    public enum status_codes
    {
        First_login=1,
        Invalid_cred=400,
        OK=100,
        BAD=500
    };

    public class userDetails
    {
        public string name {  get; set; }
        public string email { get; set;}
        public string pass { get; set;}
        public string phone { get; set;}
        public string state { get; set; }
        public string city { get; set; }
        public string postal_code { get; set; }
    }

    public class tblData:userDetails
    {

    }

    
    public class CreateUserClass
    {
        public int role { get; set; }
        public int status { get; set; } 

        public void updateCount(string email)
        {
            try
            {
                using (SqlConnection con = DataBaseHelper.GetConnection())
                {
                    string query = "update addedNewUsers set LOGIN_COUNT=1";
                    using(SqlCommand cmd=new SqlCommand(query, con))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }
            }catch(Exception ex)
            {
                
            }
        }

        public string GeneratePass()
        {
            Random rndm = new Random();
            string txt = "ABCDEFGHIJKLPQRSTUVWXYZ0123456789";
            int size = 16;
            string pass = "";
            for (int i = 0; i < size; i++)
            {
                int ind = rndm.Next(txt.Length);
                pass += txt[ind];
            }
            return pass;


        }

        public string sendMail(string email, string pass)
        {
           
            string smtpHost = "smtp.gmail.com";
            int smtpPort = 587;
            string smtpUserName = "pankaj.kumar@xorosoft.com";
            string smtpPassword = "Rahul@aps1";
            string resetpasswordUrl = $"https://localhost:44305/Login?id=";
            string subject = "Congratulations! Account Created Successfully";
            string body = $"Click here to login : {resetpasswordUrl}" + "<br>" +
                $"Your Password is : {pass}";
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
                    return "Success!!";
                }
            }

        }

        public string insertData(userDetails userData)
        {
            string name = userData.name;
            string email=userData.email;
            string phone=userData.phone;
            string state=userData.state;
            string city=userData.city;
            string postal_code = userData.postal_code;
            string dummy_password = GeneratePass();
            string encrypted_pass = StringCipher.Encrypt(dummy_password);


            try
            {

                using (SqlConnection con = DataBaseHelper.GetConnection())
                {
                    string query = "insert into addedNewUsers(NAME,EMAIL,MOBILE_NO,PASSWORD,USER_TYPE,STATE,CITY,POSTAL_PINCODE,MAIL_SENT,LOGIN_COUNT) Values(@name,@email,@mobile,@pass,20,@state,@city,@postal,1,0)";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@mobile", phone);
                        cmd.Parameters.AddWithValue("@pass", encrypted_pass);
                        cmd.Parameters.AddWithValue("@state",state);
                        cmd.Parameters.AddWithValue("@city",city);
                        cmd.Parameters.AddWithValue("@postal", postal_code);
                        cmd.ExecuteNonQuery();
                        return "SUCCESS";
                    }
                }

            }
            catch (Exception e)
            {
                return e.Message;
            }
            finally
            {
                sendMail(email, dummy_password);

            }
        }



        public CreateUserClass login(userDetails userDet)
        {
            string normal_pass = "";
            string decrypted_pass = "";
            int userType;
            string email = userDet.email;
            string pass = userDet.pass;
            try
            {
                using (SqlConnection con = DataBaseHelper.GetConnection())
                {
                    string query = "select PASSWORD,LOGIN_COUNT,USER_TYPE from addedNewUsers where EMAIL=@email";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@email", email);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                int count = reader.GetInt32(1);
                                normal_pass = reader.GetString(0);
                                userType = reader.GetInt32(2);
                                decrypted_pass = StringCipher.Decrypt(normal_pass);
                                if (decrypted_pass == pass)
                                {
                                    if (count == 0)
                                    {
                                        return new CreateUserClass()
                                        {
                                            status = 100,
                                            role=0
                                        };
                                    }
                                    else
                                    {
                                        return new CreateUserClass()
                                        {
                                            status = 200,
                                            role = userType
                                        };
                                    }
                                }
                            }
                        }
                    }
                }
                return new  CreateUserClass()
                {
                    status = 400,
                    role = 0
                }; 
            }
            catch (Exception ex)
            {
                return new CreateUserClass()
                {
                    status = 200,
                    role = 0
                }; 
            }
            
        }

        public string updatePass(string pass,string email_id)
        {
            try
            {
                using(SqlConnection con = DataBaseHelper.GetConnection())
                {
                    string query = "select PASSWORD from addedNewUsers where EMAIL=@email";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                       
                        cmd.Parameters.AddWithValue("@email", email_id);

                        using(SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string password=reader.GetString(0);
                                string dec_pass=StringCipher.Decrypt(password);

                                if(dec_pass== pass)
                                {
                                    return "SAME PASSWORD";
                                }
                            }
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                return ex.Message;
            }
            string encrypted_pass=StringCipher.Encrypt(pass);

            try
            {
                using(SqlConnection con = DataBaseHelper.GetConnection())
                {
                    string query = "update addedNewUsers set PASSWORD=@pass,LOGIN_COUNT=2 where EMAIL=@email";
                    using(SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@pass", encrypted_pass);
                        cmd.Parameters.AddWithValue("@email", email_id);
                        cmd.ExecuteNonQuery();
                        return "success";
                    }
                }
            }catch (Exception ex)
            {
                return ex.Message;
            }
        }
        
        public List<tblData> getData()
        {
            List<tblData> data = new List<tblData>();
            tblData d1= new tblData();
            try
            {

                using(SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    string query = "Select NAME,EMAIL,MOBILE_NO,STATE,CITY,POSTAL_PINCODE from addedNewUsers";
                    using (SqlCommand cmd= new SqlCommand(query, conn))
                    {
                        using(SqlDataReader r = cmd.ExecuteReader())
                        {
                            while(r.Read())
                            {
                                tblData d = new tblData
                                {
                                    name = r.GetString(0),
                                    email = r.GetString(1),
                                    phone = r.GetString(2),
                                    state = r.GetString(3),
                                    city = r.GetString(4),
                                    postal_code = r.GetString(5),
                                };
                                data.Add(d);
                            }
                        }
                    }
                }
                return data;

            }catch(Exception ex)
            { 
                return new List<tblData>();
            }
        }

    }

    class validateAddressDataClass
    {
        public string addressLine1 { get; set; }
        public string addressLine2 { get; set;}
        public string City { get; set;}
        public string State { get; set;}    
        public string Country { get; set;}
        public string PostalCode { get; set;}
    }
    class validateAddressClass
    {
        public string validateAddress(validateAddressDataClass address)
        {
            string apiUrl = "https://api.postgrid.com/v1/addver/suggestions?includeDetails=true";
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(apiUrl);
            request.Method = "POST";
            request.Headers.Add("x-api-key", "live_sk_2JxgJDEHAm5HaTAQ3ug4BU");
            string postData = $"address[line1]={address.addressLine1}" +
                          $"&address[line2]={address.addressLine2}" +
                          $"&address[city]={address.City}" +
                          $"&address[postalOrZip]={address.PostalCode}" +
                          $"&address[provinceOrState]={address.State}" +
                          $"&address[country]={address.Country}";
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }
            using (WebResponse response = request.GetResponse())
            {

                using (Stream responseStream = response.GetResponseStream())
                {
                    using (StreamReader reader = new StreamReader(responseStream))
                    {
                        string responseText = reader.ReadToEnd();
                        return responseText;
                    }
                }
            }
        }
    }
}

