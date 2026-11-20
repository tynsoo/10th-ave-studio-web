using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Users_ID"] != null)
            {
                // Get the user role from session
                string userRole = Session["UserRole"].ToString();

                // Redirect based on user role
                switch (userRole.ToLower())
                {
                    case "student":
                        Response.Redirect("homepage.aspx");
                        break;
                    case "instructor":
                    case "admin":
                    case "owner":
                        Response.Redirect("admin.aspx");
                        break;
                    default:
                        // Default redirect if role doesn't match any of the above
                        Response.Redirect("homepage.aspx");
                        break;
                }
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string email = EmailInput.Text.Trim();
            string password = PasswordInput.Text;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowError("Please enter both email and password.");
                return;
            }

            if (ValidateUser(email, password))
            {
                // Use the session variable we just set
                string userRole = Session["UserRole"]?.ToString() ?? "Student";

                switch (userRole.ToLower())
                {
                    case "student":
                        Response.Redirect("homepage.aspx");
                        break;
                    case "instructor":
                        Response.Redirect("instructorhomepage.aspx");
                        break;
                    case "admin":
                        Response.Redirect("admin.aspx");
                        break;
                    default:
                        Response.Redirect("homepage.aspx");
                        break;
                }
            }
            else
            {
                ShowError("Invalid email or password. Please try again.");
            }
        }

        private bool ValidateUser(string email, string password)
        {
            bool isValid = false;
            int userId = 0;
            string userRole = string.Empty;
            string hashedPassword = CreatePasswordHash(password);

            string strsqlconn = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            using (SqlConnection sqlconn = new SqlConnection(strsqlconn))
            {
                try
                {
                    sqlconn.Open();
                    string selectcmd = "SELECT Users_ID, Role FROM Users WHERE Email = @Email AND UserPassword = @Password";
                    using (SqlCommand command = new SqlCommand(selectcmd, sqlconn))
                    {
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Password", hashedPassword);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                isValid = true;
                                userId = Convert.ToInt32(reader["Users_ID"]);
                                userRole = reader["Role"].ToString();

                                // Set session variables
                                Session["Users_ID"] = userId;
                                Session["UserEmail"] = email;
                                Session["UserRole"] = userRole; // Note the consistent naming
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Database error: " + ex.Message);
                    ShowError("An error occurred during login. Please try again.");
                    isValid = false;
                }
            }

            return isValid;
        }

        private string CreatePasswordHash(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));

                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void ShowError(string message)
        {
            ErrorMessage.Text = message;
            ErrorMessage.Visible = true;
        }
    }
}