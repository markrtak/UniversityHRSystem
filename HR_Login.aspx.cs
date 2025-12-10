using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace UniversityHRSystem128
{
    public partial class HR_Login : System.Web.UI.Page
    {
        protected void login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MyDbConnection"].ToString();

            if (string.IsNullOrWhiteSpace(username.Text)) return;
            int id = int.Parse(username.Text);
            string pass = password.Text;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // 1. Check Login Credentials
                SqlCommand loginFunc = new SqlCommand("SELECT dbo.HRLoginValidation(@id, @pass)", conn);
                loginFunc.Parameters.Add(new SqlParameter("@id", id));
                loginFunc.Parameters.Add(new SqlParameter("@pass", pass));

                int result = Convert.ToInt32(loginFunc.ExecuteScalar());

                if (result == 1)
                {
                    // 2. Fetch Name and ROLE (e.g., HR_Representative_MET)
                    string query = @"
                        SELECT e.first_name + ' ' + e.last_name, er.role_name 
                        FROM Employee e
                        JOIN Employee_Role er ON e.employee_ID = er.emp_ID
                        WHERE e.employee_ID = @id";

                    SqlCommand infoCmd = new SqlCommand(query, conn);
                    infoCmd.Parameters.Add(new SqlParameter("@id", id));

                    SqlDataReader reader = infoCmd.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["user_id"] = id;
                        Session["user_name"] = reader.GetString(0);
                        Session["user_role"] = reader.GetString(1); // Stores Role Name
                    }

                    Response.Redirect("HR_Dashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Invalid ID/Password or you are not HR.');</script>");
                }
            }
        }
    }
}