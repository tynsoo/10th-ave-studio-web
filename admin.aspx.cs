using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;
using System.Configuration;

namespace _10thAveStudioWeb
{
    public partial class WebForm10 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindScheduleData();
            }
        }

        private void BindScheduleData()
        {
            string strsqlconn = ConfigurationManager.ConnectionStrings["StudioConnectionString"].ConnectionString;
            using (SqlConnection sqlconn = new SqlConnection(strsqlconn))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = sqlconn;
                    cmd.CommandText = @"SELECT 
                        s.Schedule_ID, 
                        c.Name AS Class_Name, 
                        s.Schedule_Day AS Date, 
                        CONVERT(VARCHAR, s.Schedule_Time, 100) AS Time, 
                        CASE 
                            WHEN s.Location = 1 THEN 'Studio 1'
                            WHEN s.Location = 2 THEN 'Studio 2'
                            ELSE 'Unknown Location'
                        END AS Location, 
                        u.FName + ' ' + u.LName AS Instructor,
                        (SELECT COUNT(*) FROM StudentAttendance sa 
                         WHERE sa.Schedule_ID = s.Schedule_ID) AS CurrentAttendance,
                        -- Calculate Sales: Count of bookings * Class Price
                        COALESCE(
                            (SELECT COUNT(*) FROM Bookings b WHERE b.Schedule_ID = s.Schedule_ID) * 
                            c.Price, 0
                        ) AS Sales
                    FROM 
                        Schedules s 
                    JOIN 
                        Classes c ON s.Class_ID = c.Class_ID 
                    JOIN 
                        Instructors i ON c.Instructor_ID = i.Instructor_ID
                    JOIN 
                        Users u ON i.Users_ID = u.Users_ID
                    WHERE 
                        CONVERT(DATE, GETDATE()) <= DATEADD(DAY, 7, CONVERT(DATE, GETDATE()))
                    GROUP BY 
                        s.Schedule_ID, 
                        c.Name, 
                        s.Schedule_Day, 
                        s.Schedule_Time, 
                        s.Location, 
                        u.FName, 
                        u.LName, 
                        c.Price, 
                        s.Class_ID
                    ORDER BY 
                        s.Schedule_Day, 
                        s.Schedule_Time;";

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    try
                    {
                        dt.Columns.Add("Schedule_ID", typeof(int));
                        dt.Columns.Add("Class_Name", typeof(string));
                        dt.Columns.Add("Date", typeof(DateTime));
                        dt.Columns.Add("Time", typeof(string));
                        dt.Columns.Add("Location", typeof(string));
                        dt.Columns.Add("Instructor", typeof(string));
                        dt.Columns.Add("CurrentAttendance", typeof(int));
                        dt.Columns.Add("Sales", typeof(decimal));

                        sqlconn.Open();
                        adapter.Fill(dt);
                    }
                    catch (Exception ex)
                    {
                        DataRow errorRow = dt.NewRow();
                        errorRow["Class_Name"] = "Error: " + ex.Message;
                        dt.Rows.Add(errorRow);
                    }
                    finally
                    {
                        sqlconn.Close();
                    }

                    if (dt.Rows.Count > 0)
                    {
                        ScheduleGridView.DataSource = dt;
                        ScheduleGridView.DataBind();
                    }
                    else
                    {
                        DataRow noDataRow = dt.NewRow();
                        noDataRow["Class_Name"] = "No classes scheduled for this week.";
                        dt.Rows.Add(noDataRow);
                        ScheduleGridView.DataSource = dt;
                        ScheduleGridView.DataBind();
                        ScheduleGridView.Rows[0].Cells.Clear();
                        ScheduleGridView.Rows[0].Cells.Add(new TableCell());
                        ScheduleGridView.Rows[0].Cells[0].ColumnSpan = ScheduleGridView.Columns.Count;
                        ScheduleGridView.Rows[0].Cells[0].Text = "No classes scheduled for this week.";
                        ScheduleGridView.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
                    }
                }
            }
        }
    }
}
