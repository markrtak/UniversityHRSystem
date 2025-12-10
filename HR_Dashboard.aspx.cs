using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace UniversityHRSystem128
{
    public partial class HR_Dashboard : System.Web.UI.Page
    {
        string connStr = WebConfigurationManager.ConnectionStrings["MyDbConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user_id"] == null)
                Response.Redirect("HR_Login.aspx");

            if (!IsPostBack)
            {
                lblHRID.Text = Session["user_id"].ToString();
                lblHRName.Text = Session["user_name"] != null ? Session["user_name"].ToString() : "Unknown";
                lblHRRole.Text = Session["user_role"] != null ? Session["user_role"].ToString() : "N/A";

                string viewType = Request.QueryString["view"];
                if (string.IsNullOrEmpty(viewType))
                {
                    pnlDashboard.Visible = true;
                    pnlDataView.Visible = false;
                    BindLeaveGrid();
                }
                else
                {
                    pnlDashboard.Visible = false;
                    pnlDataView.Visible = true;
                    LoadRawTable(viewType);
                }
            }
        }

        protected void logout(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("HR_Login.aspx");
        }

        private void BindLeaveGrid()
        {
            int hrId = (int)Session["user_id"];
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT V.* FROM v_HR_All_Leaves V
                    INNER JOIN Employee_Approve_Leave A ON V.request_ID = A.Leave_ID
                    WHERE A.Emp1_ID = @HR_ID
                    ORDER BY CASE WHEN V.final_approval_status = 'pending' THEN 1 ELSE 2 END, V.request_ID DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.Add(new SqlParameter("@HR_ID", hrId));
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvLeaves.DataSource = dt;
                gvLeaves.DataBind();
            }
        }

        private void LoadRawTable(string tableName)
        {
            lblTableName.Text = tableName;
            if (tableName != "Employee_Approve_Leave" && tableName != "Attendance" &&
                tableName != "Leave" && tableName != "Payroll" && tableName != "Document" && tableName != "Deduction") return;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM " + tableName;
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvGeneric.DataSource = dt;
                gvGeneric.DataBind();
            }
        }

        protected void gvLeaves_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ApproveLeave")
            {
                string[] args = e.CommandArgument.ToString().Split(',');
                string requestID = args[0];
                string leaveType = args[1];
                string procName = "";

                if (leaveType == "Annual" || leaveType == "Accidental") procName = "HR_approval_an_acc";
                else if (leaveType == "Unpaid") procName = "HR_approval_unpaid";
                else if (leaveType == "Compensation") procName = "HR_approval_comp";
                else return;

                ExecuteApproval(procName, requestID, leaveType);
                BindLeaveGrid();
            }
        }

        private void ExecuteApproval(string procName, string requestID, string leaveType = null)
        {
            try
            {
                int reqId = int.Parse(requestID);
                int hrId = (int)Session["user_id"];
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Authorization Check
                    SqlCommand authCheck = new SqlCommand("SELECT COUNT(*) FROM Employee_Approve_Leave WHERE Leave_ID = @rid AND Emp1_ID = @hrid", conn);
                    authCheck.Parameters.Add(new SqlParameter("@rid", reqId));
                    authCheck.Parameters.Add(new SqlParameter("@hrid", hrId));
                    if ((int)authCheck.ExecuteScalar() == 0)
                    {
                        lblMessage.Text = "⛔ Not authorized."; lblMessage.ForeColor = System.Drawing.Color.Red; return;
                    }

                    SqlCommand cmd = new SqlCommand(procName, conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@request_ID", reqId));
                    cmd.Parameters.Add(new SqlParameter("@HR_ID", hrId));
                    cmd.ExecuteNonQuery();

                    SqlCommand checkCmd = new SqlCommand("SELECT final_approval_status FROM Leave WHERE request_ID = @id", conn);
                    checkCmd.Parameters.Add(new SqlParameter("@id", reqId));
                    string status = checkCmd.ExecuteScalar().ToString();

                    lblMessage.Visible = true;
                    if (status.Equals("approved", StringComparison.OrdinalIgnoreCase))
                    {
                        lblMessage.Text = "✅ Request Approved!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else if (status.Equals("rejected", StringComparison.OrdinalIgnoreCase))
                    {
                        lblMessage.Text = "❌ Request Rejected.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        // Extra context for Compensation approvals that remain pending
                        if (!string.IsNullOrEmpty(leaveType) && leaveType.Equals("Compensation", StringComparison.OrdinalIgnoreCase))
                        {
                            lblMessage.Text = "⚠️ Compensation request still pending. It approves only if: worked ≥ 8 hours on the original workday (which must be their official day off), request month matches that workday month, and replacement employee is not on leave.";
                        }
                        else
                        {
                            lblMessage.Text = "⚠️ Processed (Pending others).";
                        }
                        lblMessage.ForeColor = System.Drawing.Color.Orange;
                    }
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error: " + ex.Message; lblMessage.Visible = true; }
        }

        // Deductions (Uses txtDedEmpID)
        protected void applyDeductionHours(object sender, EventArgs e) { RunProc("Deduction_hours", txtDedEmpID.Text); }
        protected void applyDeductionDays(object sender, EventArgs e) { RunProc("Deduction_days", txtDedEmpID.Text); }
        protected void applyDeductionUnpaid(object sender, EventArgs e) { RunProc("Deduction_unpaid", txtDedEmpID.Text); }

        // Payroll (Uses txtPayEmpID)
        protected void generatePayroll(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("Add_Payroll", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@employee_ID", int.Parse(txtPayEmpID.Text)));
                    cmd.Parameters.Add(new SqlParameter("@from", DateTime.Parse(txtFromDate.Text)));
                    cmd.Parameters.Add(new SqlParameter("@to", DateTime.Parse(txtToDate.Text)));
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Payroll Generated!"; lblMessage.Visible = true;
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error: " + ex.Message; lblMessage.Visible = true; }
        }

        private void RunProc(string procName, string empID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(procName, conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@employee_ID", int.Parse(empID)));
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Action Completed."; lblMessage.Visible = true;
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error: " + ex.Message; lblMessage.Visible = true; }
        }
    }
}