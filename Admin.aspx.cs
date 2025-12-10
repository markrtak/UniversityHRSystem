using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniversityHRSystem128
{
    public partial class Admin : System.Web.UI.Page
    {
        // Connection string - reads from Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["MyDbConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    using (var conn = new SqlConnection(connectionString))
                    {
                        conn.Open(); // Test DB connection for first page load only.
                    }
                }
                catch (SqlException)
                {
                    Response.Redirect("DbError.aspx");
                    return;
                }
                // Clear all messages on initial load
                ClearAllMessages();
            }
        }

        #region Navigation

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            // Redirect to main landing page
            Response.Redirect("~/Default.aspx");
        }

        #endregion

        #region Part 1 - Core Admin Functions

        // 1. Fetch Employee Profiles
        protected void btnFetchProfiles_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    string query = "SELECT * FROM allEmployeeProfiles";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvEmployeeProfiles.DataSource = dt;
                    gvEmployeeProfiles.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        ShowMessage(lblProfilesMessage, null,
                            $"Successfully loaded {dt.Rows.Count} employee profile(s).",
                            "success", null);
                    }
                    else
                    {
                        ShowMessage(lblProfilesMessage, null,
                            "No employee profiles found.",
                            "info", null);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblProfilesMessage, null,
                    "Error loading employee profiles.",
                    "error",
                    new string[] { $"Technical details: {ex.Message}" });
            }
        }

        // 2. Fetch Employees per Department
        protected void btnFetchDeptCount_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    string query = "SELECT * FROM NoEmployeeDept";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvDeptCount.DataSource = dt;
                    gvDeptCount.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        ShowMessage(lblDeptCountMessage, null,
                            $"Successfully loaded department data.",
                            "success", null);
                    }
                    else
                    {
                        ShowMessage(lblDeptCountMessage, null,
                            "No department data found.",
                            "info", null);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblDeptCountMessage, null,
                    "Error loading department data.",
                    "error",
                    new string[] { $"Technical details: {ex.Message}" });
            }
        }

        // 3. Fetch Rejected Medical Leaves
        protected void btnFetchRejected_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    string query = "SELECT * FROM allRejectedMedicals";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvRejectedMedical.DataSource = dt;
                    gvRejectedMedical.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        ShowMessage(lblRejectedMessage, null,
                            $"Successfully loaded {dt.Rows.Count} rejected medical leave(s).",
                            "success", null);
                    }
                    else
                    {
                        ShowMessage(lblRejectedMessage, null,
                            "No rejected medical leaves found.",
                            "info", null);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblRejectedMessage, null,
                    "Error loading rejected medical leaves.",
                    "error",
                    new string[] { $"Technical details: {ex.Message}" });
            }
        }

        // 4. Remove Deductions for Resigned Employees
        protected void btnRemoveDeductions_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    SqlCommand cmd = new SqlCommand("Remove_Deductions", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();

                    ShowMessage(lblDeductionsMessage, null,
                        "Deductions removed successfully for resigned employees.",
                        "success", null);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblDeductionsMessage, null,
                    "Error removing deductions.",
                    "error",
                    new string[] { $"Technical details: {ex.Message}" });
            }
        }

        // 5. Update Attendance Record
        protected void btnUpdateAttendance_Click(object sender, EventArgs e)
        {
            // Collect and trim input values
            string empIdText = txtUpdateEmpID.Text.Trim();
            string checkInText = txtCheckIn.Text.Trim();
            string checkOutText = txtCheckOut.Text.Trim();

            // Build a list of missing fields
            List<string> missingFields = new List<string>();
            if (string.IsNullOrEmpty(empIdText)) missingFields.Add("Employee ID");
            if (string.IsNullOrEmpty(checkInText)) missingFields.Add("Check-In Time");
            if (string.IsNullOrEmpty(checkOutText)) missingFields.Add("Check-Out Time");

            // Show error if any field is missing
            if (missingFields.Count > 0)
            {
                ShowMessage(lblUpdateAttendanceMessage, null,
                    "Please add the following: " + string.Join(", ", missingFields),
                    "error", null);
                return;
            }

            // Safe parsing
            int empId;
            TimeSpan checkInTime, checkOutTime;

            if (!int.TryParse(empIdText, out empId) ||
                !TimeSpan.TryParse(checkInText, out checkInTime) ||
                !TimeSpan.TryParse(checkOutText, out checkOutTime))
            {
                ShowMessage(lblUpdateAttendanceMessage, null,
                    "Invalid format. Please enter valid numeric ID and time in HH:MM format.",
                    "error", null);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    SqlCommand cmd = new SqlCommand("Update_Attendance", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Employee_id", empId);
                    cmd.Parameters.AddWithValue("@check_in_time", checkInTime);
                    cmd.Parameters.AddWithValue("@check_out_time", checkOutTime);
                    cmd.ExecuteNonQuery();

                    ShowMessage(lblUpdateAttendanceMessage, null,
                        "Attendance updated successfully.",
                        "success", null);

                    // Clear fields
                    txtUpdateEmpID.Text = "";
                    txtCheckIn.Text = "";
                    txtCheckOut.Text = "";
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblUpdateAttendanceMessage, null,
                    "Error updating attendance.",
                    "error",
                    new string[] { $"Technical details: {ex.Message}" });
            }
        }

        // 6. Add New Holiday
        protected void btnAddHoliday_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    SqlCommand cmd = new SqlCommand("Add_Holiday", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@holiday_name", txtHolidayName.Text);

                    DateTime fromDate, toDate;
                    if (DateTime.TryParse(txtHolidayFromDate.Text, out fromDate))
                        cmd.Parameters.AddWithValue("@from_date", fromDate);
                    else
                        cmd.Parameters.AddWithValue("@from_date", DBNull.Value);

                    if (DateTime.TryParse(txtHolidayToDate.Text, out toDate))
                        cmd.Parameters.AddWithValue("@to_date", toDate);
                    else
                        cmd.Parameters.AddWithValue("@to_date", DBNull.Value);

                    cmd.ExecuteNonQuery();

                    ShowMessage(lblAddHolidayMessage, null,
                        "Holiday added successfully.",
                        "success", null);

                    // Clear fields
                    txtHolidayName.Text = "";
                    txtHolidayFromDate.Text = "";
                    txtHolidayToDate.Text = "";
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblAddHolidayMessage, null,
                    "Error adding holiday.",
                    "error",
                    new string[] { $"Technical details: {ex.Message}" });
            }
        }

        // 7. Initiate Attendance for Today
        protected void btnInitiateAttendance_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    SqlCommand cmd = new SqlCommand("Initiate_Attendance", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();

                    ShowMessage(lblInitiateMessage, null,
                        "Attendance records initiated successfully for all employees today.",
                        "success", null);
                }
            }
            catch (Exception ex)
            {
                ShowMessage(lblInitiateMessage, null,
                    "Error initiating attendance.",
                    "error",
                    new string[] { $"Technical details: {ex.Message}" });
            }
        }

        #endregion

        #region Part 2 - Advanced Admin Functions

        // 1. Fetch Yesterday's Attendance Records
        protected void btnFetchYesterdayAttendance_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }
                    string query = "SELECT * FROM allEmployeeAttendance";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        gvYesterdayAttendance.DataSource = dt;
                        gvYesterdayAttendance.DataBind();

                        if (dt.Rows.Count > 0)
                        {
                            ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                                $"Successfully retrieved {dt.Rows.Count} attendance record(s) for yesterday.",
                                "success", null);
                        }
                        else
                        {
                            ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                                "No attendance records found for yesterday.",
                                "info",
                                new string[] {
                                    "Ensure attendance was initiated for yesterday using 'Initiate_Attendance' procedure",
                                    "Verify that employees were marked present yesterday",
                                    "Check if yesterday was a holiday or weekend"
                                });
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                    "Database error while fetching attendance records.",
                    "error",
                    new string[] {
                        "Verify the database connection is active",
                        "Ensure the 'allEmployeeAttendance' view exists in the database",
                        "Contact your database administrator if the issue persists",
                        $"Technical details: {ex.Message}"
                    });
            }
            catch (Exception ex)
            {
                ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                    "An unexpected error occurred while fetching attendance records.",
                    "error",
                    new string[] {
                        "Refresh the page and try again",
                        "If the problem persists, contact technical support",
                        $"Technical details: {ex.Message}"
                    });
            }
        }

        // 2. Fetch Winter Performance Records
        protected void btnFetchWinterPerformance_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }
                    string query = "SELECT * FROM allPerformance";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        gvWinterPerformance.DataSource = dt;
                        gvWinterPerformance.DataBind();

                        if (dt.Rows.Count > 0)
                        {
                            ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                                $"Successfully retrieved {dt.Rows.Count} performance record(s) for Winter semesters.",
                                "success", null);
                        }
                        else
                        {
                            ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                                "No performance records found for Winter semesters.",
                                "info",
                                new string[] {
                                    "Performance evaluations may not have been submitted yet",
                                    "Use the 'Dean_andHR_Evaluation' procedure to add performance records",
                                    "Ensure the semester code starts with 'W' (e.g., 'W24', 'W25')"
                                });
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                    "Database error while fetching performance records.",
                    "error",
                    new string[] {
                        "Verify the database connection is active",
                        "Ensure the 'allPerformance' view exists in the database",
                        "Contact your database administrator if the issue persists",
                        $"Technical details: {ex.Message}"
                    });
            }
            catch (Exception ex)
            {
                ShowMessage(lblGlobalMessage, pnlGlobalMessage,
                    "An unexpected error occurred while fetching performance records.",
                    "error",
                    new string[] {
                        "Refresh the page and try again",
                        "If the problem persists, contact technical support",
                        $"Technical details: {ex.Message}"
                    });
            }
        }

        // 3. Remove Attendance Records During Holidays
        protected void btnRemoveHolidays_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    using (SqlCommand cmd = new SqlCommand("Remove_Holiday", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        int rowsAffected = cmd.ExecuteNonQuery();

                        ShowMessage(lblHolidayMessage, null,
                            "Successfully removed attendance records during official holidays.",
                            "success",
                            new string[] {
                                "All attendance entries falling within holiday dates have been deleted",
                                "You may now proceed to other attendance management tasks"
                            });
                    }
                }
            }
            catch (SqlException ex)
            {
                string errorMessage = "Database error while removing holiday attendance records.";
                string[] steps;

                if (ex.Message.Contains("Holiday") || ex.Number == 208)
                {
                    steps = new string[] {
                        "The Holiday table may not exist. Run 'EXEC Create_Holiday' first",
                        "Add holidays using 'EXEC Add_Holiday' procedure",
                        "Verify you have DELETE permissions on the Attendance table",
                        $"Technical details: {ex.Message}"
                    };
                }
                else
                {
                    steps = new string[] {
                        "Check your database connection",
                        "Ensure the 'Remove_Holiday' procedure exists",
                        "Contact database administrator if the issue persists",
                        $"Technical details: {ex.Message}"
                    };
                }

                ShowMessage(lblHolidayMessage, null, errorMessage, "error", steps);
            }
            catch (Exception ex)
            {
                ShowMessage(lblHolidayMessage, null,
                    "An unexpected error occurred.",
                    "error",
                    new string[] {
                        "Refresh the page and try again",
                        $"Technical details: {ex.Message}"
                    });
            }
        }

        // 4. Remove Unattended Day Off for Employee
        protected void btnRemoveDayOff_Click(object sender, EventArgs e)
        {
            // Validation
            if (string.IsNullOrWhiteSpace(txtDayOffEmployeeID.Text))
            {
                ShowMessage(lblDayOffMessage, null,
                    "Employee ID is required.",
                    "error",
                    new string[] {
                        "Enter a valid Employee ID in the text field",
                        "Employee ID must be a positive number",
                        "You can find Employee IDs in the Employee table"
                    });
                return;
            }

            int employeeID;
            if (!int.TryParse(txtDayOffEmployeeID.Text.Trim(), out employeeID) || employeeID <= 0)
            {
                ShowMessage(lblDayOffMessage, null,
                    "Invalid Employee ID format.",
                    "error",
                    new string[] {
                        "Employee ID must be a positive whole number",
                        "Do not include letters or special characters",
                        "Example: 1, 25, 100"
                    });
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    // First check if employee exists
                    using (SqlCommand checkCmd = new SqlCommand(
                        "SELECT first_name, last_name, official_day_off FROM Employee WHERE employee_id = @id", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@id", employeeID);
                        using (SqlDataReader reader = checkCmd.ExecuteReader())
                        {
                            if (!reader.HasRows)
                            {
                                ShowMessage(lblDayOffMessage, null,
                                    $"Employee with ID {employeeID} does not exist.",
                                    "error",
                                    new string[] {
                                        "Verify the Employee ID is correct",
                                        "Check the Employee table for valid IDs",
                                        "The employee may have been deleted from the system"
                                    });
                                return;
                            }
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("Remove_DayOff", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@employee_ID", employeeID);
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage(lblDayOffMessage, null,
                    $"Successfully removed unattended day off records for Employee ID: {employeeID}.",
                    "success",
                    new string[] {
                        "Absent records on the employee's official day off for the current month have been removed",
                        "The employee's attendance record has been cleaned up"
                    });
                txtDayOffEmployeeID.Text = "";
            }
            catch (SqlException ex)
            {
                ShowMessage(lblDayOffMessage, null,
                    "Database error while removing day off records.",
                    "error",
                    new string[] {
                        "Verify the Employee ID exists in the database",
                        "Check if the employee has an official_day_off set",
                        "Ensure the 'Remove_DayOff' procedure exists and is accessible",
                        $"Technical details: {ex.Message}"
                    });
            }
            catch (Exception ex)
            {
                ShowMessage(lblDayOffMessage, null,
                    "An unexpected error occurred.",
                    "error",
                    new string[] {
                        "Refresh the page and try again",
                        $"Technical details: {ex.Message}"
                    });
            }
        }

        // 5. Remove Approved Leave Attendance Records
        protected void btnRemoveApprovedLeaves_Click(object sender, EventArgs e)
        {
            // Validation
            if (string.IsNullOrWhiteSpace(txtLeaveEmployeeID.Text))
            {
                ShowMessage(lblLeaveMessage, null,
                    "Employee ID is required.",
                    "error",
                    new string[] {
                        "Enter a valid Employee ID in the text field",
                        "Employee ID must be a positive number"
                    });
                return;
            }

            int employeeID;
            if (!int.TryParse(txtLeaveEmployeeID.Text.Trim(), out employeeID) || employeeID <= 0)
            {
                ShowMessage(lblLeaveMessage, null,
                    "Invalid Employee ID format.",
                    "error",
                    new string[] {
                        "Employee ID must be a positive whole number",
                        "Do not include letters or special characters"
                    });
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    // Check if employee exists
                    using (SqlCommand checkCmd = new SqlCommand(
                        "SELECT 1 FROM Employee WHERE employee_id = @id", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@id", employeeID);
                        object result = checkCmd.ExecuteScalar();
                        if (result == null)
                        {
                            ShowMessage(lblLeaveMessage, null,
                                $"Employee with ID {employeeID} does not exist.",
                                "error",
                                new string[] {
                                    "Verify the Employee ID is correct",
                                    "Check the Employee table for valid IDs"
                                });
                            return;
                        }
                    }

                    using (SqlCommand cmd = new SqlCommand("Remove_Approved_Leaves", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@employee_id", employeeID);
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage(lblLeaveMessage, null,
                    $"Successfully removed approved leave attendance records for Employee ID: {employeeID}.",
                    "success",
                    new string[] {
                        "Attendance records during approved leave periods have been removed",
                        "This includes Annual, Accidental, Medical, Unpaid, and Compensation leaves"
                    });
                txtLeaveEmployeeID.Text = "";
            }
            catch (SqlException ex)
            {
                ShowMessage(lblLeaveMessage, null,
                    "Database error while removing approved leave records.",
                    "error",
                    new string[] {
                        "Verify the Employee ID exists in the database",
                        "Check if the employee has any approved leaves",
                        "Ensure the 'Remove_Approved_Leaves' procedure exists",
                        $"Technical details: {ex.Message}"
                    });
            }
            catch (Exception ex)
            {
                ShowMessage(lblLeaveMessage, null,
                    "An unexpected error occurred.",
                    "error",
                    new string[] {
                        "Refresh the page and try again",
                        $"Technical details: {ex.Message}"
                    });
            }
        }

        // 6. Replace Employee
        protected void btnReplaceEmployee_Click(object sender, EventArgs e)
        {
            // Validate all fields
            bool hasErrors = false;
            string errorDetails = "";

            if (string.IsNullOrWhiteSpace(txtEmp1ID.Text))
            {
                hasErrors = true;
                errorDetails += "Employee 1 ID (being replaced) is required. ";
            }

            if (string.IsNullOrWhiteSpace(txtEmp2ID.Text))
            {
                hasErrors = true;
                errorDetails += "Employee 2 ID (replacement) is required. ";
            }

            if (string.IsNullOrWhiteSpace(txtReplaceFromDate.Text))
            {
                hasErrors = true;
                errorDetails += "From Date is required. ";
            }

            if (string.IsNullOrWhiteSpace(txtReplaceToDate.Text))
            {
                hasErrors = true;
                errorDetails += "To Date is required. ";
            }

            if (hasErrors)
            {
                ShowMessage(lblReplaceMessage, null,
                    "Missing required fields.",
                    "error",
                    new string[] {
                        errorDetails,
                        "Fill in all fields before submitting",
                        "Emp1 = Employee being replaced, Emp2 = Replacement employee"
                    });
                return;
            }

            int emp1ID, emp2ID;
            DateTime fromDate, toDate;

            // Validate Employee 1 ID
            if (!int.TryParse(txtEmp1ID.Text.Trim(), out emp1ID) || emp1ID <= 0)
            {
                ShowMessage(lblReplaceMessage, null,
                    "Invalid Employee 1 ID.",
                    "error",
                    new string[] {
                        "Employee ID must be a positive whole number",
                        "Enter the ID of the employee who needs to be replaced"
                    });
                return;
            }

            // Validate Employee 2 ID
            if (!int.TryParse(txtEmp2ID.Text.Trim(), out emp2ID) || emp2ID <= 0)
            {
                ShowMessage(lblReplaceMessage, null,
                    "Invalid Employee 2 ID.",
                    "error",
                    new string[] {
                        "Employee ID must be a positive whole number",
                        "Enter the ID of the replacement employee"
                    });
                return;
            }

            // Check if same employee
            if (emp1ID == emp2ID)
            {
                ShowMessage(lblReplaceMessage, null,
                    "An employee cannot replace themselves.",
                    "error",
                    new string[] {
                        "Employee 1 and Employee 2 must be different people",
                        "Select a different replacement employee"
                    });
                return;
            }

            // Validate dates
            if (!DateTime.TryParse(txtReplaceFromDate.Text, out fromDate))
            {
                ShowMessage(lblReplaceMessage, null,
                    "Invalid From Date format.",
                    "error",
                    new string[] {
                        "Select a valid date from the date picker",
                        "Date should be in the correct format"
                    });
                return;
            }

            if (!DateTime.TryParse(txtReplaceToDate.Text, out toDate))
            {
                ShowMessage(lblReplaceMessage, null,
                    "Invalid To Date format.",
                    "error",
                    new string[] {
                        "Select a valid date from the date picker",
                        "Date should be in the correct format"
                    });
                return;
            }

            if (fromDate > toDate)
            {
                ShowMessage(lblReplaceMessage, null,
                    "Invalid date range.",
                    "error",
                    new string[] {
                        "From Date must be before or equal to To Date",
                        "Check your selected dates and correct them"
                    });
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    using (SqlCommand cmd = new SqlCommand("Replace_employee", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Emp1_ID", emp1ID);
                        cmd.Parameters.AddWithValue("@Emp2_ID", emp2ID);
                        cmd.Parameters.AddWithValue("@from_date", fromDate);
                        cmd.Parameters.AddWithValue("@to_date", toDate);

                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage(lblReplaceMessage, null,
                    $"Successfully set up replacement: Employee {emp2ID} will replace Employee {emp1ID} from {fromDate:yyyy-MM-dd} to {toDate:yyyy-MM-dd}.",
                    "success",
                    new string[] {
                        "The replacement has been recorded in the system",
                        "Employee 2 will handle Employee 1's responsibilities during this period",
                        "Update the employee's status if they are going on leave"
                    });

                // Clear fields on success
                txtEmp1ID.Text = "";
                txtEmp2ID.Text = "";
                txtReplaceFromDate.Text = "";
                txtReplaceToDate.Text = "";
            }
            catch (SqlException ex)
            {
                string errorMsg = "Database error while setting up employee replacement.";
                string[] steps;

                if (ex.Message.Contains("not found") || ex.Message.Contains("does not exist"))
                {
                    steps = new string[] {
                        "One or both Employee IDs do not exist in the database",
                        "Verify both Employee IDs are valid",
                        $"Technical details: {ex.Message}"
                    };
                }
                else if (ex.Message.Contains("overlapping"))
                {
                    steps = new string[] {
                        "The replacement employee already has a replacement assignment during this period",
                        "Choose a different replacement employee",
                        "Or adjust the date range to avoid overlap",
                        $"Technical details: {ex.Message}"
                    };
                }
                else
                {
                    steps = new string[] {
                        "Check that both employees exist in the system",
                        "Verify the employees are in the same department",
                        "Ensure the replacement employee is available during the specified dates",
                        $"Technical details: {ex.Message}"
                    };
                }

                ShowMessage(lblReplaceMessage, null, errorMsg, "error", steps);
            }
            catch (Exception ex)
            {
                ShowMessage(lblReplaceMessage, null,
                    "An unexpected error occurred.",
                    "error",
                    new string[] {
                        "Refresh the page and try again",
                        $"Technical details: {ex.Message}"
                    });
            }
        }

        // 7. Update Employment Status
        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            // Validation
            if (string.IsNullOrWhiteSpace(txtStatusEmployeeID.Text))
            {
                ShowMessage(lblStatusMessage, null,
                    "Employee ID is required.",
                    "error",
                    new string[] {
                        "Enter a valid Employee ID in the text field",
                        "Employee ID must be a positive number"
                    });
                return;
            }

            int employeeID;
            if (!int.TryParse(txtStatusEmployeeID.Text.Trim(), out employeeID) || employeeID <= 0)
            {
                ShowMessage(lblStatusMessage, null,
                    "Invalid Employee ID format.",
                    "error",
                    new string[] {
                        "Employee ID must be a positive whole number",
                        "Do not include letters or special characters"
                    });
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try { conn.Open(); }
                    catch (SqlException) { Response.Redirect("DbError.aspx"); return; }

                    // Check if employee exists and get current status
                    string currentStatus = null;
                    using (SqlCommand checkCmd = new SqlCommand(
                        "SELECT employment_status FROM Employee WHERE employee_id = @id", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@id", employeeID);
                        object result = checkCmd.ExecuteScalar();
                        if (result == null)
                        {
                            ShowMessage(lblStatusMessage, null,
                                $"Employee with ID {employeeID} does not exist.",
                                "error",
                                new string[] {
                                    "Verify the Employee ID is correct",
                                    "Check the Employee table for valid IDs"
                                });
                            return;
                        }
                        currentStatus = result.ToString();
                    }

                    using (SqlCommand cmd = new SqlCommand("Update_Employment_Status", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Employee_ID", employeeID);
                        cmd.ExecuteNonQuery();
                    }

                    // Get new status
                    string newStatus = null;
                    using (SqlCommand getCmd = new SqlCommand(
                        "SELECT employment_status FROM Employee WHERE employee_id = @id", conn))
                    {
                        getCmd.Parameters.AddWithValue("@id", employeeID);
                        newStatus = getCmd.ExecuteScalar()?.ToString();
                    }

                    ShowMessage(lblStatusMessage, null,
                        $"Successfully updated employment status for Employee ID: {employeeID}.",
                        "success",
                        new string[] {
                            $"Previous status: {currentStatus}",
                            $"New status: {newStatus}",
                            "Status is determined based on current approved leaves"
                        });
                }

                txtStatusEmployeeID.Text = "";
            }
            catch (SqlException ex)
            {
                ShowMessage(lblStatusMessage, null,
                    "Database error while updating employment status.",
                    "error",
                    new string[] {
                        "Verify the Employee ID exists in the database",
                        "Ensure the 'Update_Employment_Status' procedure exists",
                        "Check that the 'Is_On_Leave' function is available",
                        $"Technical details: {ex.Message}"
                    });
            }
            catch (Exception ex)
            {
                ShowMessage(lblStatusMessage, null,
                    "An unexpected error occurred.",
                    "error",
                    new string[] {
                        "Refresh the page and try again",
                        $"Technical details: {ex.Message}"
                    });
            }
        }

        #endregion

        #region Helper Methods

        /// <summary>
        /// Displays a formatted message with optional corrective steps
        /// </summary>
        private void ShowMessage(Label label, Panel panel, string message, string type, string[] steps)
        {
            if (label != null)
            {
                string cssClass = "message ";
                switch (type.ToLower())
                {
                    case "success":
                        cssClass += "message-success";
                        break;
                    case "error":
                        cssClass += "message-error";
                        break;
                    case "info":
                        cssClass += "message-info";
                        break;
                    default:
                        cssClass += "message-info";
                        break;
                }

                string fullMessage = message;

                // Add corrective steps if provided
                if (steps != null && steps.Length > 0)
                {
                    fullMessage += "<div class='message-steps'>";
                    if (type.ToLower() == "error")
                    {
                        fullMessage += "<strong>How to fix this:</strong>";
                    }
                    else if (type.ToLower() == "info")
                    {
                        fullMessage += "<strong>What you can do:</strong>";
                    }
                    else
                    {
                        fullMessage += "<strong>Next steps:</strong>";
                    }
                    fullMessage += "<ul>";
                    foreach (string step in steps)
                    {
                        fullMessage += $"<li>{step}</li>";
                    }
                    fullMessage += "</ul></div>";
                }

                label.Text = fullMessage;
                label.CssClass = cssClass;
                label.Visible = true;

                if (panel != null)
                {
                    panel.Visible = true;
                }
            }
        }

        /// <summary>
        /// Clears all message labels on the page
        /// </summary>
        private void ClearAllMessages()
        {
            // Part 1 messages
            lblProfilesMessage.Visible = false;
            lblDeptCountMessage.Visible = false;
            lblRejectedMessage.Visible = false;
            lblDeductionsMessage.Visible = false;
            lblUpdateAttendanceMessage.Visible = false;
            lblAddHolidayMessage.Visible = false;
            lblInitiateMessage.Visible = false;

            // Part 2 messages
            lblHolidayMessage.Visible = false;
            lblDayOffMessage.Visible = false;
            lblLeaveMessage.Visible = false;
            lblReplaceMessage.Visible = false;
            lblStatusMessage.Visible = false;
            pnlGlobalMessage.Visible = false;
        }

        #endregion
    }
}
