using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace _10thAveStudioWeb
{
    public partial class WebForm23 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["Schedule_ID"] != null)
                hdnScheduleID.Value = Request.QueryString["Schedule_ID"];
        }

        protected void SubmitAttendance_Click(object sender, EventArgs e)
        {
            try
            {
                string scanData = Request["__EVENTARGUMENT"]; 
                string manualInput = txtUserID.Text.Trim();

                if (string.IsNullOrEmpty(scanData) && string.IsNullOrEmpty(manualInput))
                {
                    lblScanResult.Text = "No input received. Please scan a QR code or enter a User ID.";
                    lblScanResult.CssClass = "error-message";
                    return;
                }

                int userID, scheduleID;

                if (!string.IsNullOrEmpty(scanData))
                {
                    string[] data = scanData.Split('|');
                    if (data.Length != 2 || !int.TryParse(data[0], out userID) || !int.TryParse(data[1], out scheduleID))
                    {
                        lblScanResult.Text = "Invalid scan format.";
                        lblScanResult.CssClass = "error-message";
                        return;
                    }
                }
                else
                {
                    if (!int.TryParse(manualInput, out userID) || !int.TryParse(hdnScheduleID.Value, out scheduleID))
                    {
                        lblScanResult.Text = "Invalid User ID or missing Schedule ID.";
                        lblScanResult.CssClass = "error-message";
                        return;
                    }
                }

                string connStr = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string query = "INSERT INTO StudentAttendance (Users_ID, Schedule_ID, AttendanceDate, AttendanceTime, Status) " +
                                   "VALUES (@UserID, @ScheduleID, GETDATE(), GETDATE(), " +
                                   "CASE WHEN CAST(GETDATE() AS TIME) > (SELECT Schedule_Time FROM Schedules WHERE Schedule_ID = @ScheduleID) THEN 'Late' ELSE 'Present' END)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        cmd.Parameters.AddWithValue("@ScheduleID", scheduleID);
                        cmd.ExecuteNonQuery();
                    }
                }

                lblScanResult.Text = "Attendance marked successfully.";
                lblScanResult.CssClass = "success-message";
            }
            catch (Exception ex)
            {
                lblScanResult.Text = "Error: " + ex.Message;
                lblScanResult.CssClass = "error-message";
            }
        }
    }
}
