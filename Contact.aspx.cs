using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace _10thAveStudioWeb
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Check if user is logged in
            if (Session["Users_ID"] == null)
            {
                Response.Write("<script>alert('Please log in to submit a comment.');</script>");
                btnSend.Enabled = false;
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            // Check if user is logged in before processing
            if (Session["Users_ID"] == null)
            {
                Response.Write("<script>alert('Please log in to submit a comment.');</script>");
                return;
            }

            string comment = txtComment.Text.Trim();

            // Validate comment is not empty
            if (string.IsNullOrWhiteSpace(comment))
            {
                Response.Write("<script>alert('Comment cannot be empty.');</script>");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            string query = "INSERT INTO Contacts (Users_ID, Comments) VALUES (@UserId, @Comment)";
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add the logged-in user's ID from the session
                        cmd.Parameters.AddWithValue("@UserId", Session["Users_ID"]);
                        cmd.Parameters.AddWithValue("@Comment", comment);

                        // Execute the query
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Message sent successfully!');</script>");
                            txtComment.Text = ""; // Clear the comment box
                        }
                        else
                        {
                            Response.Write("<script>alert('Failed to send message.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Error handling with JavaScript alert
                // Use HttpUtility.JavaScriptStringEncode to prevent XSS
                Response.Write($"<script>alert('Error: {HttpUtility.JavaScriptStringEncode(ex.Message)}');</script>");
            }
        }
    }
}