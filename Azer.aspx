<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Azer.aspx.cs" Inherits="UniversityHRSystem128.Azer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>University HR System</title>
    <style>
        :root {
            --bg-main: #DBDBDB;
            --dark-grey: #706F6F;
            --burgundy: #8B4557;
            --white: #FFFFFF;
            --burgundy-tint: rgba(139, 69, 87, 0.2);
            --burgundy-light: rgba(139, 69, 87, 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--bg-main);
            min-height: 100vh;
            color: var(--dark-grey);
        }

        .container { max-width: 1400px; margin: 0 auto; padding: 2rem; }

        .header { text-align: center; margin-bottom: 3rem; position: relative; }
        .header::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--burgundy), transparent);
            z-index: 0;
        }
        .header h1 {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--dark-grey);
            background: var(--bg-main);
            display: inline-block;
            padding: 0 2rem;
            position: relative;
            z-index: 1;
            letter-spacing: 1px;
        }
        .header h1 span { color: var(--burgundy); }

        .form-group { display: flex; flex-direction: column; gap: 0.5rem; }
        .form-group label {
            font-weight: 600;
            color: var(--dark-grey);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .form-group input, .form-group select {
            padding: 0.75rem 1rem;
            border: 1px solid var(--dark-grey);
            border-radius: 8px;
            background: var(--white);
            color: var(--dark-grey);
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--burgundy);
            box-shadow: 0 0 0 3px var(--burgundy-tint);
        }
        .form-group textarea {
            padding: 0.75rem 1rem;
            border: 1px solid var(--dark-grey);
            border-radius: 8px;
            background: var(--white);
            color: var(--dark-grey);
            font-size: 1rem;
            resize: vertical;
            min-height: 80px;
            font-family: inherit;
        }
        .form-group textarea:focus {
            outline: none;
            border-color: var(--burgundy);
            box-shadow: 0 0 0 3px var(--burgundy-tint);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-primary { 
            background: var(--burgundy); 
            color: var(--white); 
            border: none;
        }
        .btn-primary:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 12px rgba(139, 69, 87, 0.4);
            background: #7a3d4c;
        }
        .btn-success { 
            background: var(--burgundy); 
            color: var(--white); 
            border: none;
        }
        .btn-success:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 4px 12px rgba(139, 69, 87, 0.4);
        }
        .btn-danger { 
            background: transparent; 
            color: var(--dark-grey); 
            border: 2px solid var(--dark-grey);
        }
        .btn-danger:hover { 
            transform: translateY(-2px); 
            background: var(--dark-grey);
            color: var(--white);
        }

        .tabs {
            display: none;
        }
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 260px;
            height: 100vh;
            background: var(--burgundy);
            border-right: 2.5px solid var(--dark-grey);
            z-index:2002;
            transform: translateX(-105%);
            transition: transform .32s cubic-bezier(.48,1.68,.56,.84), box-shadow .2s;
            padding: 0 0.8rem 2rem 0.8rem;
            box-shadow: 0 4px 32px 2px rgba(139,69,87,0.13);
            display: flex;
            flex-direction: column;
        }
        .sidebar.open {
            transform: none;
            box-shadow: 6px 1px 36px 2px rgba(112,111,111,0.17);
        }
        .sidebar-header {
            display: flex;
            align-items: center;
            padding: 1.1rem 0 1.2rem 0.3rem;
            border-bottom: 1px solid var(--bg-main);
            background: var(--burgundy);
        }
        .sidebar-header h2 {
            font-size: 1.13rem;
            color: var(--white);
            font-weight: 760;
            letter-spacing: 0.03em;
            margin: 0;
            flex-shrink:0;
        }
        #sidebarClose {
            margin-left:auto;
            font-size: 1.9rem;
            padding: 0 0.86em 0 0.86em;
            background: none;
            border: none;
            color: var(--white);
            line-height: 1.2;
        }
        #sidebarClose:hover, #sidebarClose:focus {
            background: var(--burgundy-tint);
            color: var(--burgundy);
            outline: none;
        }
        .sidebar-tabs {
            display: flex;
            flex-direction: column;
            gap: 0.73rem;
            padding: 1.7rem 0 0.4rem 0.1rem;
        }
        .sidebar .tab-btn {
            text-align: left;
            width: 99%;
            min-height: 40px;
            font-size: 1rem;
            border-radius: 1.5em;
            background: var(--bg-main);
            border: 1.7px solid var(--bg-main);
            color: var(--dark-grey);
            font-weight: 600;
            letter-spacing: 0.03em;
            padding: 0.68em 1.13em 0.68em 1em;
            margin-bottom: 0.32em;
            transition: background 0.19s, color 0.22s, border .19s, transform .17s, box-shadow .15s;
            box-shadow: 0 2px 10px 1px rgba(139,69,87,0.11);
            display: block;
        }
        .sidebar .tab-btn:hover, .sidebar .tab-btn:focus, .sidebar .tab-btn.active {
            background: var(--white);
            color: var(--burgundy);
            border: 2px solid var(--burgundy);
            outline: none;
            transform: translateX(2px) scale(1.05);
            box-shadow: 0 4px 16px 2px rgba(139,69,87,0.17);
        }
        .sidebar .tab-btn:active {
            background: var(--burgundy-tint);
            color: var(--burgundy);
        }
        @media (max-width: 600px) {
            .sidebar { width: 82vw; }
        }
        
        /* Sidebar toggle floating button */
        #sidebarToggle {
            position: fixed;
            left: 18px;
            top: 35px;
            z-index: 2100;
            background: var(--burgundy);
            color: #fff;
            border-radius: 50%;
            padding: 0.5em 0.7em 0.5em 0.7em;
            box-shadow: 0 3px 18px 0 rgba(139, 69, 87, 0.19);
            border: none;
            font-size: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background .18s, transform .16s;
        }
        #sidebarToggle:hover, #sidebarToggle:focus {
            background: #a75c70;
            outline: none;
            transform: scale(1.07);
        }
        body.sidebar-open #sidebarToggle {
            display: none !important;
        }
        /* Overlay for sidebar open */
        .sidebar-overlay {
            position: fixed;
            inset: 0;
            background: rgba(139,69,87,0.1);
            z-index:2000;
            display: none;
            transition: background .23s;
        }
        .sidebar.open ~ .sidebar-overlay {
            display: block;
        }

        .panel {
            display: none;
            background: var(--white);
            border-radius: 12px;
            padding: 2rem;
            border: 1px solid var(--dark-grey);
            box-shadow: 0 4px 24px rgba(112, 111, 111, 0.15);
            animation: fadeIn 0.3s ease;
        }
        .panel.active { display: block; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

        .panel h3 {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--burgundy);
            margin-bottom: 1.5rem;
            font-size: 1.4rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--dark-grey);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .message {
            padding: 1rem 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
            margin-bottom: 1.5rem;
            font-weight: 600;
            clear: both;
            display: block;
        }
        .message-success { 
            background: rgba(40, 167, 69, 0.15); 
            border: 1px solid #28a745; 
            color: #28a745; 
        }
        .message-error { 
            background: rgba(220, 53, 69, 0.15); 
            border: 1px solid #dc3545; 
            color: #dc3545; 
        }

        .gridview-container {
            overflow-x: auto;
            margin-top: 1.5rem;
            border-radius: 8px;
            border: 1px solid var(--dark-grey);
        }
        .grid-view { width: 100%; border-collapse: collapse; font-size: 0.95rem; }
        .grid-view th {
            background: var(--dark-grey);
            color: var(--white);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.8rem;
        }
        .grid-view td {
            padding: 0.875rem 1rem;
            border-bottom: 1px solid var(--dark-grey);
            background: var(--white);
            color: var(--dark-grey);
        }
        .grid-view tr:hover td { background: var(--burgundy-light); }
        .grid-view .btn { padding: 0.5rem 1rem; font-size: 0.8rem; margin: 0 0.25rem; }

        .checkbox-group { display: flex; align-items: center; gap: 0.5rem; }
        .checkbox-group input[type="checkbox"] { width: 18px; height: 18px; accent-color: var(--burgundy); }

        .status-badge { padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; }
        .status-pending { background: rgba(255, 193, 7, 0.2); color: #cc9a00; }
        .status-approved { background: rgba(40, 167, 69, 0.2); color: #28a745; }
        .status-rejected { background: rgba(220, 53, 69, 0.2); color: #dc3545; }

        .section-divider { height: 1px; background: linear-gradient(90deg, transparent, var(--dark-grey), transparent); margin: 2rem 0; }

        .info-box {
            background: var(--burgundy-light);
            border: 1px solid var(--burgundy);
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: var(--dark-grey);
        }
        .info-box strong { color: var(--burgundy); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h1>University <span>HR</span> System</h1>
            </div>
            
            <!-- Sidebar toggle button -->
            <button id="sidebarToggle" type="button" class="btn btn-primary">&#9776;</button>
            <!-- Sidebar -->
            <div id="sidebar" class="sidebar">
                <div class="sidebar-header">
                    <h2>Navigation</h2>
                    <button id="sidebarClose" type="button" class="btn btn-danger">×</button>
                </div>
                <div class="sidebar-tabs">
                    <asp:Button ID="btnTabEmpPerformance" runat="server" Text="Performance" CssClass="tab-btn" OnClick="btnTabEmpPerformance_Click" />
                    <asp:Button ID="btnTabEmpAttendance" runat="server" Text="Attendance" CssClass="tab-btn" OnClick="btnTabEmpAttendance_Click" />
                    <asp:Button ID="btnTabEmpPayroll" runat="server" Text="Payroll" CssClass="tab-btn" OnClick="btnTabEmpPayroll_Click" />
                    <asp:Button ID="btnTabEmpDeductions" runat="server" Text="Deductions" CssClass="tab-btn" OnClick="btnTabEmpDeductions_Click" />
                    <asp:Button ID="btnTabEmpAnnualLeave" runat="server" Text="Annual Leave" CssClass="tab-btn" OnClick="btnTabEmpAnnualLeave_Click" />
                    <asp:Button ID="btnTabEmpLeaveStatus" runat="server" Text="Leave Status" CssClass="tab-btn" OnClick="btnTabEmpLeaveStatus_Click" />
                    <asp:Button ID="btnTabAccidental" runat="server" Text="Accidental Leave" CssClass="tab-btn" OnClick="btnTabAccidental_Click" />
                    <asp:Button ID="btnTabMedical" runat="server" Text="Medical Leave" CssClass="tab-btn" OnClick="btnTabMedical_Click" />
                    <asp:Button ID="btnTabUnpaid" runat="server" Text="Unpaid Leave" CssClass="tab-btn" OnClick="btnTabUnpaid_Click" />
                    <asp:Button ID="btnTabCompensation" runat="server" Text="Compensation Leave" CssClass="tab-btn" OnClick="btnTabCompensation_Click" />
                    <asp:Button ID="btnTabApproveUnpaid" runat="server" Text="Approve Unpaid" CssClass="tab-btn" OnClick="btnTabApproveUnpaid_Click" />
                    <asp:Button ID="btnTabApproveAnnual" runat="server" Text="Approve Annual" CssClass="tab-btn" OnClick="btnTabApproveAnnual_Click" />
                    <asp:Button ID="btnTabEvaluate" runat="server" Text="Evaluate Employees" CssClass="tab-btn" OnClick="btnTabEvaluate_Click" />
                </div>
            </div>
            <div class="sidebar-overlay"></div>

            <!-- Employee11.aspx Panels (Actual Content, Azer style) -->
            <asp:Panel ID="pnlEmpPerformance" runat="server" CssClass="panel">
                <h3>Performance</h3>
                <asp:Label ID="lblPerformanceMessage" runat="server" CssClass="message message-error" EnableViewState="false" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtPerfEmpId">Employee ID:</label>
                        <asp:TextBox ID="txtPerfEmpId" runat="server" />
                    </div>
                    <div class="form-group">
                        <label for="txtSemester">Semester:</label>
                        <asp:TextBox ID="txtSemester" runat="server" />
                    </div>
                </div>
                <asp:Button ID="btnGetPerformance" runat="server" Text="Retrieve Performance" CssClass="btn btn-primary" OnClick="btnGetPerformance_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gridPerformance" runat="server" AutoGenerateColumns="true" Visible="false" CssClass="grid-view"></asp:GridView>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpAttendance" runat="server" CssClass="panel">
                <h3>Attendance</h3>
                <asp:Label ID="lblAttendanceMessage" runat="server" CssClass="message message-error" EnableViewState="false" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtAttendEmpId">Employee ID:</label>
                        <asp:TextBox ID="txtAttendEmpId" runat="server" />
                    </div>
                </div>
                <asp:Button ID="btnGetAttendance" runat="server" Text="Retrieve Attendance" CssClass="btn btn-primary" OnClick="btnGetAttendance_Click" CausesValidation="false" />
                <div class="gridview-container">
                    <asp:GridView ID="gridAttendance" runat="server" AutoGenerateColumns="true" Visible="false" CssClass="grid-view" EmptyDataText="No attendance records found."></asp:GridView>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpPayroll" runat="server" CssClass="panel">
                <h3>Payroll</h3>
                <asp:Label ID="lblPayrollMessage" runat="server" CssClass="message message-error" EnableViewState="false" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtPayrollEmpId">Employee ID:</label>
                        <asp:TextBox ID="txtPayrollEmpId" runat="server" />
                    </div>
                </div>
                <asp:Button ID="btnGetPayroll" runat="server" Text="Retrieve Payroll" CssClass="btn btn-primary" OnClick="btnGetPayroll_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gridPayroll" runat="server" AutoGenerateColumns="true" Visible="false" CssClass="grid-view" EmptyDataText="No payroll records found."></asp:GridView>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpDeductions" runat="server" CssClass="panel">
                <h3>Deductions</h3>
                <asp:Label ID="lblDeductionsMessage" runat="server" CssClass="message message-error" EnableViewState="false" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtDeductionEmpId">Employee ID:</label>
                        <asp:TextBox ID="txtDeductionEmpId" runat="server" />
                    </div>
                    <div class="form-group">
                        <label for="txtDeductionMonth">Month (1-12):</label>
                        <asp:TextBox ID="txtDeductionMonth" runat="server" />
                    </div>
                </div>
                <asp:Button ID="btnGetDeductions" runat="server" Text="Fetch Deductions" CssClass="btn btn-primary" OnClick="btnGetDeductions_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gridDeductions" runat="server" AutoGenerateColumns="true" Visible="false" CssClass="grid-view" EmptyDataText="No deduction records found."></asp:GridView>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpAnnualLeave" runat="server" CssClass="panel">
                <h3>Annual Leave</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtApplyEmpId">Employee ID:</label>
                        <asp:TextBox ID="txtApplyEmpId" runat="server" />
                    </div>
                    <div class="form-group">
                        <label for="txtReplacementEmp">Replacement Employee ID:</label>
                        <asp:TextBox ID="txtReplacementEmp" runat="server" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtLeaveStart">Start Date:</label>
                        <asp:TextBox ID="txtLeaveStart" runat="server" TextMode="Date" />
                    </div>
                    <div class="form-group">
                        <label for="txtLeaveEnd">End Date:</label>
                        <asp:TextBox ID="txtLeaveEnd" runat="server" TextMode="Date" />
                    </div>
                </div>
                <asp:Label ID="lblLeaveMessage" runat="server" CssClass="message" Style="margin-left:40px;min-width:220px;display:inline-block;vertical-align:middle;" />
                <asp:Button ID="btnApplyLeave" runat="server" Text="Apply" CssClass="btn btn-primary" OnClick="btnApplyLeave_Click" />
            </asp:Panel>

            <asp:Panel ID="pnlEmpLeaveStatus" runat="server" CssClass="panel">
                <h3>Leave Status</h3>
                <asp:Label ID="lblLeaveStatusMessage" runat="server" CssClass="message message-error" EnableViewState="false" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtStatusEmpId">Employee ID:</label>
                        <asp:TextBox ID="txtStatusEmpId" runat="server" />
                    </div>
                </div>
                <asp:Button ID="btnGetLeavesStatus" runat="server" Text="Get Status" CssClass="btn btn-primary" OnClick="btnGetLeavesStatus_Click" />
                <div class="gridview-container">
                    <asp:GridView ID="gridLeavesStatus" runat="server" AutoGenerateColumns="true" Visible="false" CssClass="grid-view" EmptyDataText="No leave status records found."></asp:GridView>
                </div>
            </asp:Panel>

            <!-- Existing Azer.aspx Panels below... -->
            <!-- Panel 1: Accidental Leave -->
            <asp:Panel ID="pnlAccidental" runat="server" CssClass="panel active">
                <h3>1. Apply for Accidental Leave</h3>
                <asp:Label ID="lblAccidentalMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label>Employee ID</label>
                        <asp:TextBox ID="txtAccEmpID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Start Date</label>
                        <asp:TextBox ID="txtAccStartDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>End Date</label>
                        <asp:TextBox ID="txtAccEndDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnSubmitAccidental" runat="server" Text="Submit Accidental Leave" CssClass="btn btn-primary" OnClick="btnSubmitAccidental_Click" />
            </asp:Panel>

            <!-- Panel 2: Medical Leave -->
            <asp:Panel ID="pnlMedical" runat="server" CssClass="panel">
                <h3>2. Apply for Medical Leave</h3>
                <asp:Label ID="lblMedicalMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label>Employee ID</label>
                        <asp:TextBox ID="txtMedEmpID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Start Date</label>
                        <asp:TextBox ID="txtMedStartDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>End Date</label>
                        <asp:TextBox ID="txtMedEndDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Medical Type</label>
                        <asp:DropDownList ID="ddlMedicalType" runat="server">
                            <asp:ListItem Value="sick">Sick Leave</asp:ListItem>
                            <asp:ListItem Value="maternity">Maternity Leave</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Insurance Status</label>
                        <div class="checkbox-group">
                            <asp:CheckBox ID="chkInsurance" runat="server" />
                            <span>I have active insurance</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Disability Details</label>
                        <asp:TextBox ID="txtDisabilityDetails" runat="server" placeholder="Enter disability details if applicable"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Document Description</label>
                        <asp:TextBox ID="txtMedDocDescription" runat="server" placeholder="Describe the medical document"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>File Name</label>
                        <asp:TextBox ID="txtMedFileName" runat="server" placeholder="e.g., medical_certificate.pdf"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnSubmitMedical" runat="server" Text="Submit Medical Leave" CssClass="btn btn-primary" OnClick="btnSubmitMedical_Click" />
            </asp:Panel>

            <!-- Panel 3: Unpaid Leave -->
            <asp:Panel ID="pnlUnpaid" runat="server" CssClass="panel">
                <h3>3. Apply for Unpaid Leave</h3>
                <asp:Label ID="lblUnpaidMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label>Employee ID</label>
                        <asp:TextBox ID="txtUnpaidEmpID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Start Date</label>
                        <asp:TextBox ID="txtUnpaidStartDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>End Date</label>
                        <asp:TextBox ID="txtUnpaidEndDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Document Description</label>
                        <asp:TextBox ID="txtUnpaidDocDescription" runat="server" placeholder="Describe the memo document"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>File Name</label>
                        <asp:TextBox ID="txtUnpaidFileName" runat="server" placeholder="e.g., unpaid_leave_memo.pdf"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnSubmitUnpaid" runat="server" Text="Submit Unpaid Leave" CssClass="btn btn-primary" OnClick="btnSubmitUnpaid_Click" />
            </asp:Panel>

            <!-- Panel 4: Compensation Leave -->
            <asp:Panel ID="pnlCompensation" runat="server" CssClass="panel">
                <h3>4. Apply for Compensation Leave</h3>
                <asp:Label ID="lblCompensationMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label>Employee ID</label>
                        <asp:TextBox ID="txtCompEmpID" runat="server" placeholder="Enter Employee ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Compensation Date (Day Off)</label>
                        <asp:TextBox ID="txtCompDate" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Original Workday Date</label>
                        <asp:TextBox ID="txtOriginalWorkday" runat="server" TextMode="Date"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Reason</label>
                        <asp:TextBox ID="txtCompReason" runat="server" TextMode="MultiLine" Rows="3" placeholder="Enter reason for compensation leave"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label>Replacement Employee ID</label>
                        <asp:TextBox ID="txtCompReplacementID" runat="server" placeholder="Enter replacement employee ID"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnSubmitCompensation" runat="server" Text="Submit Compensation Leave" CssClass="btn btn-primary" OnClick="btnSubmitCompensation_Click" />
            </asp:Panel>

            <!-- Panel 5: Approve/Reject Unpaid Leaves -->
            <asp:Panel ID="pnlApproveUnpaid" runat="server" CssClass="panel">
                <h3>5. Approve/Reject Unpaid Leave Requests (Dean/Vice-Dean/President)</h3>
                <asp:Label ID="lblApproveUnpaidMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label>Approver ID (Dean/Vice-Dean/President)</label>
                        <asp:TextBox ID="txtApproverUnpaidID" runat="server" placeholder="Enter your Employee ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnLoadUnpaidLeaves" runat="server" Text="Load Pending Requests" CssClass="btn btn-primary" OnClick="btnLoadUnpaidLeaves_Click" />
                    </div>
                </div>
                <div class="gridview-container">
                    <asp:GridView ID="gvUnpaidLeaves" runat="server" AutoGenerateColumns="False" 
                        CssClass="grid-view" EmptyDataText="No pending unpaid leave requests."
                        OnRowCommand="gvUnpaidLeaves_RowCommand" DataKeyNames="request_ID">
                        <Columns>
                            <asp:BoundField DataField="request_ID" HeaderText="Request ID" />
                            <asp:BoundField DataField="emp_name" HeaderText="Employee" />
                            <asp:BoundField DataField="dept_name" HeaderText="Department" />
                            <asp:BoundField DataField="start_date" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="end_date" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="num_days" HeaderText="Days" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='status-badge status-<%# Eval("final_approval_status").ToString().ToLower() %>'>
                                        <%# Eval("final_approval_status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnApproveUnpaid" runat="server" Text="Approve" CssClass="btn btn-success" 
                                        CommandName="ApproveUnpaid" CommandArgument='<%# Eval("request_ID") %>' />
                                    <asp:Button ID="btnRejectUnpaid" runat="server" Text="Reject" CssClass="btn btn-danger" 
                                        CommandName="RejectUnpaid" CommandArgument='<%# Eval("request_ID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </asp:Panel>

            <!-- Panel 6: Approve/Reject Annual Leaves -->
            <asp:Panel ID="pnlApproveAnnual" runat="server" CssClass="panel">
                <h3>6. Approve/Reject Annual Leave Requests (Dean/Vice-Dean/President)</h3>
                <asp:Label ID="lblApproveAnnualMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label>Approver ID (Dean/Vice-Dean/President)</label>
                        <asp:TextBox ID="txtApproverAnnualID" runat="server" placeholder="Enter your Employee ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnLoadAnnualLeaves" runat="server" Text="Load Pending Requests" CssClass="btn btn-primary" OnClick="btnLoadAnnualLeaves_Click" />
                    </div>
                </div>
                <div class="gridview-container">
                    <asp:GridView ID="gvAnnualLeaves" runat="server" AutoGenerateColumns="False" 
                        CssClass="grid-view" EmptyDataText="No pending annual leave requests."
                        OnRowCommand="gvAnnualLeaves_RowCommand" DataKeyNames="request_ID,replacement_emp">
                        <Columns>
                            <asp:BoundField DataField="request_ID" HeaderText="Request ID" />
                            <asp:BoundField DataField="emp_name" HeaderText="Employee" />
                            <asp:BoundField DataField="dept_name" HeaderText="Department" />
                            <asp:BoundField DataField="start_date" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="end_date" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="num_days" HeaderText="Days" />
                            <asp:BoundField DataField="replacement_name" HeaderText="Replacement" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='status-badge status-<%# Eval("final_approval_status").ToString().ToLower() %>'>
                                        <%# Eval("final_approval_status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button ID="btnApproveAnnual" runat="server" Text="Approve" CssClass="btn btn-success" 
                                        CommandName="ApproveAnnual" CommandArgument='<%# Eval("request_ID") + "," + Eval("replacement_emp") %>' />
                                    <asp:Button ID="btnRejectAnnual" runat="server" Text="Reject" CssClass="btn btn-danger" 
                                        CommandName="RejectAnnual" CommandArgument='<%# Eval("request_ID") + "," + Eval("replacement_emp") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </asp:Panel>

            <!-- Panel 7: Evaluate Employees -->
            <asp:Panel ID="pnlEvaluate" runat="server" CssClass="panel">
                <h3>7. Evaluate Employees (Dean)</h3>
                <asp:Label ID="lblEvaluateMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                <div class="form-row">
                    <div class="form-group">
                        <label>Dean ID</label>
                        <asp:TextBox ID="txtDeanID" runat="server" placeholder="Enter Dean Employee ID"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnLoadEmployees" runat="server" Text="Load Department Employees" CssClass="btn btn-primary" OnClick="btnLoadEmployees_Click" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Select Employee</label>
                        <asp:DropDownList ID="ddlEmployees" runat="server" DataTextField="emp_name" DataValueField="employee_id">
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Semester</label>
                        <asp:DropDownList ID="ddlSemester" runat="server">
                            <asp:ListItem Value="W24">Winter 2024</asp:ListItem>
                            <asp:ListItem Value="S24">Summer 2024</asp:ListItem>
                            <asp:ListItem Value="W25">Winter 2025</asp:ListItem>
                            <asp:ListItem Value="S25">Summer 2025</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Rating (1-5)</label>
                        <asp:DropDownList ID="ddlRating" runat="server">
                            <asp:ListItem Value="1">1 - Poor</asp:ListItem>
                            <asp:ListItem Value="2">2 - Below Average</asp:ListItem>
                            <asp:ListItem Value="3">3 - Average</asp:ListItem>
                            <asp:ListItem Value="4">4 - Good</asp:ListItem>
                            <asp:ListItem Value="5">5 - Excellent</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Comments</label>
                        <asp:TextBox ID="txtEvalComments" runat="server" TextMode="MultiLine" Rows="3" placeholder="Enter evaluation comments"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnSubmitEvaluation" runat="server" Text="Submit Evaluation" CssClass="btn btn-primary" OnClick="btnSubmitEvaluation_Click" />

                <div class="section-divider"></div>
                
                <h3>Previous Evaluations</h3>
                <div class="gridview-container">
                    <asp:GridView ID="gvEvaluations" runat="server" AutoGenerateColumns="False" 
                        CssClass="grid-view" EmptyDataText="No evaluations found.">
                        <Columns>
                            <asp:BoundField DataField="performance_ID" HeaderText="ID" />
                            <asp:BoundField DataField="emp_name" HeaderText="Employee" />
                            <asp:BoundField DataField="semester" HeaderText="Semester" />
                            <asp:BoundField DataField="rating" HeaderText="Rating" />
                            <asp:BoundField DataField="comments" HeaderText="Comments" />
                        </Columns>
                    </asp:GridView>
                </div>
            </asp:Panel>
            
            <!-- Return to Home -->
            <div style="text-align:center; margin:25px 0 5px 0;">
                <asp:Button ID="btnAzerHome" runat="server" Text="Return to Home" CssClass="btn btn-danger" PostBackUrl="~/Default.aspx" />
            </div>
        </div>
    </form>
    <script>
document.addEventListener('DOMContentLoaded', function(){
    const sidebar = document.getElementById('sidebar');
    const openBtn = document.getElementById('sidebarToggle');
    const closeBtn = document.getElementById('sidebarClose');
    const overlay = document.querySelector('.sidebar-overlay');
    function openSidebar(){
        sidebar.classList.add('open');
        document.body.classList.add('sidebar-open');
        if(overlay) overlay.style.display = 'block';
    }
    function closeSidebar(){
        sidebar.classList.remove('open');
        document.body.classList.remove('sidebar-open');
        if(overlay) overlay.style.display = 'none';
    }
    openBtn.addEventListener('click', openSidebar);
    closeBtn.addEventListener('click', closeSidebar);
    if(overlay){
        overlay.addEventListener('mousedown', closeSidebar);
    }
    document.addEventListener('keydown', function(e){
        if(e.key === 'Escape') closeSidebar();
    });
});
    </script>
</body>
</html>
