using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Library.CommonClasses
{
    public class globalSearch
    {
        public string suggestion { get; set; }
        public string link { get; set; }
        public string type { get; set; }

        public List<globalSearch> search(string inpt)
        {
            List<globalSearch> searchList = new List<globalSearch>();
            try
            {
                using(SqlConnection conn = DataBaseHelper.GetConnection())
                {
                    string query = "select book_name,'BookName' as Type,suggestions " +
                        "from tbl_book_master where book_name like @input  union " +
                        " select links,'Link' as Type,suggestions from tbl_links where suggestions like @input";
                    using(SqlCommand cmd = new SqlCommand(query,conn))
                    {
                        cmd.Parameters.AddWithValue("@input","%"+inpt+"%");
                        using(SqlDataReader reader = cmd.ExecuteReader())
                        {
                          
                            while (reader.Read())
                            {
                                globalSearch search = new globalSearch
                                {
                                    link = reader.GetString(0),
                                    type = reader.GetString(1),
                                    suggestion = reader.GetString(2)
                                };
                                searchList.Add(search);
                            }
                        }
                    }
                }
                return searchList;
            }catch (Exception ex)
            {
                return new List<globalSearch>();
            }
        }


    }
}