using System;
using System.Configuration;
using System.Data.SqlClient;

namespace UniversityHRSystem128
{
    public partial class Default : System.Web.UI.Page
    {
        // Re‑use the same connection string as the rest of the site
        string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAdminSnapshot();
            }
        }

        private void LoadAdminSnapshot()
        {
            int totalEmployees = 0;
            int onLeaveEmployees = 0;
            int pendingLeaveRequests = 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // 1) Total employees in the system
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Employee", conn))
                    {
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                            totalEmployees = Convert.ToInt32(result);
                    }

                    // 2) Employees whose employment_status is 'onleave'
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Employee WHERE employment_status = 'onleave'", conn))
                    {
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                            onLeaveEmployees = Convert.ToInt32(result);
                    }

                    // 3) Pending leave requests in the Leave table
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM [Leave] WHERE LOWER(final_approval_status) = 'pending'", conn))
                    {
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                            pendingLeaveRequests = Convert.ToInt32(result);
                    }
                }

                // Bind values to the small snapshot card
                lblPresentNow.Text = totalEmployees.ToString();
                lblOnLeave.Text = onLeaveEmployees.ToString();
                lblPendingActions.Text = pendingLeaveRequests.ToString();
            }
            catch
            {
                // Redirect to error page on any database error
                Response.Redirect("DbError.aspx");
            }
        }
    }
}
