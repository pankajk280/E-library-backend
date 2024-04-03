using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;



namespace Library.CommonClasses
{
    
    public enum user_type
    {
        admin = 10,
        member = 20
    }

    public class signUpdata {
    
        public string name { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string mobile { get; set; }
        public string addressLine1 { get; set; }
        public string addressLine2 { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string country { get; set; }
        public string PostalCode { get; set; }
    }


    interface IAuth
    {
        int validateUser_Login();
    }
    public static class DataBaseHelper
    {
        public static readonly string ConnectionSource = ConfigurationManager.ConnectionStrings["abc1"].ConnectionString;
        public static SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(ConnectionSource);
            conn.Open();
            return conn;
        }
    }
    public class UserClasses : IAuth
    {
        string Name;
        string email;
        string password;
        string addressLine1;
        string addressLine2;
        string City;
        string State;
        string Country;
        string postalCode;
        string mobile;

        public bool checkUser(string email)
        {
            try
            {

                using (SqlConnection conn = DataBaseHelper.GetConnection())
                {

                    string query = "Select * from addedNewUsers where email=@email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@email", email);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                return false;
                            }
                            else
                            {
                                return true;
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public string validateUser_SignUp(signUpdata data)
        {

            if (checkUser(data.email))
            {
                string encrypted_pass=StringCipher.Encrypt(data.password);
                try
                {

                    using (SqlConnection con = DataBaseHelper.GetConnection())
                    {

                        string query = "INSERT INTO addedNewUsers(NAME,EMAIL,MOBILE_NO,PASSWORD,USER_TYPE,AddressLine1,AddressLine2,CITY,STATE,COUNTRY,POSTAL_PINCODE,MAIL_SENT,LOGIN_COUNT) " +
                            "values(@name,@email,@mobile,@password,@user_type,@addressLine1,@addressLine2,@city,@state,@country,@postal,1,0);";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@name",data.name);
                            cmd.Parameters.AddWithValue("@email", data.email);
                            cmd.Parameters.AddWithValue("@password", encrypted_pass);
                            cmd.Parameters.AddWithValue("@user_type", (int)user_type.member);
                            cmd.Parameters.AddWithValue("mobile", data.mobile);
                            cmd.Parameters.AddWithValue("@addressLine1",data.addressLine1);
                            cmd.Parameters.AddWithValue("@addressLine2", data.addressLine2);
                            cmd.Parameters.AddWithValue("@city", data.city);
                            cmd.Parameters.AddWithValue("@state",data.state);
                            cmd.Parameters.AddWithValue("@country", data.country);
                            cmd.Parameters.AddWithValue("@postal", data.PostalCode);
                            cmd.ExecuteNonQuery();
                            return "Account Successfully Created!";
                        }
                    }
                }
                catch (Exception EX)
                {
                    return EX.Message;
                }
            }
            else
            {
                return "User Already Exists!";
            }

        }
        public int validateUser_Login()
        {


            try
            {
                using (SqlConnection con = DataBaseHelper.GetConnection())
                {
                    string query = "select user_type from addedNewUsers where EMAIL=@email and PASSWORD=@password";
                    int user_t = 0;
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {

                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@password", password);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                user_t=reader.GetInt32(0);
                            }
                        }
                    }
                    return user_t;
                }
            }
            catch (Exception ex)
            {
                return 101;
            }
        }
        
        

    }
    public class AdminClass : IAuth
    {

        string email;
        string Password;
        public int validateUser_Login()
        {
            try
            {
               
                using (SqlConnection con = DataBaseHelper.GetConnection())
                {
                   
                    string query = "select user_type from tb_signup where EMAIL=@email and PASSWORD=@password";
                    int user_t = 0;
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {

                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@password", Password);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                user_t = reader.GetInt32(0);

                            }

                        }

                    }
                    return 0;
                }
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
        public AdminClass(string email, string password)
        {
            this.email = email;
            this.Password = password;
        }

    }
    public static class StringCipher
    {
        public static string Encrypt(string clearText)
        {
            string EncryptionKey = "abc123";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }
        public static string Decrypt(string cipherText)
        {
            string EncryptionKey = "abc123";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }
    }

    public static class saltClass
    {
        public const string salt = "QWERTYSINGH";
    }
}