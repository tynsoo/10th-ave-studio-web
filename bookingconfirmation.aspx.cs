using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
	public partial class WebForm16 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user came from successful booking
                if (Session["BookingSuccess"] == null || !(bool)Session["BookingSuccess"])
                {
                    // User did not complete a booking, redirect to schedules
                    Response.Redirect("Schedules.aspx");
                }
                else
                {
                    // Clear the session variable
                    Session["BookingSuccess"] = null;
                }
            }
        }
    }
}