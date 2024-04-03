using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlTypes;

namespace Library.CommonClasses
{

    public class data
    { 
        public string memberName {  get; set; } 
        public string bookName { get; set; }
        public DateTime issue_date { get; set; }
        public DateTime due_date { get; set; }  
    }
    public class bookIssueClass
    {
        public List<data> getIssuedBooks()
        {
            List<data> lst = new List<data>();
            try
            {
                using (SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    using (SqlCommand cmd = new SqlCommand("sp_getIssuedBooks", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {

                            while (reader.Read())
                            {
                                data d = new data
                                {
                                    memberName = reader.GetString(0),
                                    bookName = reader.GetString(1),
                                    issue_date =  reader.GetDateTime(2),
                                    due_date = reader.GetDateTime(3),
                                };
                                lst.Add(d);
                            }
                        }
                    }
                }
                return lst;
            }
            catch (Exception ex)
            {
                List<data> lst2 = new List<data>();
                return lst2;
            }
        }

        public void validateData(string memId,string bookId)
        {
            try
            {
                using (SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    string query = "select ,book_id from tbl_book_issue where ";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {

                    }
                }
            }
            catch (Exception ex) { }

        }
    }

    public class populateGraphClass
    {
       public string book_id { get; set; }
       public int frequency { get; set; }

       

        public List<populateGraphClass> getIssuedBooksFreq()
        {
            List<populateGraphClass> lst_frq = new List<populateGraphClass>();
            try
            {
                using(SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    string query = " select book_id,count(*) as Number_of_times_issued from tbl_book_issue group by(book_id)";
                    using(SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using(SqlDataReader reader = cmd.ExecuteReader())
                        {
                            
                            while (reader.Read())
                            {
                                populateGraphClass g= new populateGraphClass
                                {
                                    book_id=reader.GetString(0),
                                    frequency=reader.GetInt32(1)
                                };
                                lst_frq.Add(g);
                            }
                        }
                    }
                }
                return lst_frq;
            }catch (Exception ex)
            {
                return new List<populateGraphClass> { };
            }
        }


        public List<populateGraphClass> getStocks()
        {
            List<populateGraphClass> lst_frq = new List<populateGraphClass>();
            try
            {
                using (SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    string query = "select book_id,in_stock from tbl_book_master";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {

                            while (reader.Read())
                            {
                                populateGraphClass g = new populateGraphClass
                                {
                                    book_id = reader.GetString(0),
                                    frequency = reader.GetInt32(1)
                                };
                                lst_frq.Add(g);
                            }
                        }
                    }
                }
                return lst_frq;
            }
            catch (Exception ex)
            {
                return new List<populateGraphClass> { };
            }
        }
    }
}