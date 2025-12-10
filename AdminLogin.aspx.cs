using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace UniversityHRSystem128
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void AdminLogin_Click(object sender, EventArgs e)
        {
            string enteredUser = username.Text.Trim();
            string enteredPass = Password.Text.Trim();

            if (enteredUser == "aly" && enteredPass == "aly123")
            {
                Response.Redirect("Admin.aspx");
            }
            else
            {
                Label1.Text = "Invalid credentials. Please enter a valid username and password.";
                pnlError.Visible = true;
            }
        }
    }
}

