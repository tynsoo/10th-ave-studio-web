using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace _10thAveStudioWeb
{
    public partial class WebForm18 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear any previous messages on page load
            lblMessage.Visible = false;
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string newPassword = PasswordInput1.Text;
            string confirmPassword = PasswordInput2.Text;

            // Check if passwords are null
            if (string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                ShowErrorMessage("Please enter both password fields.");
                return;
            }

            // Check if passwords match
            if (newPassword != confirmPassword)
            {
                ShowErrorMessage("Passwords do not match. Please try again.");
                return;
            }

            try
            {
                // Update password in database
                if (UpdateUserPassword(newPassword))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Password updated successfully');", true);
                    // Clear input fields
                    PasswordInput1.Text = string.Empty;
                    PasswordInput2.Text = string.Empty;
                    Response.Redirect("~/login.aspx");
                }
                else
                {
                    ShowErrorMessage("Unable to update password. Please try again.");
                }
            }
            catch (Exception)
            {
                ShowErrorMessage("An error occurred while updating the password.");
            }
        }

        private void ShowErrorMessage(string message)
        {
            lblMessage.CssClass = "error-message";
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }

        private bool UpdateUserPassword(string newPassword)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string hashedPassword = CreatePasswordHash(newPassword);

                string query = "UPDATE Users SET UserPassword = @Password WHERE Email = @Email";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", HttpContext.Current.Session["UserEmail"]);
                    command.Parameters.AddWithValue("@Password", hashedPassword);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    return rowsAffected > 0;
                }
            }
        }

        private string CreatePasswordHash(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                // Convert string to byte array and compute hash
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                // Convert byte array to hexadecimal string
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}