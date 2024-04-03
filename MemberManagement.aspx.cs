using Library.CommonClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Library
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Button2.Visible = false;
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            /*string folderPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);*/
            string filePath = Path.Combine(@"C:\Users\Xoro User\source\repos\Library\Library\DataFile\", "Member Details.csv");
            try
            {

                using (SqlConnection conn = DataBaseHelper.GetConnection())
                {

                    string query = "Select * from tb_signup where user_type=20 order by ID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                DataTable TB = new DataTable();
                                TB.Load(reader);
                                StreamWriter sw = new StreamWriter(filePath,false);
                                
                                    for(int i = 0; i < TB.Columns.Count; i++)
                                    {
                                        sw.Write(TB.Columns[i].ToString());
                                        if(i<TB.Columns.Count - 1)
                                        {
                                            sw.Write(",");
                                        }
                                       
                                    }
                                        sw.Write(sw.NewLine);
                                    foreach(DataRow dr in TB.Rows)
                                    {
                                        for(int i = 0; i < TB.Columns.Count; i++)
                                        {
                                            string val = dr[i].ToString();
                                            if (val.Contains(","))
                                            {
                                                val = String.Format("\"{0}\"", val);
                                                sw.Write(val);
                                            }
                                            else
                                            {
                                                sw.Write(dr[i].ToString());
                                            }
                                            if (i < TB.Columns.Count - 1)
                                            {
                                                sw.Write(",");
                                            }

                                        }
                                        sw.Write(sw.NewLine);
                                        
                                    }
                                    sw.Close();                           
                            }
                            else
                            {
                                Response.Write("There is some error while fetching data!");
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                return;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string userId=TextBox1.Text;
            Button2.Visible = true;
            if (userId == "")
            {
                try
                {

                    using (SqlConnection conn = DataBaseHelper.GetConnection())
                    {

                        string query = "Select Name,ID,EMAIL from tb_signup where user_type=20 order by ID";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if(reader.HasRows)
                                {
                                    DataTable TB= new DataTable();
                                    TB.Load(reader);
                                    GridView2.DataSource = TB;
                                    GridView2.DataBind();
                                }
                            }
                        }

                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message); 
                    return;
                }
            }
            else
            {


            }
            
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            var rowNumber = 0;
            try
            {
                using(SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    string folderPath = HttpContext.Current.Request.PhysicalApplicationPath; 
                    string uploadedFileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                    string uploadedFileDirectory = Path.GetDirectoryName(FileUpload1.PostedFile.FileName);
                    string fullFilePath = Path.Combine(folderPath, uploadedFileDirectory, uploadedFileName); 

                   

                    using ( StreamReader rd = new StreamReader(fullFilePath)) 
                    {
                        string query = "INSERT INTO tb_signup(NAME,EMAIL,PASSWORD,user_type) values(@name,@email,@password,20)";
                        while (!rd.EndOfStream)
                        {
                            var line=rd.ReadLine();
                            if (rowNumber != 0)
                            {
                                var val=line.Split(',');
                                string encrypted_pass = StringCipher.Encrypt(val[2].ToString());
                                using(SqlCommand cmd = new SqlCommand(query,conn))
                                {
                                    cmd.Parameters.AddWithValue("@name", val[0].ToString());
                                    cmd.Parameters.AddWithValue("@email", val[1].ToString());
                                    cmd.Parameters.AddWithValue("@password", encrypted_pass);
                                    cmd.ExecuteReader();
                                    Response.Write("Data Successfully Inserted");
                                }
                            }
                            rowNumber++;
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}