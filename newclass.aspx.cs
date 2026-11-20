using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class WebForm13 : System.Web.UI.Page
    {
        // Move connection string to web.config for security
        private readonly string _connectionString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                submit.Enabled = false;
                LoadClassesGrid();
            }
        }

        private void LoadClassesGrid()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    // Use parameterized query to prevent SQL injection
                    string selectStr = @"
                        SELECT 
                            c.Class_ID AS [Class ID], 
                            c.Name AS [Class Name], 
                            c.Class_Description AS [Style Type],
                            u.FName + ' ' + u.LName AS [Instructor],
                            c.Price AS [Price],
                            c.MaxStudents AS [Max Students]
                        FROM 
                            Classes c
                        LEFT JOIN 
                            Instructors i ON c.Instructor_ID = i.Instructor_ID
                        LEFT JOIN 
                            Users u ON i.Users_ID = u.Users_ID;";

                    using (SqlDataAdapter cmdAdapter = new SqlDataAdapter(selectStr, conn))
                    {
                        DataTable table = new DataTable();
                        cmdAdapter.Fill(table);

                        GridView1.DataSource = table;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the actual error securely
                LogError(ex);
                ShowErrorMessage("An error occurred while loading classes.");
            }
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate input before using
                if (!int.TryParse(Class_ID.Text, out int classId))
                {
                    ShowErrorMessage("Please enter a valid Class ID.");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    // Use parameterized query to prevent SQL injection
                    string selectCmd = @"
                        SELECT c.*, 
                               u.FName + ' ' + u.LName AS InstructorName 
                        FROM Classes c
                        LEFT JOIN Instructors i ON c.Instructor_ID = i.Instructor_ID
                        LEFT JOIN Users u ON i.Users_ID = u.Users_ID
                        WHERE c.Class_ID = @ClassID;";

                    using (SqlCommand cmd = new SqlCommand(selectCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@ClassID", classId);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                submit.Enabled = true;
                            }
                            else
                            {
                                ShowErrorMessage("Class not found");
                                submit.Enabled = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                ShowErrorMessage("An error occurred while searching for the class.");
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            // Validate inputs
            if (!ValidateInputs())
            {
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    // Use parameterized query to prevent SQL injection
                    string insertCmd = @"
                        INSERT INTO Schedules 
                        (Class_ID, Schedule_Day, Schedule_Time, Location) 
                        VALUES 
                        (@ClassID, @ScheduleDay, @ScheduleTime, @Location);";

                    using (SqlCommand cmd = new SqlCommand(insertCmd, conn))
                    {
                        cmd.Parameters.AddWithValue("@ClassID", int.Parse(Class_ID.Text));
                        cmd.Parameters.AddWithValue("@ScheduleDay", Date.Text);
                        cmd.Parameters.AddWithValue("@ScheduleTime", TimeSpan.Parse(Time.Text));
                        cmd.Parameters.AddWithValue("@Location", GetLocationCode(Location.Text));

                        cmd.ExecuteNonQuery();
                    }

                    ShowSuccessMessage("Class scheduled successfully!");
                    ClearInputFields();
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                ShowErrorMessage("Error scheduling class: " + ex.Message);
            }
        }

        private bool ValidateInputs()
        {
            // Comprehensive input validation
            if (string.IsNullOrWhiteSpace(Class_ID.Text))
            {
                ShowErrorMessage("Please select a class.");
                return false;
            }

            if (string.IsNullOrWhiteSpace(Date.Text))
            {
                ShowErrorMessage("Please enter a date.");
                return false;
            }

            if (string.IsNullOrWhiteSpace(Time.Text))
            {
                ShowErrorMessage("Please enter a time.");
                return false;
            }

            if (string.IsNullOrWhiteSpace(Location.Text))
            {
                ShowErrorMessage("Please enter a location.");
                return false;
            }

            return true;
        }

        private byte GetLocationCode(string location)
        {
            // Convert location to appropriate code
            // Assuming locations are either "Studio 1" or "Studio 2"
            return location.Contains("1") ? (byte)1 : (byte)2;
        }

        private void ShowErrorMessage(string message)
        {
            // Secure way to show error messages
            ScriptManager.RegisterStartupScript(this, GetType(), "ErrorAlert",
                $"alert('{message.Replace("'", "\'")}');", true);
        }

        private void ShowSuccessMessage(string message)
        {
            // Secure way to show success messages
            ScriptManager.RegisterStartupScript(this, GetType(), "SuccessAlert",
                $"alert('{message.Replace("'", "\'")}');", true);
        }

        private void ClearInputFields()
        {
            // Clear input fields after successful submission
            Class_ID.Text = "";
            Date.Text = "";
            Time.Text = "";
            Location.Text = "";
            submit.Enabled = false;
        }

        private void LogError(Exception ex)
        {
            // Implement proper error logging
            // This could be to a file, database, or logging service
            System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}\nStack Trace: {ex.StackTrace}");
        }
    }
}