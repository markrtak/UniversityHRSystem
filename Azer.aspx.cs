using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniversityHRSystem128
{
    public partial class Azer : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize with default dates
                txtAccStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtAccEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtMedStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtMedEndDate.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
                txtUnpaidStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtUnpaidEndDate.Text = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");
                txtCompDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtOriginalWorkday.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd");
            }
        }

        #region Tab Navigation
        protected void btnTabAccidental_Click(object sender, EventArgs e) { SetActiveTab("Accidental"); }
        protected void btnTabMedical_Click(object sender, EventArgs e) { SetActiveTab("Medical"); }
        protected void btnTabUnpaid_Click(object sender, EventArgs e) { SetActiveTab("Unpaid"); }
        protected void btnTabCompensation_Click(object sender, EventArgs e) { SetActiveTab("Compensation"); }
        protected void btnTabApproveUnpaid_Click(object sender, EventArgs e) { SetActiveTab("ApproveUnpaid"); }
        protected void btnTabApproveAnnual_Click(object sender, EventArgs e) { SetActiveTab("ApproveAnnual"); }
        protected void btnTabEvaluate_Click(object sender, EventArgs e) { SetActiveTab("Evaluate"); }

        #region Employee11 Added Tab Navigation
        protected void btnTabEmpPerformance_Click(object sender, EventArgs e) { SetActiveTab("EmpPerformance"); }
        protected void btnTabEmpAttendance_Click(object sender, EventArgs e) { SetActiveTab("EmpAttendance"); }
        protected void btnTabEmpPayroll_Click(object sender, EventArgs e) { SetActiveTab("EmpPayroll"); }
        protected void btnTabEmpDeductions_Click(object sender, EventArgs e) { SetActiveTab("EmpDeductions"); }
        protected void btnTabEmpAnnualLeave_Click(object sender, EventArgs e) { SetActiveTab("EmpAnnualLeave"); }
        protected void btnTabEmpLeaveStatus_Click(object sender, EventArgs e) { SetActiveTab("EmpLeaveStatus"); }
        #endregion

        private void SetActiveTab(string tabName)
        {
            // Reset all tabs
            btnTabEmpPerformance.CssClass = "tab-btn";
            btnTabEmpAttendance.CssClass = "tab-btn";
            btnTabEmpPayroll.CssClass = "tab-btn";
            btnTabEmpDeductions.CssClass = "tab-btn";
            btnTabEmpAnnualLeave.CssClass = "tab-btn";
            btnTabEmpLeaveStatus.CssClass = "tab-btn";
            btnTabAccidental.CssClass = "tab-btn";
            btnTabMedical.CssClass = "tab-btn";
            btnTabUnpaid.CssClass = "tab-btn";
            btnTabCompensation.CssClass = "tab-btn";
            btnTabApproveUnpaid.CssClass = "tab-btn";
            btnTabApproveAnnual.CssClass = "tab-btn";
            btnTabEvaluate.CssClass = "tab-btn";

            // Reset all panels
            pnlEmpPerformance.CssClass = "panel";
            pnlEmpAttendance.CssClass = "panel";
            pnlEmpPayroll.CssClass = "panel";
            pnlEmpDeductions.CssClass = "panel";
            pnlEmpAnnualLeave.CssClass = "panel";
            pnlEmpLeaveStatus.CssClass = "panel";
            pnlAccidental.CssClass = "panel";
            pnlMedical.CssClass = "panel";
            pnlUnpaid.CssClass = "panel";
            pnlCompensation.CssClass = "panel";
            pnlApproveUnpaid.CssClass = "panel";
            pnlApproveAnnual.CssClass = "panel";
            pnlEvaluate.CssClass = "panel";

            switch (tabName)
            {
                case "EmpPerformance":
                    btnTabEmpPerformance.CssClass = "tab-btn active";
                    pnlEmpPerformance.CssClass = "panel active";
                    break;
                case "EmpAttendance":
                    btnTabEmpAttendance.CssClass = "tab-btn active";
                    pnlEmpAttendance.CssClass = "panel active";
                    break;
                case "EmpPayroll":
                    btnTabEmpPayroll.CssClass = "tab-btn active";
                    pnlEmpPayroll.CssClass = "panel active";
                    break;
                case "EmpDeductions":
                    btnTabEmpDeductions.CssClass = "tab-btn active";
                    pnlEmpDeductions.CssClass = "panel active";
                    break;
                case "EmpAnnualLeave":
                    btnTabEmpAnnualLeave.CssClass = "tab-btn active";
                    pnlEmpAnnualLeave.CssClass = "panel active";
                    break;
                case "EmpLeaveStatus":
                    btnTabEmpLeaveStatus.CssClass = "tab-btn active";
                    pnlEmpLeaveStatus.CssClass = "panel active";
                    break;
                case "Accidental":
                    btnTabAccidental.CssClass = "tab-btn active";
                    pnlAccidental.CssClass = "panel active";
                    break;
                case "Medical":
                    btnTabMedical.CssClass = "tab-btn active";
                    pnlMedical.CssClass = "panel active";
                    break;
                case "Unpaid":
                    btnTabUnpaid.CssClass = "tab-btn active";
                    pnlUnpaid.CssClass = "panel active";
                    break;
                case "Compensation":
                    btnTabCompensation.CssClass = "tab-btn active";
                    pnlCompensation.CssClass = "panel active";
                    break;
                case "ApproveUnpaid":
                    btnTabApproveUnpaid.CssClass = "tab-btn active";
                    pnlApproveUnpaid.CssClass = "panel active";
                    break;
                case "ApproveAnnual":
                    btnTabApproveAnnual.CssClass = "tab-btn active";
                    pnlApproveAnnual.CssClass = "panel active";
                    break;
                case "Evaluate":
                    btnTabEvaluate.CssClass = "tab-btn active";
                    pnlEvaluate.CssClass = "panel active";
                    break;
            }
        }
        #endregion

        #region Helper Methods
        private bool EmployeeExists(int employeeId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Employee WHERE employee_id = @id", conn);
                cmd.Parameters.AddWithValue("@id", employeeId);
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        private string GetEmployeeName(int employeeId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT first_name + ' ' + last_name FROM Employee WHERE employee_id = @id", conn);
                cmd.Parameters.AddWithValue("@id", employeeId);
                object result = cmd.ExecuteScalar();
                return result?.ToString() ?? "";
            }
        }

        private void ShowMessage(Label label, string message, bool isSuccess)
        {
            label.Text = message;
            label.CssClass = isSuccess ? "message message-success" : "message message-error";
            label.Visible = true;
        }
        #endregion

        #region 1. Apply for Accidental Leave
        protected void btnSubmitAccidental_Click(object sender, EventArgs e)
        {
            // Validate Employee ID
            int employeeId;
            if (string.IsNullOrWhiteSpace(txtAccEmpID.Text))
            {
                ShowMessage(lblAccidentalMessage, "✗ FAILED: Employee ID is required. Please enter your Employee ID in the Employee ID field.", false);
                return;
            }
            if (!int.TryParse(txtAccEmpID.Text, out employeeId))
            {
                ShowMessage(lblAccidentalMessage, "✗ FAILED: Invalid Employee ID format. Please enter a numeric Employee ID (e.g., 1, 2, 3).", false);
                return;
            }
            if (!EmployeeExists(employeeId))
            {
                ShowMessage(lblAccidentalMessage, "✗ FAILED: Employee ID " + employeeId + " does not exist in the system. Please verify your Employee ID and try again.", false);
                return;
            }

            // Validate Dates
            DateTime startDate, endDate;
            if (!DateTime.TryParse(txtAccStartDate.Text, out startDate))
            {
                ShowMessage(lblAccidentalMessage, "✗ FAILED: Invalid Start Date. Please select a valid start date from the calendar.", false);
                return;
            }
            if (!DateTime.TryParse(txtAccEndDate.Text, out endDate))
            {
                ShowMessage(lblAccidentalMessage, "✗ FAILED: Invalid End Date. Please select a valid end date from the calendar.", false);
                return;
            }
            if (endDate < startDate)
            {
                ShowMessage(lblAccidentalMessage, "✗ FAILED: End Date cannot be before Start Date. Please ensure the End Date is on or after the Start Date.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("Submit_accidental", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@start_date", startDate);
                    cmd.Parameters.AddWithValue("@end_date", endDate);
                    cmd.ExecuteNonQuery();

                    string empName = GetEmployeeName(employeeId);
                    ShowMessage(lblAccidentalMessage, "✓ SUCCESS: Accidental leave request submitted successfully for " + empName + " (ID: " + employeeId + "). Leave Period: " + startDate.ToString("yyyy-MM-dd") + " to " + endDate.ToString("yyyy-MM-dd") + ". Status: Pending HR approval.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblAccidentalMessage, "✗ FAILED: Unable to submit accidental leave. Reason: " + ex.Message + ". Please contact the system administrator if the problem persists.", false);
            }
        }
        #endregion

        #region 2. Apply for Medical Leave
        protected void btnSubmitMedical_Click(object sender, EventArgs e)
        {
            // Validate Employee ID
            int employeeId;
            if (string.IsNullOrWhiteSpace(txtMedEmpID.Text))
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: Employee ID is required. Please enter your Employee ID.", false);
                return;
            }
            if (!int.TryParse(txtMedEmpID.Text, out employeeId))
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: Invalid Employee ID format. Please enter a numeric Employee ID (e.g., 1, 2, 3).", false);
                return;
            }
            if (!EmployeeExists(employeeId))
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: Employee ID " + employeeId + " does not exist. Please verify your Employee ID and try again.", false);
                return;
            }

            // Validate Dates
            DateTime startDate, endDate;
            if (!DateTime.TryParse(txtMedStartDate.Text, out startDate))
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: Invalid Start Date. Please select a valid start date.", false);
                return;
            }
            if (!DateTime.TryParse(txtMedEndDate.Text, out endDate))
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: Invalid End Date. Please select a valid end date.", false);
                return;
            }
            if (endDate < startDate)
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: End Date cannot be before Start Date. Please correct the dates.", false);
                return;
            }

            // Validate Document Fields
            if (string.IsNullOrWhiteSpace(txtMedDocDescription.Text))
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: Document Description is required. Please describe your medical document (e.g., 'Doctor's certificate for sick leave').", false);
                return;
            }
            if (string.IsNullOrWhiteSpace(txtMedFileName.Text))
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: File Name is required. Please enter the name of your medical document file (e.g., 'medical_certificate.pdf').", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("Submit_medical", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@start_date", startDate);
                    cmd.Parameters.AddWithValue("@end_date", endDate);
                    cmd.Parameters.AddWithValue("@medical_type", ddlMedicalType.SelectedValue);
                    cmd.Parameters.AddWithValue("@insurance_status", chkInsurance.Checked ? 1 : 0);
                    cmd.Parameters.AddWithValue("@disability_details", txtDisabilityDetails.Text ?? "");
                    cmd.Parameters.AddWithValue("@document_description", txtMedDocDescription.Text);
                    cmd.Parameters.AddWithValue("@file_name", txtMedFileName.Text);
                    cmd.ExecuteNonQuery();

                    string empName = GetEmployeeName(employeeId);
                    string leaveType = ddlMedicalType.SelectedValue == "sick" ? "Sick Leave" : "Maternity Leave";
                    ShowMessage(lblMedicalMessage, "✓ SUCCESS: Medical leave request (" + leaveType + ") submitted successfully for " + empName + " (ID: " + employeeId + "). Leave Period: " + startDate.ToString("yyyy-MM-dd") + " to " + endDate.ToString("yyyy-MM-dd") + ". Status: Pending Medical Doctor and HR approval.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblMedicalMessage, "✗ FAILED: Unable to submit medical leave. Reason: " + ex.Message + ". Please ensure all fields are filled correctly and try again.", false);
            }
        }
        #endregion

        #region 3. Apply for Unpaid Leave
        protected void btnSubmitUnpaid_Click(object sender, EventArgs e)
        {
            // Validate Employee ID
            int employeeId;
            if (string.IsNullOrWhiteSpace(txtUnpaidEmpID.Text))
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Employee ID is required. Please enter your Employee ID.", false);
                return;
            }
            if (!int.TryParse(txtUnpaidEmpID.Text, out employeeId))
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Invalid Employee ID format. Please enter a numeric Employee ID.", false);
                return;
            }
            if (!EmployeeExists(employeeId))
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Employee ID " + employeeId + " does not exist. Please verify and try again.", false);
                return;
            }

            // Validate Dates
            DateTime startDate, endDate;
            if (!DateTime.TryParse(txtUnpaidStartDate.Text, out startDate))
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Invalid Start Date. Please select a valid start date.", false);
                return;
            }
            if (!DateTime.TryParse(txtUnpaidEndDate.Text, out endDate))
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Invalid End Date. Please select a valid end date.", false);
                return;
            }
            if (endDate < startDate)
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: End Date cannot be before Start Date.", false);
                return;
            }

            int numDays = (endDate - startDate).Days + 1;
            if (numDays > 30)
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Unpaid leave cannot exceed 30 days. Your request is for " + numDays + " days. Please reduce the leave duration.", false);
                return;
            }

            // Validate Document Fields
            if (string.IsNullOrWhiteSpace(txtUnpaidDocDescription.Text))
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Document Description is required. Please describe your memo document.", false);
                return;
            }
            if (string.IsNullOrWhiteSpace(txtUnpaidFileName.Text))
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: File Name is required. Please enter the memo file name.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("Submit_unpaid", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@start_date", startDate);
                    cmd.Parameters.AddWithValue("@end_date", endDate);
                    cmd.Parameters.AddWithValue("@document_description", txtUnpaidDocDescription.Text);
                    cmd.Parameters.AddWithValue("@file_name", txtUnpaidFileName.Text);
                    cmd.ExecuteNonQuery();

                    string empName = GetEmployeeName(employeeId);
                    ShowMessage(lblUnpaidMessage, "✓ SUCCESS: Unpaid leave request submitted successfully for " + empName + " (ID: " + employeeId + "). Leave Period: " + startDate.ToString("yyyy-MM-dd") + " to " + endDate.ToString("yyyy-MM-dd") + " (" + numDays + " days). Status: Pending Dean/President and HR approval.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblUnpaidMessage, "✗ FAILED: Unable to submit unpaid leave. Reason: " + ex.Message + ". Note: You can only have one unpaid leave per year and annual balance must be zero.", false);
            }
        }
        #endregion

        #region 4. Apply for Compensation Leave
        protected void btnSubmitCompensation_Click(object sender, EventArgs e)
        {
            // Validate Employee ID
            int employeeId;
            if (string.IsNullOrWhiteSpace(txtCompEmpID.Text))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Employee ID is required. Please enter your Employee ID.", false);
                return;
            }
            if (!int.TryParse(txtCompEmpID.Text, out employeeId))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Invalid Employee ID format. Please enter a numeric Employee ID.", false);
                return;
            }
            if (!EmployeeExists(employeeId))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Employee ID " + employeeId + " does not exist. Please verify and try again.", false);
                return;
            }

            // Validate Dates
            DateTime compensationDate, originalWorkday;
            if (!DateTime.TryParse(txtCompDate.Text, out compensationDate))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Invalid Compensation Date. Please select the day you want off.", false);
                return;
            }
            if (!DateTime.TryParse(txtOriginalWorkday.Text, out originalWorkday))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Invalid Original Workday Date. Please select the date you worked on your day off.", false);
                return;
            }

            // Validate Replacement ID
            int replacementId;
            if (string.IsNullOrWhiteSpace(txtCompReplacementID.Text))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Replacement Employee ID is required. Please enter the ID of the employee who will cover for you.", false);
                return;
            }
            if (!int.TryParse(txtCompReplacementID.Text, out replacementId))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Invalid Replacement Employee ID format. Please enter a numeric ID.", false);
                return;
            }
            if (!EmployeeExists(replacementId))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Replacement Employee ID " + replacementId + " does not exist. Please enter a valid employee ID.", false);
                return;
            }
            if (employeeId == replacementId)
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: You cannot be your own replacement. Please select a different employee.", false);
                return;
            }

            // Validate Reason
            if (string.IsNullOrWhiteSpace(txtCompReason.Text))
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Reason is required. Please explain why you worked on your day off (e.g., 'Proctoring exam', 'Grading').", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("Submit_compensation", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@compensation_date", compensationDate);
                    cmd.Parameters.AddWithValue("@reason", txtCompReason.Text);
                    cmd.Parameters.AddWithValue("@date_of_original_workday", originalWorkday);
                    cmd.Parameters.AddWithValue("@rep_emp_id", replacementId);
                    cmd.ExecuteNonQuery();

                    string empName = GetEmployeeName(employeeId);
                    string repName = GetEmployeeName(replacementId);
                    ShowMessage(lblCompensationMessage, "✓ SUCCESS: Compensation leave request submitted for " + empName + " (ID: " + employeeId + "). Day Off Requested: " + compensationDate.ToString("yyyy-MM-dd") + ". Original Workday: " + originalWorkday.ToString("yyyy-MM-dd") + ". Replacement: " + repName + ". Status: Pending HR approval.", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblCompensationMessage, "✗ FAILED: Unable to submit compensation leave. Reason: " + ex.Message + ". Note: You must have worked 8+ hours on your day off and apply within the same month.", false);
            }
        }
        #endregion

        #region 5. Approve/Reject Unpaid Leaves
        protected void btnLoadUnpaidLeaves_Click(object sender, EventArgs e)
        {
            int approverId;
            if (string.IsNullOrWhiteSpace(txtApproverUnpaidID.Text))
            {
                ShowMessage(lblApproveUnpaidMessage, "✗ FAILED: Approver ID is required. Please enter your Employee ID (must be Dean, Vice-Dean, or President).", false);
                return;
            }
            if (!int.TryParse(txtApproverUnpaidID.Text, out approverId))
            {
                ShowMessage(lblApproveUnpaidMessage, "✗ FAILED: Invalid Approver ID format. Please enter a numeric ID.", false);
                return;
            }
            if (!EmployeeExists(approverId))
            {
                ShowMessage(lblApproveUnpaidMessage, "✗ FAILED: Approver ID " + approverId + " does not exist. Please verify your ID.", false);
                return;
            }

            Session["ApproverUnpaidID"] = approverId;
            LoadUnpaidLeaves(approverId);

            string approverName = GetEmployeeName(approverId);
            if (gvUnpaidLeaves.Rows.Count > 0)
            {
                ShowMessage(lblApproveUnpaidMessage, "✓ SUCCESS: Loaded " + gvUnpaidLeaves.Rows.Count + " pending unpaid leave request(s) for approver " + approverName + " (ID: " + approverId + ").", true);
            }
            else
            {
                ShowMessage(lblApproveUnpaidMessage, "ℹ INFO: No pending unpaid leave requests found for approver " + approverName + " (ID: " + approverId + "). You may not have any requests awaiting your approval.", true);
            }
        }

        private void LoadUnpaidLeaves(int approverId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT L.request_ID, 
                           E.first_name + ' ' + E.last_name as emp_name,
                           E.dept_name,
                           L.start_date, L.end_date, L.num_days, L.final_approval_status
                    FROM Leave L
                    INNER JOIN Unpaid_Leave UL ON L.request_ID = UL.request_ID
                    INNER JOIN Employee E ON UL.Emp_ID = E.employee_id
                    INNER JOIN Employee_Approve_Leave EAL ON L.request_ID = EAL.leave_ID
                    WHERE EAL.Emp1_ID = @approver_id AND EAL.status = 'Pending'
                    AND L.final_approval_status = 'Pending'", conn);
                cmd.Parameters.AddWithValue("@approver_id", approverId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                gvUnpaidLeaves.DataSource = dt;
                gvUnpaidLeaves.DataBind();
            }
        }

        protected void gvUnpaidLeaves_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["ApproverUnpaidID"] == null)
            {
                ShowMessage(lblApproveUnpaidMessage, "✗ FAILED: Session expired. Please enter your Approver ID and click 'Load Pending Requests' again.", false);
                return;
            }

            int requestId = Convert.ToInt32(e.CommandArgument);
            int upperboardId = (int)Session["ApproverUnpaidID"];

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    if (e.CommandName == "ApproveUnpaid")
                    {
                        SqlCommand cmd = new SqlCommand("Upperboard_approve_unpaids", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@request_ID", requestId);
                        cmd.Parameters.AddWithValue("@upperboard_ID", upperboardId);
                        cmd.ExecuteNonQuery();

                        ShowMessage(lblApproveUnpaidMessage, "✓ SUCCESS: Unpaid leave request #" + requestId + " has been APPROVED. The employee will be notified of your decision.", true);
                    }
                    else if (e.CommandName == "RejectUnpaid")
                    {
                        SqlCommand cmd = new SqlCommand(@"
                            UPDATE Employee_Approve_Leave SET status = 'Rejected' 
                            WHERE leave_ID = @request_ID AND Emp1_ID = @upperboard_ID;
                            UPDATE Leave SET final_approval_status = 'Rejected' 
                            WHERE request_ID = @request_ID", conn);
                        cmd.Parameters.AddWithValue("@request_ID", requestId);
                        cmd.Parameters.AddWithValue("@upperboard_ID", upperboardId);
                        cmd.ExecuteNonQuery();

                        ShowMessage(lblApproveUnpaidMessage, "✓ SUCCESS: Unpaid leave request #" + requestId + " has been REJECTED. The employee will be notified of your decision.", true);
                    }

                    LoadUnpaidLeaves(upperboardId);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblApproveUnpaidMessage, "✗ FAILED: Unable to process request #" + requestId + ". Reason: " + ex.Message, false);
            }
        }
        #endregion

        #region 6. Approve/Reject Annual Leaves
        protected void btnLoadAnnualLeaves_Click(object sender, EventArgs e)
        {
            int approverId;
            if (string.IsNullOrWhiteSpace(txtApproverAnnualID.Text))
            {
                ShowMessage(lblApproveAnnualMessage, "✗ FAILED: Approver ID is required. Please enter your Employee ID (must be Dean, Vice-Dean, or President).", false);
                return;
            }
            if (!int.TryParse(txtApproverAnnualID.Text, out approverId))
            {
                ShowMessage(lblApproveAnnualMessage, "✗ FAILED: Invalid Approver ID format. Please enter a numeric ID.", false);
                return;
            }
            if (!EmployeeExists(approverId))
            {
                ShowMessage(lblApproveAnnualMessage, "✗ FAILED: Approver ID " + approverId + " does not exist. Please verify your ID.", false);
                return;
            }

            Session["ApproverAnnualID"] = approverId;
            LoadAnnualLeaves(approverId);

            string approverName = GetEmployeeName(approverId);
            if (gvAnnualLeaves.Rows.Count > 0)
            {
                ShowMessage(lblApproveAnnualMessage, "✓ SUCCESS: Loaded " + gvAnnualLeaves.Rows.Count + " pending annual leave request(s) for approver " + approverName + " (ID: " + approverId + ").", true);
            }
            else
            {
                ShowMessage(lblApproveAnnualMessage, "ℹ INFO: No pending annual leave requests found for approver " + approverName + " (ID: " + approverId + "). You may not have any requests awaiting your approval.", true);
            }
        }

        private void LoadAnnualLeaves(int approverId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT L.request_ID, 
                           E.first_name + ' ' + E.last_name as emp_name,
                           E.dept_name,
                           L.start_date, L.end_date, L.num_days, L.final_approval_status,
                           AL.replacement_emp,
                           E2.first_name + ' ' + E2.last_name as replacement_name
                    FROM Leave L
                    INNER JOIN Annual_Leave AL ON L.request_ID = AL.request_ID
                    INNER JOIN Employee E ON AL.emp_ID = E.employee_id
                    LEFT JOIN Employee E2 ON AL.replacement_emp = E2.employee_id
                    INNER JOIN Employee_Approve_Leave EAL ON L.request_ID = EAL.leave_ID
                    WHERE EAL.Emp1_ID = @approver_id AND EAL.status = 'Pending'
                    AND L.final_approval_status = 'Pending'", conn);
                cmd.Parameters.AddWithValue("@approver_id", approverId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                gvAnnualLeaves.DataSource = dt;
                gvAnnualLeaves.DataBind();
            }
        }

        protected void gvAnnualLeaves_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["ApproverAnnualID"] == null)
            {
                ShowMessage(lblApproveAnnualMessage, "✗ FAILED: Session expired. Please enter your Approver ID and click 'Load Pending Requests' again.", false);
                return;
            }

            string[] args = e.CommandArgument.ToString().Split(',');
            int requestId = Convert.ToInt32(args[0]);
            int replacementId = Convert.ToInt32(args[1]);
            int upperboardId = (int)Session["ApproverAnnualID"];

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    if (e.CommandName == "ApproveAnnual")
                    {
                        SqlCommand cmd = new SqlCommand("Upperboard_approve_annual", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@request_ID", requestId);
                        cmd.Parameters.AddWithValue("@Upperboard_ID", upperboardId);
                        cmd.Parameters.AddWithValue("@replacement_ID", replacementId);
                        cmd.ExecuteNonQuery();

                        ShowMessage(lblApproveAnnualMessage, "✓ SUCCESS: Annual leave request #" + requestId + " has been APPROVED. The employee and replacement have been notified.", true);
                    }
                    else if (e.CommandName == "RejectAnnual")
                    {
                        SqlCommand cmd = new SqlCommand(@"
                            UPDATE Employee_Approve_Leave SET status = 'Rejected' 
                            WHERE leave_ID = @request_ID AND Emp1_ID = @upperboard_ID;
                            UPDATE Leave SET final_approval_status = 'Rejected' 
                            WHERE request_ID = @request_ID", conn);
                        cmd.Parameters.AddWithValue("@request_ID", requestId);
                        cmd.Parameters.AddWithValue("@upperboard_ID", upperboardId);
                        cmd.ExecuteNonQuery();

                        ShowMessage(lblApproveAnnualMessage, "✓ SUCCESS: Annual leave request #" + requestId + " has been REJECTED. The employee will be notified.", true);
                    }

                    LoadAnnualLeaves(upperboardId);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblApproveAnnualMessage, "✗ FAILED: Unable to process request #" + requestId + ". Reason: " + ex.Message + ". The replacement employee may be on leave or not in the same department.", false);
            }
        }
        #endregion

        #region 7. Evaluate Employees
        protected void btnLoadEmployees_Click(object sender, EventArgs e)
        {
            int deanId;
            if (string.IsNullOrWhiteSpace(txtDeanID.Text))
            {
                ShowMessage(lblEvaluateMessage, "✗ FAILED: Dean ID is required. Please enter your Employee ID (must be a Dean).", false);
                return;
            }
            if (!int.TryParse(txtDeanID.Text, out deanId))
            {
                ShowMessage(lblEvaluateMessage, "✗ FAILED: Invalid Dean ID format. Please enter a numeric ID.", false);
                return;
            }
            if (!EmployeeExists(deanId))
            {
                ShowMessage(lblEvaluateMessage, "✗ FAILED: Dean ID " + deanId + " does not exist. Please verify your ID.", false);
                return;
            }

            Session["DeanID"] = deanId;
            LoadDepartmentEmployees(deanId);
            LoadEvaluations(deanId);
        }

        private void LoadDepartmentEmployees(int deanId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Get dean's department
                SqlCommand deptCmd = new SqlCommand("SELECT dept_name FROM Employee WHERE employee_id = @dean_id", conn);
                deptCmd.Parameters.AddWithValue("@dean_id", deanId);
                object deptResult = deptCmd.ExecuteScalar();

                if (deptResult == null || deptResult == DBNull.Value || string.IsNullOrEmpty(deptResult.ToString()))
                {
                    ShowMessage(lblEvaluateMessage, "✗ FAILED: Employee ID " + deanId + " does not have a department assigned. Only Deans with assigned departments can evaluate employees.", false);
                    return;
                }

                string department = deptResult.ToString();
                Session["DeanDepartment"] = department;

                SqlCommand cmd = new SqlCommand(@"
                    SELECT employee_id, first_name + ' ' + last_name as emp_name
                    FROM Employee
                    WHERE dept_name = @dept_name AND employee_id != @dean_id
                    ORDER BY first_name, last_name", conn);
                cmd.Parameters.AddWithValue("@dept_name", department);
                cmd.Parameters.AddWithValue("@dean_id", deanId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                ddlEmployees.DataSource = dt;
                ddlEmployees.DataTextField = "emp_name";
                ddlEmployees.DataValueField = "employee_id";
                ddlEmployees.DataBind();

                string deanName = GetEmployeeName(deanId);
                if (dt.Rows.Count == 0)
                {
                    ddlEmployees.Items.Insert(0, new ListItem("No employees found", "0"));
                    ShowMessage(lblEvaluateMessage, "ℹ INFO: No employees found in department '" + department + "' for Dean " + deanName + ". There are no employees to evaluate.", true);
                }
                else
                {
                    ShowMessage(lblEvaluateMessage, "✓ SUCCESS: Loaded " + dt.Rows.Count + " employee(s) from department '" + department + "' for Dean " + deanName + " (ID: " + deanId + "). Select an employee to evaluate.", true);
                }
            }
        }

        private void LoadEvaluations(int deanId)
        {
            if (Session["DeanDepartment"] == null) return;

            string department = Session["DeanDepartment"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT P.performance_ID, E.first_name + ' ' + E.last_name as emp_name,
                           P.semester, P.rating, P.comments
                    FROM Performance P
                    INNER JOIN Employee E ON P.emp_ID = E.employee_id
                    WHERE E.dept_name = @dept_name
                    ORDER BY P.performance_ID DESC", conn);
                cmd.Parameters.AddWithValue("@dept_name", department);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                gvEvaluations.DataSource = dt;
                gvEvaluations.DataBind();
            }
        }

        protected void btnSubmitEvaluation_Click(object sender, EventArgs e)
        {
            if (Session["DeanID"] == null)
            {
                ShowMessage(lblEvaluateMessage, "✗ FAILED: Please load department employees first by entering your Dean ID and clicking 'Load Department Employees'.", false);
                return;
            }

            int employeeId;
            if (!int.TryParse(ddlEmployees.SelectedValue, out employeeId) || employeeId == 0)
            {
                ShowMessage(lblEvaluateMessage, "✗ FAILED: Please select an employee to evaluate from the dropdown list.", false);
                return;
            }

            int rating = Convert.ToInt32(ddlRating.SelectedValue);
            string semester = ddlSemester.SelectedValue;
            string comments = txtEvalComments.Text;

            if (string.IsNullOrWhiteSpace(comments))
            {
                ShowMessage(lblEvaluateMessage, "✗ FAILED: Comments are required. Please provide feedback about the employee's performance.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("Dean_andHR_Evaluation", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@rating", rating);
                    cmd.Parameters.AddWithValue("@comment", comments);
                    cmd.Parameters.AddWithValue("@semester", semester);
                    cmd.ExecuteNonQuery();

                    string empName = GetEmployeeName(employeeId);
                    string ratingText = ddlRating.SelectedItem.Text;
                    ShowMessage(lblEvaluateMessage, "✓ SUCCESS: Evaluation submitted for " + empName + " (ID: " + employeeId + "). Semester: " + semester + ". Rating: " + ratingText + ". The evaluation has been recorded in the system.", true);
                    txtEvalComments.Text = "";
                    LoadEvaluations((int)Session["DeanID"]);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblEvaluateMessage, "✗ FAILED: Unable to submit evaluation. Reason: " + ex.Message + ". Please try again.", false);
            }
        }
        #endregion

        // === FULL Employee11 Functionalities ===
        protected void btnGetPerformance_Click(object sender, EventArgs e)
        {
            lblPerformanceMessage.Visible = false;
            string empId = txtPerfEmpId.Text.Trim();
            string semester = txtSemester.Text.Trim();
            int id;
            if (!int.TryParse(empId, out id) || id <= 0)
            {
                lblPerformanceMessage.Text = "This ID is invalid.";
                lblPerformanceMessage.Visible = true;
                gridPerformance.Visible = false;
                return;
            }
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @id", conn))
            {
                checkCmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                var cnt = (int)checkCmd.ExecuteScalar();
                conn.Close();
                if (cnt == 0)
                {
                    lblPerformanceMessage.Text = "This ID is invalid.";
                    lblPerformanceMessage.Visible = true;
                    gridPerformance.Visible = false;
                    return;
                }
            }
            if (string.IsNullOrEmpty(semester))
                return;
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand semCmd = new SqlCommand("SELECT COUNT(1) FROM Performance WHERE semester = @semester", conn))
            {
                semCmd.Parameters.AddWithValue("@semester", semester);
                conn.Open();
                var semcnt = (int)semCmd.ExecuteScalar();
                conn.Close();
                if (semcnt == 0)
                {
                    lblPerformanceMessage.Text = "This semester is invalid.";
                    lblPerformanceMessage.Visible = true;
                    gridPerformance.Visible = false;
                    return;
                }
            }
            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.MyPerformance(@employee_ID, @semester)", conn))
            {
                cmd.Parameters.AddWithValue("@employee_ID", id);
                cmd.Parameters.AddWithValue("@semester", semester);
                DataTable dt = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
                gridPerformance.DataSource = dt;
                gridPerformance.Visible = true;
                gridPerformance.DataBind();
            }
        }

        protected void btnGetAttendance_Click(object sender, EventArgs e)
        {
            lblAttendanceMessage.Visible = false;
            try
            {
                string empId = txtAttendEmpId.Text.Trim();
                int id;
                if (string.IsNullOrEmpty(empId))
                {
                    lblAttendanceMessage.Text = "Please enter Employee ID.";
                    lblAttendanceMessage.Visible = true;
                    gridAttendance.Visible = false;
                    return;
                }
                if (!int.TryParse(empId, out id) || id <= 0)
                {
                    lblAttendanceMessage.Text = "This ID is invalid. Please enter a valid ID.";
                    lblAttendanceMessage.Visible = true;
                    gridAttendance.Visible = false;
                    return;
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @id", conn))
                {
                    checkCmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    var cnt = (int)checkCmd.ExecuteScalar();
                    conn.Close();
                    if (cnt == 0)
                    {
                        lblAttendanceMessage.Text = "This ID is invalid. Please enter a valid ID.";
                        lblAttendanceMessage.Visible = true;
                        gridAttendance.Visible = false;
                        return;
                    }
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.MyAttendance_All(@employee_ID)", conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", id);
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                    gridAttendance.DataSource = dt;
                    gridAttendance.DataBind();
                    gridAttendance.Visible = true;
                    if (dt.Rows.Count == 0)
                    {
                        lblAttendanceMessage.Text = "No attendance records found.";
                        lblAttendanceMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblAttendanceMessage.Text = "Error in Attendance section: " + ex.Message;
                lblAttendanceMessage.Visible = true;
                gridAttendance.Visible = false;
            }
        }

        protected void btnGetPayroll_Click(object sender, EventArgs e)
        {
            lblPayrollMessage.Visible = false;
            try
            {
                string empId = txtPayrollEmpId.Text.Trim();
                int id;
                if (string.IsNullOrEmpty(empId))
                {
                    lblPayrollMessage.Text = "Please enter Employee ID.";
                    lblPayrollMessage.Visible = true;
                    gridPayroll.Visible = false;
                    return;
                }
                if (!int.TryParse(empId, out id) || id <= 0)
                {
                    lblPayrollMessage.Text = "This ID is invalid. Please enter a valid ID.";
                    lblPayrollMessage.Visible = true;
                    gridPayroll.Visible = false;
                    return;
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @id", conn))
                {
                    checkCmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    var cnt = (int)checkCmd.ExecuteScalar();
                    conn.Close();
                    if (cnt == 0)
                    {
                        lblPayrollMessage.Text = "This ID is invalid. Please enter a valid ID.";
                        lblPayrollMessage.Visible = true;
                        gridPayroll.Visible = false;
                        return;
                    }
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.AllPayroll(@employee_ID)", conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", id);
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                    gridPayroll.DataSource = dt;
                    gridPayroll.DataBind();
                    gridPayroll.Visible = true;
                    if (dt.Rows.Count == 0)
                    {
                        lblPayrollMessage.Text = "No payroll records found.";
                        lblPayrollMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblPayrollMessage.Text = "Error in Payroll section: " + ex.Message;
                lblPayrollMessage.Visible = true;
                gridPayroll.Visible = false;
            }
        }

        protected void btnGetDeductions_Click(object sender, EventArgs e)
        {
            lblDeductionsMessage.Visible = false;
            try
            {
                string empId = txtDeductionEmpId.Text.Trim();
                string monthStr = txtDeductionMonth.Text.Trim();
                int id, month = 0;
                if (string.IsNullOrEmpty(empId))
                {
                    lblDeductionsMessage.Text = "Please enter Employee ID and valid month.";
                    lblDeductionsMessage.Visible = true;
                    gridDeductions.Visible = false;
                    return;
                }
                int idIsValid = 1, monthIsValid = 1;
                if (!int.TryParse(empId, out id) || id <= 0)
                {
                    idIsValid = 0;
                }
                else
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @id", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        var cnt = (int)checkCmd.ExecuteScalar();
                        conn.Close();
                        if (cnt == 0)
                        {
                            idIsValid = 0;
                        }
                    }
                }
                if (!int.TryParse(monthStr, out month) || month < 1 || month > 12)
                {
                    monthIsValid = 0;
                }
                if (idIsValid == 0 && monthIsValid == 0)
                {
                    lblDeductionsMessage.Text = "The ID and month you have entered are invalid, please re-enter both.";
                    lblDeductionsMessage.Visible = true;
                    gridDeductions.Visible = false;
                    return;
                }
                if (idIsValid == 0)
                {
                    lblDeductionsMessage.Text = "This ID is invalid. Please enter a valid ID.";
                    lblDeductionsMessage.Visible = true;
                    gridDeductions.Visible = false;
                    return;
                }
                if (monthIsValid == 0)
                {
                    lblDeductionsMessage.Text = "This is an invalid month. Please enter a month between 1 and 12.";
                    lblDeductionsMessage.Visible = true;
                    gridDeductions.Visible = false;
                    return;
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.Deductions_Attendance(@employee_ID, @month)", conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", id);
                    cmd.Parameters.AddWithValue("@month", month);
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                    gridDeductions.DataSource = dt;
                    gridDeductions.DataBind();
                    gridDeductions.Visible = true;
                    if (dt.Rows.Count == 0)
                    {
                        lblDeductionsMessage.Text = "No deduction records found.";
                        lblDeductionsMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblDeductionsMessage.Text = "Error in Deductions section: " + ex.Message;
                lblDeductionsMessage.Visible = true;
                gridDeductions.Visible = false;
            }
        }

        protected void btnApplyLeave_Click(object sender, EventArgs e)
        {
            lblLeaveMessage.Visible = false;
            lblLeaveMessage.Text = "";
            try
            {
                string empId = txtApplyEmpId.Text.Trim();
                string replId = txtReplacementEmp.Text.Trim();
                string startDate = txtLeaveStart.Text.Trim();
                string endDate = txtLeaveEnd.Text.Trim();
                if (string.IsNullOrEmpty(empId) || string.IsNullOrEmpty(replId) || string.IsNullOrEmpty(startDate) || string.IsNullOrEmpty(endDate))
                {
                    lblLeaveMessage.Text = "Please fill all fields.";
                    lblLeaveMessage.CssClass = "message-error";
                    lblLeaveMessage.Visible = true;
                    return;
                }
                int id, repId;
                int existsEmpId = 1, existsReplId = 1;
                if (!int.TryParse(empId, out id) || id <= 0)
                {
                    existsEmpId = 0;
                }
                else
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @id", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        var cnt = (int)checkCmd.ExecuteScalar();
                        conn.Close();
                        if (cnt == 0) existsEmpId = 0;
                    }
                }
                if (!int.TryParse(replId, out repId) || repId <= 0)
                {
                    existsReplId = 0;
                }
                else
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @id", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@id", repId);
                        conn.Open();
                        var cnt = (int)checkCmd.ExecuteScalar();
                        conn.Close();
                        if (cnt == 0) existsReplId = 0;
                    }
                }
                if (existsEmpId == 0 && existsReplId == 0)
                {
                    lblLeaveMessage.Text = "Both your employee id and the replacement employee_ID are invalid please re enter them";
                    lblLeaveMessage.CssClass = "message-error";
                    lblLeaveMessage.Visible = true;
                    return;
                }
                if (existsEmpId == 0)
                {
                    lblLeaveMessage.Text = "Your ID is invalid. Please enter a valid ID.";
                    lblLeaveMessage.CssClass = "message-error";
                    lblLeaveMessage.Visible = true;
                    return;
                }
                if (existsReplId == 0)
                {
                    lblLeaveMessage.Text = "The replacement ID you have entered is invalid. Please re-enter the replacement employee ID.";
                    lblLeaveMessage.CssClass = "message-error";
                    lblLeaveMessage.Visible = true;
                    return;
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("Submit_annual", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", id);
                    cmd.Parameters.AddWithValue("@replacement_emp", repId);
                    cmd.Parameters.AddWithValue("@start_date", DateTime.Parse(startDate));
                    cmd.Parameters.AddWithValue("@end_date", DateTime.Parse(endDate));
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblLeaveMessage.Text = "Annual leave request submitted.";
                    lblLeaveMessage.CssClass = "message-success";
                    lblLeaveMessage.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblLeaveMessage.Text = "Error: " + ex.Message;
                lblLeaveMessage.CssClass = "message-error";
                lblLeaveMessage.Visible = true;
            }
        }

        protected void btnGetLeavesStatus_Click(object sender, EventArgs e)
        {
            lblLeaveStatusMessage.Visible = false;
            try
            {
                string empId = txtStatusEmpId.Text.Trim();
                int id;
                if (string.IsNullOrEmpty(empId))
                {
                    lblLeaveStatusMessage.Text = "Please enter Employee ID.";
                    lblLeaveStatusMessage.Visible = true;
                    gridLeavesStatus.Visible = false;
                    return;
                }
                if (!int.TryParse(empId, out id) || id <= 0)
                {
                    lblLeaveStatusMessage.Text = "You have entered an invalid ID please re-enter a valid ID.";
                    lblLeaveStatusMessage.Visible = true;
                    gridLeavesStatus.Visible = false;
                    return;
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @id", conn))
                {
                    checkCmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    var cnt = (int)checkCmd.ExecuteScalar();
                    conn.Close();
                    if (cnt == 0)
                    {
                        lblLeaveStatusMessage.Text = "You have entered an invalid ID please re-enter a valid ID.";
                        lblLeaveStatusMessage.Visible = true;
                        gridLeavesStatus.Visible = false;
                        return;
                    }
                }
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.status_leaves(@employee_ID)", conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                    gridLeavesStatus.DataSource = dt;
                    gridLeavesStatus.DataBind();
                    gridLeavesStatus.Visible = true;
                    if (dt.Rows.Count == 0)
                    {
                        lblLeaveStatusMessage.Text = "No leave status records found.";
                        lblLeaveStatusMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblLeaveStatusMessage.Text = "Error in Leave Status section: " + ex.Message;
                lblLeaveStatusMessage.Visible = true;
                gridLeavesStatus.Visible = false;
            }
        }
    }
}
