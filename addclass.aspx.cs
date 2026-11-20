using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class WebForm14 : System.Web.UI.Page
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
            string connectionString = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT 
                    i.Instructor_ID, 
                    u.FName + ' ' + u.LName AS FullName, 
                    i.Specialty
                FROM 
                    Instructors i
                JOIN 
                    Users u ON i.Users_ID = u.Users_ID
                ORDER BY 
                    u.LName, u.FName";

                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                System.Data.DataTable dt = new System.Data.DataTable();

                try
                {
                    connection.Open();
                    adapter.Fill(dt);

                    InstructorGridView.DataSource = dt;
                    InstructorGridView.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error loading instructors: " + ex.Message + "');</script>");
                }
            }
        }

        protected void InstructorGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Optional: Add any row-specific formatting here
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Example: Alternate row color
                e.Row.Attributes["style"] = (e.Row.RowIndex % 2 == 0)
                    ? "background-color: #1E1E1E;"
                    : "background-color: #2A2A2A;";
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            // Input validation
            if (string.IsNullOrWhiteSpace(Class_Name.Text) ||
                string.IsNullOrWhiteSpace(Class_desc.Text) ||
                string.IsNullOrWhiteSpace(Instructor_ID.Text) ||
                string.IsNullOrWhiteSpace(Price.Text) ||
                string.IsNullOrWhiteSpace(MaxStudents.Text))
            {
                Response.Write("<script>alert('Please fill in all fields before submitting.');</script>");
                return;
            }

            string connectstr = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectstr))
            {
                string query = @"
                INSERT INTO Classes 
                (Name, Class_Description, Instructor_ID, Price, MaxStudents) 
                VALUES 
                (@ClassName, @ClassDesc, @InstructorID, @Price, @MaxStudents)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        // Validate and parse numeric inputs
                        int instructorId = int.Parse(Instructor_ID.Text.Trim());
                        decimal price = decimal.Parse(Price.Text.Trim());
                        int maxStudents = int.Parse(MaxStudents.Text.Trim());

                        // Add parameters with validated values
                        command.Parameters.AddWithValue("@ClassName", Class_Name.Text.Trim());
                        command.Parameters.AddWithValue("@ClassDesc", Class_desc.Text.Trim());
                        command.Parameters.AddWithValue("@InstructorID", instructorId);
                        command.Parameters.AddWithValue("@Price", price);
                        command.Parameters.AddWithValue("@MaxStudents", maxStudents);

                        connection.Open();
                        int result = command.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Response.Write("<script>alert('Class added successfully!'); window.location='AdminClasses.aspx';</script>");
                        }
                    }
                    catch (FormatException)
                    {
                        Response.Write("<script>alert('Please enter valid numeric values for Instructor ID, Price, and Max Students.');</script>");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                    }
                }
            }
        }
    }
}