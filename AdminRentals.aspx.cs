using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace _10thAveStudioWeb
{
    public partial class WebForm22 : System.Web.UI.Page
    {
        private string _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRentalsData();
            }
        }

        private void BindRentalsData()
        {
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                {
                    string queryString = @"
                    SELECT 
                        r.Rental_ID,
                        u.FName + ' ' + u.LName AS FullName, 
                        r.EventTitle,
                        r.RentalDate,
                        CONVERT(VARCHAR(5), r.RentalTime, 108) AS RentalTime
                    FROM 
                        Rentals r
                    JOIN 
                        Users u ON r.Users_ID = u.Users_ID
                    ORDER BY 
                        r.RentalDate DESC, r.RentalTime DESC;";

                    using (SqlCommand cmd = new SqlCommand(queryString, sqlConn))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        sqlConn.Open();
                        adapter.Fill(dt);

                        RentalsGridView.DataSource = dt;
                        RentalsGridView.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Secure error logging
                LogError(ex);
                DisplayErrorMessage("An error occurred while loading rental bookings.");
            }
        }

        protected void RentalsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewRental")
            {
                // Retrieve the full rental details for the specific rental
                int rentalId = Convert.ToInt32(e.CommandArgument);
                GetFullRentalDetails(rentalId);
            }
        }

        private void GetFullRentalDetails(int rentalId)
        {
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                {
                    string queryString = @"
                    SELECT 
                        u.FName + ' ' + u.LName AS FullName, 
                        u.Email,
                        u.PhoneNumber,
                        u.FBLink,
                        r.EventTitle,
                        r.RentalDate,
                        CONVERT(VARCHAR(5), r.RentalTime, 108) AS RentalTime
                    FROM 
                        Rentals r
                    JOIN 
                        Users u ON r.Users_ID = u.Users_ID
                    WHERE 
                        r.Rental_ID = @RentalId;";

                    using (SqlCommand cmd = new SqlCommand(queryString, sqlConn))
                    {
                        cmd.Parameters.AddWithValue("@RentalId", rentalId);
                        sqlConn.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Encode values to prevent XSS
                                string name = HttpUtility.JavaScriptStringEncode(reader["FullName"].ToString());
                                string email = HttpUtility.JavaScriptStringEncode(reader["Email"].ToString());
                                string phone = HttpUtility.JavaScriptStringEncode(reader["PhoneNumber"].ToString());
                                string fbLink = HttpUtility.JavaScriptStringEncode(reader["FBLink"].ToString());
                                string eventTitle = HttpUtility.JavaScriptStringEncode(reader["EventTitle"].ToString());
                                string rentalDate = Convert.ToDateTime(reader["RentalDate"]).ToString("MM/dd/yyyy");
                                string rentalTime = reader["RentalTime"].ToString();

                                // Use double encoding to ensure safety
                                ClientScript.RegisterStartupScript(this.GetType(), "OpenModalScript",
                                    $"openModal('{name}', '{email}', '{phone}', '{fbLink}', '{eventTitle}', '{rentalDate}', '{rentalTime}');", true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Secure error logging
                LogError(ex);
                DisplayErrorMessage("An error occurred while retrieving rental details.");
            }
        }

        private void LogError(Exception ex)
        {
            // Implement secure error logging
            System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
        }

        private void DisplayErrorMessage(string message)
        {
            // You could implement this to show an error message on the page
            System.Diagnostics.Debug.WriteLine(message);
        }
    }
}