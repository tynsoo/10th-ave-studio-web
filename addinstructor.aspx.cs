using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;

namespace _10thAveStudioWeb
{
    public partial class WebForm19 : System.Web.UI.Page
    {
        protected void submit_Click(object sender, EventArgs e)
        {
            string connectstr = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            // Validate input fields
            if (string.IsNullOrWhiteSpace(FirstNameInput.Text) ||
                string.IsNullOrWhiteSpace(LastNameInput.Text) ||
                string.IsNullOrWhiteSpace(EmailInput.Text) ||
                string.IsNullOrWhiteSpace(PhoneNum.Text) ||
                string.IsNullOrWhiteSpace(SocMedInput.Text) ||
                string.IsNullOrWhiteSpace(PasswordInput.Text) ||
                string.IsNullOrWhiteSpace(Specialty.Text) ||
                string.IsNullOrWhiteSpace(Experience.Text))
            {
                Response.Write("<script>alert('Please fill in all fields.');</script>");
                return;
            }

            try
            {
                // Hash the password before storing
                string hashedPassword = CreatePasswordHash(PasswordInput.Text);

                using (SqlConnection conn = new SqlConnection(connectstr))
                {
                    conn.Open();

                    // First, insert into Users table with hashed password
                    string insertUserCmd = @"
                        INSERT INTO Users (FName, LName, PhoneNumber, FBLink, Email, UserPassword, Role) 
                        VALUES (@FirstName, @LastName, @PhoneNumber, @FBLink, @Email, @Password, 'Instructor');
                        SELECT SCOPE_IDENTITY();";

                    int userId;
                    using (SqlCommand userCmd = new SqlCommand(insertUserCmd, conn))
                    {
                        userCmd.Parameters.AddWithValue("@FirstName", FirstNameInput.Text);
                        userCmd.Parameters.AddWithValue("@LastName", LastNameInput.Text);
                        userCmd.Parameters.AddWithValue("@PhoneNumber", PhoneNum.Text);
                        userCmd.Parameters.AddWithValue("@FBLink", SocMedInput.Text);
                        userCmd.Parameters.AddWithValue("@Email", EmailInput.Text);
                        userCmd.Parameters.AddWithValue("@Password", hashedPassword);

                        userId = Convert.ToInt32(userCmd.ExecuteScalar());
                    }

                    // Then, insert into Instructors table
                    string insertInstructorCmd = @"
                        INSERT INTO Instructors (Users_ID, Specialty, Experience) 
                        VALUES (@UserId, @Specialty, @Experience);";

                    using (SqlCommand instructorCmd = new SqlCommand(insertInstructorCmd, conn))
                    {
                        instructorCmd.Parameters.AddWithValue("@UserId", userId);
                        instructorCmd.Parameters.AddWithValue("@Specialty", Specialty.Text);
                        instructorCmd.Parameters.AddWithValue("@Experience", Experience.Text);

                        instructorCmd.ExecuteNonQuery();
                    }

                    // Clear input fields
                    ClearInputFields();

                    // Redirect to instructors page
                    Response.Redirect("~/AdminInstructors.aspx");
                }
            }
            catch (Exception ex)
            {
                // Show error message
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        // Clear input fields after successful submission
        private void ClearInputFields()
        {
            FirstNameInput.Text = string.Empty;
            LastNameInput.Text = string.Empty;
            EmailInput.Text = string.Empty;
            PhoneNum.Text = string.Empty;
            SocMedInput.Text = string.Empty;
            PasswordInput.Text = string.Empty;
            Specialty.Text = string.Empty;
            Experience.Text = string.Empty;
        }

        // Password hashing method using SHA256
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