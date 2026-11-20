using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace _10thAveStudioWeb
{
    public partial class WebForm11 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectstr = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectstr))
            {
                try
                {
                    conn.Open();
                    string selectstr = "SELECT Name AS [Class Name], Class_Description AS [Style Type], Price AS [Class Price] FROM Classes;";

                    using (SqlCommand cmd = new SqlCommand(selectstr, conn))
                    {
                        SqlDataAdapter cmdadapter = new SqlDataAdapter(cmd);
                        DataTable table = new DataTable();
                        int rowCount = cmdadapter.Fill(table);

                        if (rowCount > 0)
                        {
                            GridView1.DataSource = table;
                            GridView1.DataBind();
                        }
                        else
                        {
                            // No classes found
                            table.Rows.Add(table.NewRow());
                            GridView1.DataSource = table;
                            GridView1.DataBind();

                            // Clear the auto-generated row
                            GridView1.Rows[0].Cells.Clear();
                            GridView1.Rows[0].Cells.Add(new TableCell());
                            GridView1.Rows[0].Cells[0].ColumnSpan = GridView1.Columns.Count;
                            GridView1.Rows[0].Cells[0].Text = "No classes being offered.";
                            GridView1.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the error or display a user-friendly message
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }
    }
}