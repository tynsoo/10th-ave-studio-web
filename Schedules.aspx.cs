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
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSchedules();
            }
        }

        private void LoadSchedules(string dayFilter = "", string locationFilter = "")
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.CommandType = CommandType.Text;

                        string query = @"
                                    SELECT s.Schedule_ID, s.Schedule_Day, 
                                            s.Schedule_Time, 
                                            s.Location, 
                                            c.Name AS ClassName, u.Fname, u.Lname AS InstructorName, c.Price,
                                            c.MaxStudents,
                                            (SELECT COUNT(*) FROM Bookings b WHERE b.Schedule_ID = s.Schedule_ID) AS CurrentEnrollment
                                    FROM Schedules s
                                    INNER JOIN Classes c ON s.Class_ID = c.Class_ID
                                    INNER JOIN Instructors i ON c.Instructor_ID = i.Instructor_ID
                                    INNER JOIN Users u ON i.Users_ID = u.Users_ID
                                    WHERE 1=1";

                        if (!string.IsNullOrEmpty(dayFilter))
                        {
                            query += " AND s.Schedule_Day = @DayFilter";
                            cmd.Parameters.AddWithValue("@DayFilter", dayFilter);
                        }

                        if (!string.IsNullOrEmpty(locationFilter))
                        {
                            query += " AND s.Location = @LocationFilter";
                            // Make sure we're handling numeric conversion safely
                            int locationValue;
                            if (int.TryParse(locationFilter, out locationValue))
                            {
                                cmd.Parameters.AddWithValue("@LocationFilter", locationValue);
                            }
                            else
                            {
                                // If conversion fails, just ignore this filter
                                query = query.Replace("AND s.Location = @LocationFilter", "");
                            }
                        }

                        query += " ORDER BY s.Schedule_Day, s.Schedule_Time";
                        cmd.CommandText = query;

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        conn.Open();
                        adapter.Fill(dt);
                        conn.Close();

                        if (dt.Rows.Count > 0)
                        {
                            gvSchedules.DataSource = dt;
                            gvSchedules.DataBind();
                            lblNoSchedules.Visible = false;
                        }
                        else
                        {
                            gvSchedules.DataSource = null;
                            gvSchedules.DataBind();
                            lblNoSchedules.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error loading schedules: " + ex.Message;
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string dayFilter = ddlDay.SelectedValue;
            string locationFilter = ddlLocation.SelectedValue;
            LoadSchedules(dayFilter, locationFilter);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlDay.SelectedValue = "";
            ddlLocation.SelectedValue = "";
            LoadSchedules();
        }

        protected void gvSchedules_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Handle TIME formatting properly to avoid conversion errors
                if (e.Row.Cells[3].Text != null && e.Row.Cells[3].Text != "&nbsp;")
                {
                    try
                    {
                        // Get the TimeSpan value from the data source
                        DataRowView rowView = (DataRowView)e.Row.DataItem;
                        if (rowView["Schedule_Time"] != DBNull.Value)
                        {
                            TimeSpan time = (TimeSpan)rowView["Schedule_Time"];
                            DateTime timeAsDate = DateTime.Today.Add(time);
                            e.Row.Cells[3].Text = timeAsDate.ToString("hh:mm tt");
                        }
                    }
                    catch
                    {
                        // If parsing fails, leave the text as is
                    }
                }

                // Format the price cell
                if (e.Row.Cells.Count > 5) // Check if the Price cell exists
                {
                    try
                    {
                        DataRowView rowView = (DataRowView)e.Row.DataItem;
                        if (rowView["Price"] != DBNull.Value)
                        {
                            decimal price = Convert.ToDecimal(rowView["Price"]);
                            e.Row.Cells[5].Text = string.Format("₱{0:0.00}", price);
                        }
                    }
                    catch
                    {
                        // If formatting fails, leave the text as is
                    }
                }

                // Handle capacity display and button visibility
                DataRowView rowView2 = (DataRowView)e.Row.DataItem;
                int currentEnrollment = Convert.ToInt32(rowView2["CurrentEnrollment"]);
                int maxStudents = Convert.ToInt32(rowView2["MaxStudents"]);

                // Find the Book Now button
                Button btnBookNow = (Button)e.Row.FindControl("btnBookNow");
                if (btnBookNow != null)
                {
                    // Create a label to show the capacity
                    Label lblCapacity = new Label();
                    lblCapacity.Text = $" ({currentEnrollment}/{maxStudents})";
                    lblCapacity.CssClass = "capacity-display";

                    // Add the capacity label next to the button
                    btnBookNow.Parent.Controls.Add(lblCapacity);

                    // Disable the button if the class is full
                    if (currentEnrollment >= maxStudents)
                    {
                        btnBookNow.Enabled = false;
                        btnBookNow.Text = "Class Full";
                        btnBookNow.CssClass = "book-button disabled-button";
                    }
                }
            }
        }

        protected void btnBookNow_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string scheduleId = btn.CommandArgument;

            // Check if class is full before proceeding with booking
            string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = @"
                        SELECT 
                            c.MaxStudents,
                            (SELECT COUNT(*) FROM Bookings b WHERE b.Schedule_ID = @ScheduleID) AS CurrentEnrollment
                        FROM Schedules s
                        INNER JOIN Classes c ON s.Class_ID = c.Class_ID
                        WHERE s.Schedule_ID = @ScheduleID";

                    cmd.Parameters.AddWithValue("@ScheduleID", scheduleId);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int maxStudents = reader.GetInt32(0);
                            int currentEnrollment = reader.GetInt32(1);

                            if (currentEnrollment >= maxStudents)
                            {
                                // Class is full, show error message
                                pnlError.Visible = true;
                                lblError.Text = "Sorry, this class is already at maximum capacity.";
                                return;
                            }
                        }
                    }
                    conn.Close();
                }
            }

            // Store the selected schedule ID in session for use in the booking page
            Session["SelectedScheduleId"] = scheduleId;

            // Redirect to a booking page
            Response.Redirect("~/Booking.aspx");
        }
    }
}