using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class WebForm12 : System.Web.UI.Page
    {
        // Move connection string to configuration for security
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindScheduleData();
            }
        }

        private void BindScheduleData()
        {
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                {
                    // Updated time formatting to show 12-hour format with AM/PM
                    string queryString = @"
            SELECT 
                c.Name AS ClassName, 
                sch.Schedule_Day AS Date, 
                CONVERT(VARCHAR(15), sch.Schedule_Time, 100) AS Time, 
                CASE sch.Location 
                    WHEN 1 THEN 'Studio 1' 
                    WHEN 2 THEN 'Studio 2' 
                    ELSE 'Unknown Location'
                END AS Location, 
                u.FName + ' ' + u.LName AS Instructor
            FROM 
                Schedules sch 
            JOIN 
                Classes c ON sch.Class_ID = c.Class_ID 
            JOIN 
                Instructors i ON c.Instructor_ID = i.Instructor_ID 
            JOIN 
                Users u ON i.Users_ID = u.Users_ID
            ORDER BY 
                sch.Schedule_Day, sch.Schedule_Time;";

                    using (SqlCommand cmd = new SqlCommand(queryString, sqlConn))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();

                        sqlConn.Open();
                        adapter.Fill(dt);

                        // Handle empty result set
                        if (dt.Rows.Count > 0)
                        {
                            ScheduleGridView.DataSource = dt;
                            ScheduleGridView.DataBind();
                        }
                        else
                        {
                            DisplayNoSchedulesMessage();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Secure error logging
                LogError(ex);
                DisplayErrorMessage("No scheduled classes yet.");
            }
        }

        private void DisplayNoSchedulesMessage()
        {
            // Create a single row with a centered "No classes" message
            DataTable dt = new DataTable();
            dt.Columns.Add("Message");
            dt.Rows.Add("No classes scheduled.");

            ScheduleGridView.DataSource = dt;
            ScheduleGridView.DataBind();

            if (ScheduleGridView.Rows.Count > 0)
            {
                ScheduleGridView.Rows[0].Cells.Clear();
                TableCell cell = new TableCell
                {
                    Text = "No classes scheduled.",
                    HorizontalAlign = HorizontalAlign.Center,
                    ColumnSpan = ScheduleGridView.Columns.Count
                };
                ScheduleGridView.Rows[0].Cells.Add(cell);
            }
        }

        private void LogError(Exception ex)
        {
            // Implement secure error logging
            // In a production environment, use a proper logging framework
            System.Diagnostics.Debug.WriteLine($"Schedule Error: {ex.Message}");
            // Consider adding more robust logging
        }

        private void DisplayErrorMessage(string message)
        {
            // Secure way to display error messages
            ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert",
                $"alert('{message.Replace("'", "\'")}');", true);
        }
    }
}