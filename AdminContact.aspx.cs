using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
	public partial class WebForm21 : System.Web.UI.Page
    {
            private string _connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    BindContactsData();
                }
            }

            private void BindContactsData()
            {
                try
                {
                    using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                    {
                        string queryString = @"
                    SELECT 
                        c.Contacts_Id,
                        u.FName + ' ' + u.LName AS Name, 
                        u.Email,
                        CASE 
                            WHEN LEN(c.Comments) > 100 
                            THEN LEFT(c.Comments, 100) + '...' 
                            ELSE c.Comments 
                        END AS MessagePreview,
                        c.Comments AS FullMessage,
                        c.CreatedAt
                    FROM 
                        Contacts c
                    JOIN 
                        Users u ON c.Users_ID = u.Users_ID
                    ORDER BY 
                        c.CreatedAt DESC;";

                        using (SqlCommand cmd = new SqlCommand(queryString, sqlConn))
                        {
                            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                            DataTable dt = new DataTable();
                            sqlConn.Open();
                            adapter.Fill(dt);

                            ContactsGridView.DataSource = dt;
                            ContactsGridView.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Secure error logging
                    LogError(ex);
                    DisplayErrorMessage("An error occurred while loading contact messages.");
                }
            }

            protected void ContactsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "ViewMessage")
                {
                    // Retrieve the full message details for the specific contact
                    int contactId = Convert.ToInt32(e.CommandArgument);
                    GetFullMessageDetails(contactId);
                }
            }

            private void GetFullMessageDetails(int contactId)
            {
                try
                {
                    using (SqlConnection sqlConn = new SqlConnection(_connectionString))
                    {
                        string queryString = @"
                    SELECT 
                        u.FName + ' ' + u.LName AS Name, 
                        u.Email,
                        c.Comments AS FullMessage,
                        c.CreatedAt
                    FROM 
                        Contacts c
                    JOIN 
                        Users u ON c.Users_ID = u.Users_ID
                    WHERE 
                        c.Contacts_Id = @ContactId;";

                        using (SqlCommand cmd = new SqlCommand(queryString, sqlConn))
                        {
                            cmd.Parameters.AddWithValue("@ContactId", contactId);
                            sqlConn.Open();

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    // Client-side script to open modal with full message details
                                    string name = reader["Name"].ToString();
                                    string email = reader["Email"].ToString();
                                    string fullMessage = reader["FullMessage"].ToString();
                                    string createdAt = Convert.ToDateTime(reader["CreatedAt"]).ToString("MM/dd/yyyy HH:mm");

                                    ClientScript.RegisterStartupScript(this.GetType(), "OpenModalScript",
                                        $"openModal('{name}', '{email}', '{fullMessage.Replace("'", "\'")}', '{createdAt}');", true);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Secure error logging
                    LogError(ex);
                    DisplayErrorMessage("An error occurred while retrieving message details.");
                }
            }

            private void LogError(Exception ex)
            {
                // Implement secure error logging
                // This could write to a secure log file or logging service
                System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
            }

            private void DisplayErrorMessage(string message)
            {
                // You could implement this to show an error message on the page
                // For now, we'll just write to debug output
                System.Diagnostics.Debug.WriteLine(message);
            }
        }
    }