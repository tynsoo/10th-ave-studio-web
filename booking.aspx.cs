using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
	public partial class WebForm17 : System.Web.UI.Page
    {
        private string scheduleId = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if a schedule ID is available in the session
                if (Session["SelectedScheduleId"] != null)
                {
                    string scheduleId = Session["SelectedScheduleId"].ToString();

                    // Call the method to load class details
                    LoadClassDetails(scheduleId);
                }
                else
                {
                    // If no schedule ID is found, show an error message
                    ShowErrorMessage("No class schedule selected.");
                }
            }
        }

        private void LoadClassDetails(string scheduleId)
        {
            string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.CommandText = @"
                    SELECT s.Schedule_Day, s.Schedule_Time, 
                           s.Location, c.Price,
                           c.Name AS ClassName, u.Fname + ' ' + u.Lname AS InstructorName
                    FROM Schedules s
                    INNER JOIN Classes c ON s.Class_ID = c.Class_ID
                    INNER JOIN Instructors i ON c.Instructor_ID = i.Instructor_ID
                    INNER JOIN Users u ON i.Users_ID = u.Users_ID
                    WHERE s.Schedule_ID = @ScheduleID";

                        cmd.Parameters.AddWithValue("@ScheduleID", scheduleId);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblClassName.Text = reader["ClassName"].ToString();
                                lblInstructor.Text = reader["InstructorName"].ToString();
                                lblDay.Text = reader["Schedule_Day"].ToString();

                                // Format time
                                TimeSpan time = (TimeSpan)reader["Schedule_Time"];
                                DateTime timeAsDate = DateTime.Today.Add(time);
                                lblTime.Text = timeAsDate.ToString("hh:mm tt");

                                lblLocation.Text = "Studio " + reader["Location"].ToString();

                                // Format price
                                if (reader["Price"] != DBNull.Value)
                                {
                                    decimal price = Convert.ToDecimal(reader["Price"]);
                                    lblPrice.Text = string.Format("₱{0:0.00}", price);
                                }
                                else
                                {
                                    lblPrice.Text = "₱0.00";
                                }
                            }
                            else
                            {
                                ShowErrorMessage("No class details found for the selected schedule.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowErrorMessage("Error loading class details: " + ex.Message);
            }
        }

        protected void btnBookNow_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                // Check if user is logged in
                if (Session["Users_Id"] == null)
                {
                    ShowErrorMessage("Please log in to complete your booking.");
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Retrieve user ID
                string userId = Session["Users_Id"].ToString();

                // Check if schedule is selected
                if (Session["SelectedScheduleId"] == null)
                {
                    ShowErrorMessage("No class schedule has been selected.");
                    Response.Redirect("Schedules.aspx");
                    return;
                }

                string scheduleId = Session["SelectedScheduleId"].ToString();
                string paymentReference = txtPaymentRef.Text.Trim();

                // Check if payment reference is unique
                if (IsPaymentReferenceExist(paymentReference))
                {
                    ShowErrorMessage("This payment reference has already been used.");
                    return;
                }

                // Upload payment proof
                string paymentProofPath = UploadPaymentProof();

                // Save booking
                SaveBooking(scheduleId, userId, paymentReference, paymentProofPath);

                // Set booking success flag
                Session["BookingSuccess"] = true;

                // Redirect to confirmation
                Response.Redirect("BookingConfirmation.aspx");
            }
            catch (Exception ex)
            {
                ShowErrorMessage($"Booking failed: {ex.Message}");
            }
        }

        private bool IsPaymentReferenceExist(string paymentReference)
        {
            string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Bookings WHERE PaymentReference = @PaymentReference",
                    conn))
                {
                    cmd.Parameters.AddWithValue("@PaymentReference", paymentReference);
                    return (int)cmd.ExecuteScalar() > 0;
                }
            }
        }

        private string UploadPaymentProof()
        {
            if (!filePaymentProof.HasFile)
            {
                throw new Exception("Payment proof is required.");
            }

            string fileName = Path.GetFileName(filePaymentProof.FileName);
            string extension = Path.GetExtension(fileName);

            // Validate file type
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
            if (!Array.Exists(allowedExtensions, e => e == extension.ToLower()))
            {
                throw new Exception("Only image files are allowed.");
            }

            // Create unique filename
            string uniqueFileName = $"{Guid.NewGuid()}{extension}";
            string uploadFolder = Server.MapPath("~/uploads/payments/");

            // Ensure directory exists
            Directory.CreateDirectory(uploadFolder);

            // Full file path
            string filePath = Path.Combine(uploadFolder, uniqueFileName);

            // Save file
            filePaymentProof.SaveAs(filePath);

            // Return relative path for database storage
            return $"~/uploads/payments/{uniqueFileName}";
        }

        private void SaveBooking(string scheduleId, string userId, string paymentReference, string paymentProofPath)
        {
            string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = @"
                INSERT INTO Bookings 
                (Schedule_ID, Users_ID, PaymentReference, PaymentProofFilePath, BookingDate) 
                VALUES 
                (@ScheduleID, @UserId, @PaymentRef, @PaymentProof, @BookingDate)";

                    cmd.Parameters.AddWithValue("@ScheduleID", scheduleId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@PaymentRef", paymentReference);
                    cmd.Parameters.AddWithValue("@PaymentProof", paymentProofPath);
                    cmd.Parameters.AddWithValue("@BookingDate", DateTime.Now);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Schedules.aspx");
        }

        private void ShowErrorMessage(string message)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = "message error-message";
            lblMessage.Text = message;
        }
    }
}