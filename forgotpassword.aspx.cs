using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web;

namespace _10thAveStudioWeb
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string email= EmailInput.Text.Trim();
            if (string.IsNullOrEmpty(email))
            {
                ShowMessage("Please enter your email address or username.", false);
                return;
            }

            if (UserExists(email))
            {
                HttpContext.Current.Session["UserEmail"] = email;
                Response.Redirect("~/forgotpassword1.aspx");
            }
            else
            {
                ShowMessage("We couldn't find an account with that email or username.", false);
            }
        }

        private bool UserExists(string email)
        {
            bool exists = false;

            string strsqlconn = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(strsqlconn))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Email", email);

                try
                {
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    exists = count > 0;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Database error: " + ex.Message);
                }
            }

            return exists;
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "message success-message" : "message error-message";
            lblMessage.Visible = true;
        }
    }
}