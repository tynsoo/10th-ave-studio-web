using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace _10thAveStudioWeb
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void signup_Click(object sender, EventArgs e)
        {
            string firstName = FirstNameInput.Text.Trim();
            string lastName = LastNameInput.Text.Trim();
            string email = EmailInput.Text.Trim();
            string password = PasswordInput.Text;
            string SocMed = SocMedInput.Text;
            string PhoneNumber = PhoneNum.Text;
            string confirmpassword = ConfirmPasswordInput.Text;

            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) ||
                string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password) || 
                string.IsNullOrEmpty(SocMed) || string.IsNullOrEmpty(PhoneNumber))
            {
                ShowError("All fields are required");
                return;
            }

            if (confirmpassword != password)
            {
                ShowError("Password not match");
                return;
            }

            string hashedPassword = CreatePasswordHash(password);

            if (SaveUser(email, hashedPassword,firstName, lastName, SocMed, PhoneNumber))
            {
                Response.Redirect("login.aspx");
            }
            else
            {
                ShowError("Registration failed. Please try again or contact support.");
            }
        }

        private bool SaveUser(string email, string hashedPassword,string firstName, string lastName, string socmed, string PhoneNumber)
        {
            bool success = false;

            string strsqlconn = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection sqlconn = new SqlConnection(strsqlconn))
            {
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand checkCommand = new SqlCommand(checkQuery, sqlconn);
                checkCommand.Parameters.AddWithValue("@Email", email);

                try
                {
                    sqlconn.Open();
                    int userCount = (int)checkCommand.ExecuteScalar();

                    if (userCount > 0)
                    {
                        ShowError("Email already registered. Please use a different email or try to login.");
                        return false;
                    }
                    string insertQuery = "INSERT INTO Users (FName, LName, PhoneNumber, FBLink, Email, UserPassword, Role) " +
                                        "VALUES (@FirstName, @LastName, @PhoneNumber, @SocMed, @Email, @Password, @Role)";

                    SqlCommand insertCommand = new SqlCommand(insertQuery, sqlconn);
                    insertCommand.Parameters.AddWithValue("@FirstName", firstName);
                    insertCommand.Parameters.AddWithValue("@LastName", lastName);
                    insertCommand.Parameters.AddWithValue("@PhoneNumber", PhoneNumber);
                    insertCommand.Parameters.AddWithValue("@SocMed", socmed);
                    insertCommand.Parameters.AddWithValue("@Email", email);
                    insertCommand.Parameters.AddWithValue("@Password", hashedPassword);
                    insertCommand.Parameters.AddWithValue("@Role", "Student");
                    int rowsAffected = insertCommand.ExecuteNonQuery();
                    success = (rowsAffected > 0);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Database error: " + ex.Message);
                    success = false;
                }
            }

            return success;
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