using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class _10thAveAdmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated and has admin role
            if (!IsUserAdmin())
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            // Clear session and authentication cookies
            Session.Clear();
            Session.Abandon();

            // Clear authentication cookie if you're using Forms Authentication
            System.Web.Security.FormsAuthentication.SignOut();

            // Redirect to login page
            Response.Redirect("~/Login.aspx");
        }

        private bool IsUserAdmin()
        {
            // Check if user is authenticated and has admin role
            // This is a placeholder - implement your actual authentication logic
            if (Session["UserRole"] != null)
            {
                return Session["UserRole"].ToString() == "Admin";
            }
            return false;
        }
    }
}