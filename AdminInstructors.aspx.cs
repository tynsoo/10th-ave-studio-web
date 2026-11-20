using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System.Configuration;

namespace _10thAveStudioWeb
{
    public partial class WebForm15 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindInstructorsData();
            }
        }

        private void BindInstructorsData()
        {
            string connectstr = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectstr))
            {
                try
                {
                    conn.Open();
                    string selectstr = @"SELECT 
                        u.FName + ' ' + u.LName AS Name, 
                        i.Specialty, 
                        i.Experience 
                    FROM 
                        Instructors i
                    JOIN 
                        Users u ON i.Users_ID = u.Users_ID
                    ORDER BY 
                        u.LName, u.FName;";

                    using (SqlCommand cmd = new SqlCommand(selectstr, conn))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable table = new DataTable();
                        int rowCount = adapter.Fill(table);

                        if (rowCount > 0)
                        {
                            ScheduleGridView.DataSource = table;
                            ScheduleGridView.DataBind();
                        }
                        else
                        {
                            // No instructors found
                            table.Rows.Add(table.NewRow());
                            ScheduleGridView.DataSource = table;
                            ScheduleGridView.DataBind();

                            // Clear the auto-generated row
                            ScheduleGridView.Rows[0].Cells.Clear();
                            ScheduleGridView.Rows[0].Cells.Add(new TableCell());
                            ScheduleGridView.Rows[0].Cells[0].ColumnSpan = ScheduleGridView.Columns.Count;
                            ScheduleGridView.Rows[0].Cells[0].Text = "No instructors registered.";
                            ScheduleGridView.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
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