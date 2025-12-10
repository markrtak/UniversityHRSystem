<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="UniversityHRSystem128.Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Portal - HR Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #DBDBDB;
            min-height: 100vh;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        /* Top Navigation Bar */
        .top-nav {
            background: #706F6F;
            padding: 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            animation: fadeIn 0.5s ease-out;
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .nav-brand {
            color: #FFFFFF;
            font-size: 1.4em;
            font-weight: 600;
            padding: 15px 0;
            text-decoration: none;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-menu li {
            position: relative;
        }

        .nav-menu a, .nav-menu .nav-link {
            color: #FFFFFF;
            text-decoration: none;
            padding: 18px 15px;
            display: block;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .nav-menu a:hover, .nav-menu .nav-link:hover {
            background: #8B4557;
            color: #FFFFFF;
        }

        .nav-menu .active {
            background: #8B4557;
        }

        /* Dropdown Menu */
        .dropdown-content {
            display: none;
            position: absolute;
            background: #FFFFFF;
            min-width: 220px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
            border-radius: 0 0 6px 6px;
            z-index: 1001;
        }

        .dropdown-content a {
            color: #706F6F;
            padding: 12px 16px;
            border-bottom: 1px solid #DBDBDB;
        }

        .dropdown-content a:hover {
            background: #8B4557;
            color: #FFFFFF;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .container {
            max-width: 1400px;
            margin: 20px auto;
            background: #FFFFFF;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(112, 111, 111, 0.15);
            padding: 40px;
            animation: slideUp 0.6s ease-out;
        }

        .header {
            background: #706F6F;
            color: #FFFFFF;
            padding: 25px 30px;
            margin: -40px -40px 30px -40px;
            border-radius: 12px 12px 0 0;
        }

        .header h1 {
            color: #FFFFFF;
            text-align: center;
            font-size: 2.2em;
            font-weight: 600;
            margin: 0;
        }

        /* Quick Navigation within page */
        .quick-nav {
            background: #f9f9f9;
            border: 1px solid #DBDBDB;
            border-radius: 8px;
            padding: 15px 20px;
            margin-bottom: 25px;
            animation: slideIn 0.5s ease-out 0.2s both;
        }

        .quick-nav-title {
            color: #706F6F;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .quick-nav-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .quick-nav-links a {
            background: #FFFFFF;
            color: #706F6F;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            border: 1px solid #706F6F;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .quick-nav-links a:hover {
            background: #8B4557;
            color: #FFFFFF;
            border-color: #8B4557;
            transform: translateY(-2px);
        }

        /* Section Category Headers */
        .section-category {
            background: linear-gradient(135deg, #8B4557 0%, #706F6F 100%);
            color: #FFFFFF;
            padding: 15px 20px;
            margin: 30px 0 20px 0;
            border-radius: 8px;
            font-size: 1.2em;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            animation: slideIn 0.5s ease-out both;
        }

        .section-category:first-of-type {
            margin-top: 0;
        }

        .section {
            background: #FFFFFF;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid #706F6F;
            transition: all 0.3s ease;
            animation: slideUp 0.5s ease-out both;
        }

        .section:hover {
            box-shadow: 0 6px 20px rgba(112, 111, 111, 0.15);
            transform: translateY(-2px);
        }

        .section h2 {
            color: #706F6F;
            margin-bottom: 20px;
            font-size: 1.4em;
            border-bottom: 3px solid #8B4557;
            padding-bottom: 10px;
            font-weight: 600;
        }

        .input-group {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .input-group label {
            font-weight: 600;
            color: #706F6F;
            min-width: 180px;
        }

        .input-group input[type="text"],
        .input-group input[type="date"] {
            flex: 1;
            padding: 12px;
            border: 2px solid #706F6F;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s, box-shadow 0.3s, transform 0.2s;
            color: #706F6F;
        }

        .input-group input[type="text"]:focus,
        .input-group input[type="date"]:focus {
            outline: none;
            border-color: #8B4557;
            box-shadow: 0 0 0 3px rgba(139, 69, 87, 0.2);
            transform: translateY(-2px);
        }

        .input-group input[type="text"]::placeholder {
            color: #999;
        }

        .btn {
            padding: 12px 28px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 5px;
        }

        /* Main buttons - Dusty Pink */
        .btn-primary {
            background: #8B4557;
            color: #FFFFFF;
            border: 2px solid #8B4557;
        }

        .btn-primary:hover {
            background: #706F6F;
            border-color: #706F6F;
            box-shadow: 0 4px 12px rgba(112, 111, 111, 0.3);
            transform: translateY(-2px);
        }

        .btn-success {
            background: #8B4557;
            color: #FFFFFF;
            border: 2px solid #8B4557;
        }

        .btn-success:hover {
            background: #706F6F;
            border-color: #706F6F;
            box-shadow: 0 4px 12px rgba(112, 111, 111, 0.3);
            transform: translateY(-2px);
        }

        /* Secondary buttons - Transparent with border */
        .btn-danger {
            background: transparent;
            color: #706F6F;
            border: 2px solid #706F6F;
        }

        .btn-danger:hover {
            background: #8B4557;
            border-color: #8B4557;
            color: #FFFFFF;
            box-shadow: 0 4px 12px rgba(139, 69, 87, 0.3);
            transform: translateY(-2px);
        }

        .btn-warning {
            background: transparent;
            color: #706F6F;
            border: 2px solid #706F6F;
        }

        .btn-warning:hover {
            background: #8B4557;
            border-color: #8B4557;
            color: #FFFFFF;
            box-shadow: 0 4px 12px rgba(139, 69, 87, 0.3);
            transform: translateY(-2px);
        }

        .gridview-container {
            margin-top: 20px;
            overflow-x: auto;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            background: #FFFFFF;
            border-radius: 6px;
            overflow: hidden;
            border: 1px solid #706F6F;
        }

        .gridview th {
            background: #706F6F;
            color: #FFFFFF;
            padding: 14px 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
        }

        .gridview td {
            padding: 12px 15px;
            border-bottom: 1px solid #DBDBDB;
            color: #706F6F;
        }

        .gridview tr:hover {
            background: #DBDBDB;
        }

        .gridview tr:nth-child(even) {
            background: #f9f9f9;
        }

        .gridview tr:nth-child(even):hover {
            background: #DBDBDB;
        }

        .message {
            padding: 15px 20px;
            border-radius: 6px;
            margin: 15px 0;
            font-weight: 500;
            animation: fadeIn 0.4s ease-out;
        }

        .message-success {
            background: rgba(139, 69, 87, 0.2);
            color: #706F6F;
            border: 1px solid #8B4557;
        }

        .message-success::before {
            content: "✓ SUCCESS: ";
            font-weight: 700;
        }

        .message-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .message-error::before {
            content: "✗ ERROR: ";
            font-weight: 700;
        }

        .message-info {
            background: #e7f3ff;
            color: #004085;
            border: 1px solid #b8daff;
        }

        .message-info::before {
            content: "ℹ INFO: ";
            font-weight: 700;
        }

        .message-steps {
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px dashed currentColor;
            font-weight: normal;
            font-size: 0.9em;
        }

        .message-steps strong {
            display: block;
            margin-bottom: 5px;
        }

        .message-steps ul {
            margin: 0;
            padding-left: 20px;
        }

        .message-steps li {
            margin: 3px 0;
        }

        .button-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 15px;
        }

        a {
            color: #8B4557;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #706F6F;
        }

        p {
            color: #706F6F;
        }

        /* Records count display */
        .records-count {
            background: #8B4557;
            color: #FFFFFF;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            display: inline-block;
            margin-top: 10px;
        }

        /* Staggered animation delays for sections */
        .section:nth-child(1) { animation-delay: 0.1s; }
        .section:nth-child(2) { animation-delay: 0.15s; }
        .section:nth-child(3) { animation-delay: 0.2s; }
        .section:nth-child(4) { animation-delay: 0.25s; }
        .section:nth-child(5) { animation-delay: 0.3s; }
        .section:nth-child(6) { animation-delay: 0.35s; }
        .section:nth-child(7) { animation-delay: 0.4s; }
        .section:nth-child(8) { animation-delay: 0.45s; }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
                margin: 10px;
            }

            .header {
                margin: -20px -20px 20px -20px;
                padding: 20px;
            }

            .header h1 {
                font-size: 1.6em;
            }

            .input-group {
                flex-direction: column;
                align-items: flex-start;
            }

            .input-group label {
                min-width: auto;
            }

            .input-group input[type="text"],
            .input-group input[type="date"] {
                width: 100%;
            }

            .nav-menu {
                flex-direction: column;
                display: none;
            }

            .nav-container {
                flex-direction: column;
            }

            .quick-nav-links {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Top Navigation Bar -->
        <nav class="top-nav">
            <div class="nav-container">
                <a href="Admin.aspx" class="nav-brand">University HR System</a>
                <ul class="nav-menu">
                    <li><a href="Admin.aspx" class="active">Admin Dashboard</a></li>
                    <li class="dropdown">
                        <span class="nav-link">Part 1 ▾</span>
                        <div class="dropdown-content">
                            <a href="#section-profiles">Employee Profiles</a>
                            <a href="#section-deptcount">Employees per Dept</a>
                            <a href="#section-rejected">Rejected Medical</a>
                            <a href="#section-deductions">Remove Deductions</a>
                            <a href="#section-update-attendance">Update Attendance</a>
                            <a href="#section-add-holiday">Add Holiday</a>
                            <a href="#section-initiate">Initiate Attendance</a>
                        </div>
                    </li>
                    <li class="dropdown">
                        <span class="nav-link">Part 2 ▾</span>
                        <div class="dropdown-content">
                            <a href="#section-yesterday">Yesterday's Attendance</a>
                            <a href="#section-performance">Winter Performance</a>
                            <a href="#section-holidays">Remove Holidays</a>
                            <a href="#section-dayoff">Remove Day Off</a>
                            <a href="#section-leaves">Remove Leaves</a>
                            <a href="#section-replace">Replace Employee</a>
                            <a href="#section-status">Update Status</a>
                        </div>
                    </li>
                    <li><asp:LinkButton ID="lnkLogout" runat="server" CssClass="nav-link" OnClick="lnkLogout_Click">Home</asp:LinkButton></li>
                </ul>
            </div>
        </nav>

        <div class="container">
            <div class="header">
                <h1>Admin Dashboard</h1>
            </div>

            <!-- Global Message Panel -->
            <asp:Panel ID="pnlGlobalMessage" runat="server" Visible="false">
                <asp:Label ID="lblGlobalMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- ==================== PART 1 SECTIONS ==================== -->
            <div class="section-category">Part 1 - Core Admin Functions</div>

            <!-- Section: Employee Profiles -->
            <div class="section" id="section-profiles">
                <h2>All Employee Profiles</h2>
                <asp:Button ID="btnFetchProfiles" runat="server" Text="Fetch Employee Profiles" 
                    CssClass="btn btn-primary" OnClick="btnFetchProfiles_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gvEmployeeProfiles" runat="server" CssClass="gridview" 
                        AutoGenerateColumns="true" EmptyDataText="No employee profiles found.">
                    </asp:GridView>
                </div>
                <asp:Label ID="lblProfilesMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Employees per Department -->
            <div class="section" id="section-deptcount">
                <h2>Number of Employees per Department</h2>
                <asp:Button ID="btnFetchDeptCount" runat="server" Text="Fetch Department Count" 
                    CssClass="btn btn-primary" OnClick="btnFetchDeptCount_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gvDeptCount" runat="server" CssClass="gridview" 
                        AutoGenerateColumns="true" EmptyDataText="No department data found.">
                    </asp:GridView>
                </div>
                <asp:Label ID="lblDeptCountMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Rejected Medical Leaves -->
            <div class="section" id="section-rejected">
                <h2>All Rejected Medical Leaves</h2>
                <asp:Button ID="btnFetchRejected" runat="server" Text="Fetch Rejected Medical Leaves" 
                    CssClass="btn btn-primary" OnClick="btnFetchRejected_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gvRejectedMedical" runat="server" CssClass="gridview" 
                        AutoGenerateColumns="true" EmptyDataText="No rejected medical leaves found.">
                    </asp:GridView>
                </div>
                <asp:Label ID="lblRejectedMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Remove Deductions -->
            <div class="section" id="section-deductions">
                <h2>Remove Deductions for Resigned Employees</h2>
                <p style="margin-bottom: 15px; color: #6c757d;">Remove all deductions for employees with 'resigned' employment status.</p>
                <asp:Button ID="btnRemoveDeductions" runat="server" Text="Remove Deductions" 
                    CssClass="btn btn-danger" OnClick="btnRemoveDeductions_Click" 
                    OnClientClick="return confirm('Are you sure you want to remove deductions for resigned employees?');" />
                <asp:Label ID="lblDeductionsMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Update Attendance -->
            <div class="section" id="section-update-attendance">
                <h2>Update Attendance Record</h2>
                <p style="margin-bottom: 15px; color: #6c757d;">Update the attendance record for the current day for a specific employee.</p>
                <div class="input-group">
                    <label>Employee ID:</label>
                    <asp:TextBox ID="txtUpdateEmpID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>Check-In Time (HH:MM):</label>
                    <asp:TextBox ID="txtCheckIn" runat="server" placeholder="e.g., 09:00"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>Check-Out Time (HH:MM):</label>
                    <asp:TextBox ID="txtCheckOut" runat="server" placeholder="e.g., 17:00"></asp:TextBox>
                </div>
                <asp:Button ID="btnUpdateAttendance" runat="server" Text="Update Attendance" 
                    CssClass="btn btn-success" OnClick="btnUpdateAttendance_Click" />
                <asp:Label ID="lblUpdateAttendanceMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Add Holiday -->
            <div class="section" id="section-add-holiday">
                <h2>Add New Official Holiday</h2>
                <div class="input-group">
                    <label>Holiday Name:</label>
                    <asp:TextBox ID="txtHolidayName" runat="server" placeholder="Enter Holiday Name"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>From Date:</label>
                    <asp:TextBox ID="txtHolidayFromDate" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>To Date:</label>
                    <asp:TextBox ID="txtHolidayToDate" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <asp:Button ID="btnAddHoliday" runat="server" Text="Add Holiday" 
                    CssClass="btn btn-success" OnClick="btnAddHoliday_Click" />
                <asp:Label ID="lblAddHolidayMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Initiate Attendance -->
            <div class="section" id="section-initiate">
                <h2>Initiate Attendance Records</h2>
                <p style="margin-bottom: 15px; color: #6c757d;">Initialize attendance records for the current day for all employees.</p>
                <asp:Button ID="btnInitiateAttendance" runat="server" Text="Initiate Attendance for Today" 
                    CssClass="btn btn-primary" OnClick="btnInitiateAttendance_Click" />
                <asp:Label ID="lblInitiateMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- ==================== PART 2 SECTIONS ==================== -->
            <div class="section-category">Part 2 - Advanced Admin Functions</div>

            <!-- Section: Yesterday's Attendance -->
            <div class="section" id="section-yesterday">
                <h2>Yesterday's Attendance Records</h2>
                <asp:Button ID="btnFetchYesterdayAttendance" runat="server" Text="Fetch Yesterday's Attendance" 
                    CssClass="btn btn-primary" OnClick="btnFetchYesterdayAttendance_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gvYesterdayAttendance" runat="server" CssClass="gridview" 
                        AutoGenerateColumns="true" EmptyDataText="No attendance records found for yesterday.">
                    </asp:GridView>
                </div>
            </div>

            <!-- Section: Winter Performance -->
            <div class="section" id="section-performance">
                <h2>Winter Semester Performance</h2>
                <asp:Button ID="btnFetchWinterPerformance" runat="server" Text="Fetch Winter Performance" 
                    CssClass="btn btn-primary" OnClick="btnFetchWinterPerformance_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gvWinterPerformance" runat="server" CssClass="gridview" 
                        AutoGenerateColumns="true" EmptyDataText="No performance records found for Winter semesters.">
                    </asp:GridView>
                </div>
            </div>

            <!-- Section: Remove Holiday Attendance -->
            <div class="section" id="section-holidays">
                <h2>Remove Holiday Attendance Records</h2>
                <p style="margin-bottom: 15px; color: #6c757d;">Remove all attendance records that fall within official holidays.</p>
                <asp:Button ID="btnRemoveHolidays" runat="server" Text="Remove Holiday Attendance" 
                    CssClass="btn btn-danger" OnClick="btnRemoveHolidays_Click" 
                    OnClientClick="return confirm('Are you sure you want to remove all attendance records during holidays?');" />
                <asp:Label ID="lblHolidayMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Remove Day Off -->
            <div class="section" id="section-dayoff">
                <h2>Remove Unattended Day Off</h2>
                <div class="input-group">
                    <label>Employee ID:</label>
                    <asp:TextBox ID="txtDayOffEmployeeID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                </div>
                <asp:Button ID="btnRemoveDayOff" runat="server" Text="Remove Day Off Records" 
                    CssClass="btn btn-warning" OnClick="btnRemoveDayOff_Click" />
                <asp:Label ID="lblDayOffMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Remove Approved Leaves -->
            <div class="section" id="section-leaves">
                <h2>Remove Approved Leave Attendance</h2>
                <div class="input-group">
                    <label>Employee ID:</label>
                    <asp:TextBox ID="txtLeaveEmployeeID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                </div>
                <asp:Button ID="btnRemoveApprovedLeaves" runat="server" Text="Remove Approved Leave Records" 
                    CssClass="btn btn-warning" OnClick="btnRemoveApprovedLeaves_Click" />
                <asp:Label ID="lblLeaveMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Replace Employee -->
            <div class="section" id="section-replace">
                <h2>Replace Employee</h2>
                <div class="input-group">
                    <label>Employee Being Replaced (Emp1):</label>
                    <asp:TextBox ID="txtEmp1ID" runat="server" placeholder="Enter Employee 1 ID"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>Replacement Employee (Emp2):</label>
                    <asp:TextBox ID="txtEmp2ID" runat="server" placeholder="Enter Employee 2 ID"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>From Date:</label>
                    <asp:TextBox ID="txtReplaceFromDate" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>To Date:</label>
                    <asp:TextBox ID="txtReplaceToDate" runat="server" TextMode="Date"></asp:TextBox>
                </div>
                <asp:Button ID="btnReplaceEmployee" runat="server" Text="Replace Employee" 
                    CssClass="btn btn-success" OnClick="btnReplaceEmployee_Click" />
                <asp:Label ID="lblReplaceMessage" runat="server" CssClass="message"></asp:Label>
            </div>

            <!-- Section: Update Employment Status -->
            <div class="section" id="section-status">
                <h2>Update Employment Status</h2>
                <p style="margin-bottom: 15px;">Update an employee's status to 'active' or 'onleave' based on their current leave status.</p>
                <div class="input-group">
                    <label>Employee ID:</label>
                    <asp:TextBox ID="txtStatusEmployeeID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                </div>
                <asp:Button ID="btnUpdateStatus" runat="server" Text="Update Employment Status" 
                    CssClass="btn btn-success" OnClick="btnUpdateStatus_Click" />
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="message"></asp:Label>
            </div>

        </div>
    </form>

    <!-- Smooth scrolling script -->
    <script type="text/javascript">
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>

