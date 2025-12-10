using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniversityHRSystem128
{
    public partial class Employee1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string employeeId = txtEmployeeID.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(employeeId) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both Employee ID and Password.";
            }
            else
            {
                // Here you would normally check credentials from the database
                // For now, just redirect to Azer.aspx
                Response.Redirect("Azer.aspx");
            }
        }
    }
}