using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using QRCoder; // Add QRCoder NuGet package

namespace _10thAveStudioWeb
{
    public partial class WebForm20 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserData();
                GenerateUserQRCode();
            }
        }

        private void LoadUserData()
        {
            string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT FName, LName, PhoneNumber, FBLink, Email, Role, Users_ID FROM Users WHERE Users_ID = @UserId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["Users_ID"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            FName.Text = reader["FName"].ToString();
                            LName.Text = reader["LName"].ToString();
                            PhoneNum.Text = reader["PhoneNumber"].ToString();
                            FBLink.Text = reader["FBLink"].ToString();
                            Email.Text = reader["Email"].ToString();
                            Role.Text = reader["Role"].ToString();
                        }
                    }
                }
            }
        }

        private void GenerateUserQRCode()
        {
            try
            {
                string userId = Session["Users_ID"]?.ToString() ?? "";
                QRCodeGenerator qrGenerator = new QRCodeGenerator();
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(userId, QRCodeGenerator.ECCLevel.Q);
                QRCode qrCode = new QRCode(qrCodeData);
                Bitmap qrCodeImage = qrCode.GetGraphic(10, Color.Black, Color.White, true);

                using (MemoryStream ms = new MemoryStream())
                {
                    qrCodeImage.Save(ms, ImageFormat.Png);
                    byte[] imageBytes = ms.ToArray();
                    string base64String = Convert.ToBase64String(imageBytes);
                    imgQRCode.ImageUrl = "data:image/png;base64," + base64String;
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "QRCodeError",
                    $"alert('Error generating QR code: {HttpUtility.JavaScriptStringEncode(ex.Message)}');", true);
            }
        }

        protected void btnDownloadQR_Click(object sender, EventArgs e)
        {
            try
            {
                string userId = Session["Users_ID"]?.ToString() ?? "";

                QRCodeGenerator qrGenerator = new QRCodeGenerator();
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(userId, QRCodeGenerator.ECCLevel.Q);
                QRCode qrCode = new QRCode(qrCodeData);

                Bitmap qrCodeImage = qrCode.GetGraphic(10, Color.Black, Color.White, true);

                Response.Clear();
                Response.ContentType = "image/png";
                Response.AddHeader("content-disposition", $"attachment; filename=10thAveStudio_UserID_{userId}.png");

                using (MemoryStream ms = new MemoryStream())
                {
                    qrCodeImage.Save(ms, ImageFormat.Png);
                    ms.WriteTo(Response.OutputStream);
                }

                Response.End();
            }
            catch (Exception ex)
            {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "QRDownloadError",
                    $"alert('Error downloading QR code: {HttpUtility.JavaScriptStringEncode(ex.Message)}');", true);
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (!ValidateInputs())
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string updateQuery = @"
                        UPDATE Users 
                        SET 
                            FName = @FName, 
                            LName = @LName, 
                            PhoneNumber = @PhoneNumber, 
                            FBLink = @FBLink
                        WHERE Users_ID = @UserId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@FName", FName.Text.Trim());
                        cmd.Parameters.AddWithValue("@LName", LName.Text.Trim());
                        cmd.Parameters.AddWithValue("@PhoneNumber", PhoneNum.Text.Trim());
                        cmd.Parameters.AddWithValue("@FBLink", FBLink.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserId", Session["Users_ID"]);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "SuccessAlert",
                                "alert('Profile updated successfully!');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "NoChangesAlert",
                                "alert('No changes were made.');", true);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorAlert",
                        $"alert('An error occurred: {HttpUtility.JavaScriptStringEncode(ex.Message)}');", true);
                }
            }
        }

        private bool ValidateInputs()
        {
            if (string.IsNullOrWhiteSpace(FName.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FirstNameAlert",
                    "alert('First Name cannot be empty.');", true);
                return false;
            }

            if (string.IsNullOrWhiteSpace(LName.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "LastNameAlert",
                    "alert('Last Name cannot be empty.');", true);
                return false;
            }

            if (!Regex.IsMatch(PhoneNum.Text, @"^\d{11}$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "PhoneNumberAlert",
                    "alert('Phone Number must be 11 digits.');", true);
                return false;
            }

            if (!string.IsNullOrWhiteSpace(FBLink.Text) &&
                !Regex.IsMatch(FBLink.Text, @"^https?://(?:www\.)?facebook\.com/[a-zA-Z0-9.]+$"))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FBLinkAlert",
                    "alert('Invalid Facebook profile link.');", true);
                return false;
            }

            return true;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}