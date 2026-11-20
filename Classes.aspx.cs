using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClasses();
            }
        }

        private void LoadClasses()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT 
                    c.Class_ID, 
                    c.Name, 
                    c.Class_Description, 
                    ISNULL(u.Fname + ' ' + u.Lname, 'No Instructor') AS Instructor_Name, 
                    ISNULL(i.Specialty, 'No Specialty') AS Specialty, 
                    c.Price
                FROM Classes c
                LEFT JOIN Instructors i ON c.Instructor_ID = i.Instructor_ID
                LEFT JOIN Users u ON i.Users_ID = u.Users_ID
                WHERE c.Name IS NOT NULL";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            // Create a DataTable to bind to GridView
                            DataTable dt = new DataTable();
                            dt.Load(reader);

                            // Extensive Debugging
                            System.Text.StringBuilder debugMessage = new System.Text.StringBuilder();
                            debugMessage.AppendLine($"Total Classes Found: {dt.Rows.Count}");
                            debugMessage.AppendLine("Columns in DataTable:");
                            foreach (DataColumn col in dt.Columns)
                            {
                                debugMessage.AppendLine($"- {col.ColumnName}");
                            }

                            // Log first few rows if any exist
                            if (dt.Rows.Count > 0)
                            {
                                debugMessage.AppendLine("\nFirst Few Rows:");
                                for (int i = 0; i < Math.Min(5, dt.Rows.Count); i++)
                                {
                                    debugMessage.AppendLine($"Row {i + 1}:");
                                    foreach (DataColumn col in dt.Columns)
                                    {
                                        debugMessage.AppendLine($"  {col.ColumnName}: {dt.Rows[i][col]}");
                                    }
                                }
                            }

                            // Update error label with debug info
                            lblError.Text = debugMessage.ToString();
                            lblError.Visible = true;

                            // Bind data to GridView
                            if (dt.Rows.Count > 0)
                            {
                                gvClasses.DataSource = dt;
                                gvClasses.DataBind();
                                lblNoClasses.Visible = false;
                            }
                            else
                            {
                                lblNoClasses.Visible = true;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Detailed error logging
                    lblError.Text = $"Error: {ex.Message}\n\nStack Trace: {ex.StackTrace}";
                    lblError.Visible = true;
                }
            }
        }

        protected void gvClasses_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Ensure description is not empty
                if (string.IsNullOrEmpty(e.Row.Cells[1].Text) || e.Row.Cells[1].Text == "&nbsp;")
                {
                    e.Row.Cells[1].Text = "<i>No description available</i>";
                }
            }
        }
    }
}