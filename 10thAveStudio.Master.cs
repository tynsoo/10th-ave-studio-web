using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _10thAveStudioWeb
{
    public partial class _10thAveStudio : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Users_ID"] != null)
                {
                    string userEmail = Session["UserEmail"]?.ToString();

                    if (!string.IsNullOrEmpty(userEmail))
                    {
                        loginText.InnerText = userEmail;
                        LoginHyperLink.NavigateUrl = "~/Profile.aspx";
                        HyperLink1.NavigateUrl = "~/Classes.aspx";
                        HyperLink2.NavigateUrl = "~/Schedules.aspx";
                        HyperLink3.NavigateUrl = "~/Instructors.aspx";
                        HyperLink4.NavigateUrl = "~/FAQs.aspx";
                        HyperLink5.NavigateUrl = "~/Contact.aspx";
                        HyperLink6.NavigateUrl = "~/Rentals.aspx";
                        MobileHyperLink1.NavigateUrl = "~/Classes.aspx";
                        MobileHyperLink2.NavigateUrl = "~/Schedules.aspx";
                        MobileHyperLink3.NavigateUrl = "~/Instructors.aspx";
                        MobileHyperLink4.NavigateUrl = "~/FAQs.aspx";
                        MobileHyperLink5.NavigateUrl = "~/Contact.aspx";
                        MobileHyperLink6.NavigateUrl = "~/Rentals.aspx";
                        LogoHyperLink.NavigateUrl = "~/HomePage.aspx";
                    }
                }
                else 
                {
                    loginText.InnerText = "LOG IN";
                    LoginHyperLink.NavigateUrl = "~/login.aspx";
                    HyperLink1.NavigateUrl = "~/login.aspx";
                    HyperLink2.NavigateUrl = "~/login.aspx";    
                    HyperLink3.NavigateUrl = "~/login.aspx";
                    HyperLink4.NavigateUrl = "~/login.aspx";
                    HyperLink5.NavigateUrl = "~/login.aspx";
                    HyperLink6.NavigateUrl = "~/login.aspx";
                    MobileHyperLink1.NavigateUrl = "~/login.aspx";
                    MobileHyperLink2.NavigateUrl = "~/login.aspx";
                    MobileHyperLink3.NavigateUrl = "~/login.aspx";
                    MobileHyperLink4.NavigateUrl = "~/login.aspx";
                    MobileHyperLink5.NavigateUrl = "~/login.aspx";
                    MobileHyperLink6.NavigateUrl = "~/login.aspx";
                    LogoHyperLink.NavigateUrl = "~/login.aspx";
                }
            }
        }

        protected void ProfileImageButton_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["Users_ID"] != null)
            {
                Response.Redirect("~/Profile.aspx");
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        public string UserEmail
        {
            get
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    return HttpContext.Current.User.Identity.Name;
                }
                else
                {
                    return "LOG IN";
                }
            }
        }
    }
}