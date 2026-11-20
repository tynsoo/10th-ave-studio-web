using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInstructors();
            }
        }

        private void LoadInstructors()
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = @"
                            SELECT 
                                u.Fname + ' ' + u.Lname AS InstructorName, 
                                i.Specialty, 
                                i.Experience, 
                                u.Email 
                            FROM Instructors i 
                            INNER JOIN Users u ON i.Users_ID = u.Users_ID
                            ORDER BY u.Fname, u.Lname";

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();

                        conn.Open();
                        adapter.Fill(dt);
                        conn.Close();

                        if (dt.Rows.Count > 0)
                        {
                            gvInstructors.DataSource = dt;
                            gvInstructors.DataBind();
                            lblNoInstructors.Visible = false;
                        }
                        else
                        {
                            gvInstructors.DataSource = null;
                            gvInstructors.DataBind();
                            lblNoInstructors.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlError.Visible = true;
                lblError.Text = "Error loading instructors: " + ex.Message;
            }
        }

        protected void gvInstructors_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Optional: Additional row formatting or data manipulation
                var experienceCell = e.Row.Cells[2];
                if (experienceCell.Text.Length > 100)
                {
                    experienceCell.Text = experienceCell.Text.Substring(0, 100) + "...";
                }
            }
        }
    }
}