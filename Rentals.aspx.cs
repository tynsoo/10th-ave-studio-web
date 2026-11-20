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
    public partial class WebForm7 : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["Users_ID"] == null)
            {
                // Redirect to login page if not logged in
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Disable past dates
                RentalCalendarControl.VisibleDate = DateTime.Today;
                BookingPanel.Visible = false;
            }
        }

        protected void RentalCalendarControl_DayRender(object sender, DayRenderEventArgs e)
        {
            // Disable past dates
            if (e.Day.Date < DateTime.Today)
            {
                e.Cell.CssClass += " unavailable-date";
                e.Day.IsSelectable = false;
            }

            // Check if date is already booked
            if (IsDateBooked(e.Day.Date))
            {
                e.Cell.CssClass += " unavailable-date";
                e.Day.IsSelectable = false;
            }
            else
            {
                e.Cell.CssClass += " available-date";
            }
        }

        protected void RentalCalendarControl_SelectionChanged(object sender, EventArgs e)
        {
            // Show booking panel when a date is selected
            BookingPanel.Visible = true;

            // Reset previous messages
            lblMessage.Text = string.Empty;
            lblMessage.CssClass = "text-center";
        }

        protected void BookRental_Click(object sender, EventArgs e)
        {
            // Validate page
            if (!Page.IsValid)
            {
                return;
            }

            // Ensure user is logged in
            if (Session["Users_ID"] == null)
            {
                lblMessage.CssClass = "text-danger text-center";
                lblMessage.Text = "Please log in to book a rental.";
                return;
            }

            try
            {
                // Get selected date and input values
                DateTime selectedDate = RentalCalendarControl.SelectedDate;
                string eventTitle = txtEventTitle.Text.Trim();
                TimeSpan eventTime = TimeSpan.Parse(txtEventTime.Text);

                // Check if date is still available
                if (IsDateBooked(selectedDate))
                {
                    lblMessage.CssClass = "text-danger text-center";
                    lblMessage.Text = "Sorry, this date is no longer available.";
                    return;
                }

                // Insert rental into database
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Use parameterized query to prevent SQL injection
                    string query = @"
                        INSERT INTO Rentals 
                        (Users_ID, EventTitle, RentalDate, RentalTime) 
                        VALUES 
                        (@UserId, @EventTitle, @RentalDate, @RentalTime)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters
                        int currentUserId = Convert.ToInt32(Session["Users_ID"]);
                        command.Parameters.Add("@UserId", SqlDbType.Int).Value = currentUserId;
                        command.Parameters.Add("@EventTitle", SqlDbType.NVarChar, 100).Value = eventTitle;
                        command.Parameters.Add("@RentalDate", SqlDbType.Date).Value = selectedDate;
                        command.Parameters.Add("@RentalTime", SqlDbType.Time).Value = eventTime;

                        // Execute insert
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Success message and show JavaScript alert
                            ScriptManager.RegisterStartupScript(this, this.GetType(),
                                "BookingConfirmation",
                                $"alert('Rental booked successfully for {eventTitle} on {selectedDate.ToShortDateString()} at {eventTime}!');",
                                true);

                            // Success message on page
                            lblMessage.CssClass = "text-success text-center";
                            lblMessage.Text = "Rental booked successfully!";

                            // Clear input fields
                            txtEventTitle.Text = string.Empty;
                            txtEventTime.Text = string.Empty;
                            BookingPanel.Visible = false;
                        }
                        else
                        {
                            // Error message if no rows were inserted
                            lblMessage.CssClass = "text-danger text-center";
                            lblMessage.Text = "Failed to book rental. Please try again.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the full exception details (in a real application)
                lblMessage.CssClass = "text-danger text-center";
                lblMessage.Text = "An error occurred: " + ex.Message;
            }
        }

        private bool IsDateBooked(DateTime date)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM Rentals WHERE RentalDate = @Date";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Date", SqlDbType.Date).Value = date;
                    int count = Convert.ToInt32(command.ExecuteScalar());
                    return count > 0;
                }
            }
        }
    }
}