<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Dashboard.aspx.cs" Inherits="UniversityHRSystem128.HR_Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HR Dashboard | University</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    
    <style>
        /* --- UNIVERSITY PALETTE --- */
        :root {
            --bg-main: #DBDBDB;       /* Light Grey Background */
            --bg-sidebar: #706F6F;    /* Dark Grey Sidebar/Header */
            --accent: #8B4557;        /* Burgundy (Buttons/Links) */
            --accent-hover: #7a3d4d;  
            --text-sidebar: #FFFFFF;  /* White text for sidebar */
            --text-main: #706F6F;     /* Dark Grey Text */
            --white: #FFFFFF;
            --border-color: #706F6F;
            --message-bg: rgba(139, 69, 87, 0.2); /* Soft burgundy tint for messages */
        }

        /* --- ANIMATIONS --- */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideIn {
            from { transform: translateX(-20px); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        body { 
            font-family: 'Inter', sans-serif; 
            margin: 0; 
            background-color: var(--bg-main); 
            color: var(--text-main); 
            display: flex; 
            flex-direction: column;
            min-height: 100vh;
            overflow-x: auto;
        }
        
        /* Zoom wrapper for entire page */
        #zoom-wrapper {
            transform: scale(0.85);
            transform-origin: top left;
            width: 117.65%; /* Compensate for scale: 100% / 0.85 = 117.65% */
            min-height: 117.65vh;
        }
        
        /* --- TOP HEADER --- */
        .top-header {
            background: var(--bg-sidebar);
            padding: 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            animation: fadeIn 0.5s ease-out;
        }
        
        .header-container {
            max-width: 100%;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 30px;
        }
        
        .header-brand {
            color: var(--white);
            font-size: 1.4em;
            font-weight: 600;
            padding: 18px 0;
            text-decoration: none;
        }
        
        .header-nav {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            gap: 0;
        }
        
        .header-nav li {
            position: relative;
        }
        
        .header-nav a {
            color: var(--white);
            text-decoration: none;
            padding: 18px 20px;
            display: block;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .header-nav a:hover {
            background: var(--accent);
            color: var(--white);
        }
        
        .header-nav a.active {
            background: var(--accent);
            color: var(--white);
        }
        
        .header-nav-link {
            color: var(--white) !important;
            text-decoration: none !important;
            padding: 18px 20px !important;
            display: block !important;
            font-weight: 500 !important;
            font-size: 14px !important;
            transition: all 0.3s ease !important;
            cursor: pointer !important;
            background: transparent !important;
            border: none !important;
        }
        
        .header-nav-link:hover {
            background: var(--accent) !important;
            color: var(--white) !important;
        }
        

        /* --- MAIN CONTENT --- */
        .page-wrapper {
            display: flex;
            flex: 1;
            margin-top: 60px;
        }
        
        .main-content { 
            flex: 1; 
            padding: 30px 50px; 
            width: 100%; 
            box-sizing: border-box;
            display: flex;
            justify-content: center;
        }
        
        .content-wrapper {
            max-width: 1600px;
            width: 100%;
            box-sizing: border-box;
        }

        h1, h2 { color: var(--text-main); }
        h1 { font-size: 32px; font-weight: 700; margin-bottom: 15px; animation: fadeIn 0.4s ease-out; }
        h2 { font-size: 24px; font-weight: 600; margin: 0 0 25px 0; border-bottom: 3px solid var(--accent); padding-bottom: 12px; display: inline-block;}
        
        /* Message Styling */
        #lblMessage {
            border: 2px solid var(--accent) !important;
            background-color: var(--message-bg) !important;
            padding: 12px 20px !important;
        }

        /* --- CARDS --- */
        .card { 
            background: var(--white); 
            padding: 60px;           /* increased padding for bigger cards */
            margin-bottom: 40px;     /* more spacing between cards */
            border-radius: 14px; 
            box-shadow: 0 10px 28px rgba(0,0,0,0.14), 0 3px 8px rgba(0,0,0,0.09); 
            border: 1px solid #d5d5d5;
            animation: fadeIn 0.6s ease-out;
            transition: box-shadow 0.3s ease, transform 0.3s ease;
        }
        
        .card:hover {
            box-shadow: 0 12px 32px rgba(0,0,0,0.15), 0 4px 8px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }

        /* --- PROFILE CARD --- */
        .profile-section {
            display: flex; align-items: center; gap: 18px; margin-bottom: 25px;
            background: var(--white); padding: 18px 30px; border-radius: 50px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1), 0 2px 4px rgba(0,0,0,0.06); 
            width: fit-content;
            border-left: 6px solid var(--bg-sidebar); /* Dark Grey Border */
            animation: fadeIn 0.5s ease-out;
            transition: box-shadow 0.3s ease;
        }
        
        .profile-section:hover {
            box-shadow: 0 8px 24px rgba(0,0,0,0.12), 0 3px 6px rgba(0,0,0,0.08);
        }
        .profile-icon { width: 55px; height: 55px; background: var(--accent); color: var(--white); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; }
        .profile-info h3 { margin: 0; font-size: 18px; font-weight: 700; color: var(--text-main); }
        .profile-info p { margin: 3px 0 0 0; font-size: 14px; color: var(--text-main); opacity: 0.8; }

        /* --- TABLE --- */
        .table-responsive { border-radius: 8px; overflow: hidden; border: 1px solid #ddd; }
        .custom-table { width: 100%; border-collapse: collapse; font-size: 15px; }
        .custom-table th { 
            background-color: var(--bg-sidebar); /* Dark Grey Header */
            color: var(--white); 
            padding: 20px; text-align: center; 
            font-weight: 600; 
            font-size: 16px;
        }
        .custom-table td { padding: 20px; border-bottom: 1px solid #eee; color: var(--text-main); vertical-align: middle; text-align: center; font-size: 15px; }
        .custom-table tr:hover { background-color: #f9f9f9; }

        /* --- BADGES --- */
        .badge { padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: 600; display: inline-block; text-transform: uppercase; letter-spacing: 0.5px; }
        /* Keep original colors for logic clarity */
        .type-annual { background: #e3f2fd; color: #1565c0; }
        .type-unpaid { background: #f3e5f5; color: #7b1fa2; }
        .type-medical { background: #e0f2f1; color: #00695c; }
        .type-accidental { background: #fff3e0; color: #ef6c00; }
        .type-compensation { background: #ede7f6; color: #4527a0; }
        .status-pending { background: #fff8e1; color: #ff8f00; border: 1px solid #ffcc80; }
        .status-approved { background: #e8f5e9; color: #2e7d32; border: 1px solid #a5d6a7; }
        .status-rejected { background: #ffebee; color: #c62828; border: 1px solid #ef9a9a; }

        /* --- BUTTONS (Updated to Palette) --- */
        .btn { padding: 14px 26px; border-radius: 6px; font-size: 15px; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 8px; transition: 0.2s; }
        .btn:hover { transform: translateY(-2px); box-shadow: 0 3px 8px rgba(0,0,0,0.1); }
        
        /* Primary: Burgundy */
        .btn-primary { background-color: var(--accent); color: var(--white); border: none; }
        .btn-primary:hover { background-color: var(--accent-hover); }

        /* Secondary: Transparent with Dark Grey Border */
        .btn-outline { background: transparent; border: 1px solid var(--bg-sidebar); color: var(--bg-sidebar); }
        .btn-outline:hover { background: var(--bg-sidebar); color: var(--white); }

        /* Accept (Keep Green) */
        .btn-accept { background-color: #28a745; color: white; border: none; padding: 8px 16px; font-size: 14px; border-radius: 6px; }
        .btn-accept:hover { background-color: #218838; }
        
        /* Logout Button */
        .btn-logout {
            background-color: var(--accent);
            color: var(--white);
            border: 1px solid var(--accent);
            padding: 12px 22px;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: 0.2s;
        }
        .btn-logout:hover {
            background-color: var(--accent-hover);
            border-color: var(--accent-hover);
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
        }

        /* --- INPUTS --- */
        .input-group { display: flex; flex-direction: column; gap: 10px; flex: 1; min-width: 150px; }
        .input-group label { font-size: 15px; font-weight: 700; color: var(--text-main); }
        
        /* Input Border: Dark Grey -> Focus: Burgundy */
        input[type="text"], input[type="date"], input[type="number"] {
            padding: 14px; 
            border: 2px solid var(--bg-sidebar); 
            border-radius: 6px; 
            font-size: 15px; width: 100%; box-sizing: border-box;
            color: var(--text-main);
            background: #fafafa;
            transition: border-color 0.3s;
        }
        input:focus { 
            border-color: var(--accent); 
            outline: none; 
            box-shadow: 0 0 0 3px rgba(139, 69, 87, 0.2); 
        }
    </style>
    <script>
        // Set active header link based on current page
        window.onload = function() {
            var currentUrl = window.location.href;
            var headerLinks = document.querySelectorAll('.header-nav a');
            
            headerLinks.forEach(function(link) {
                link.classList.remove('active');
                var linkUrl = link.getAttribute('href');
                if (linkUrl && currentUrl.indexOf(linkUrl.split('?')[0]) !== -1) {
                    // Check if it contains the view parameter
                    if (linkUrl.includes('view=')) {
                        var viewParam = linkUrl.split('view=')[1];
                        if (currentUrl.includes('view=' + viewParam)) {
                            link.classList.add('active');
                        }
                    }
                }
            });
        };
    </script>
</head>
<body>
    <div id="zoom-wrapper">
    <form id="form1" runat="server">
        
        <!-- Top Header -->
        <div class="top-header">
            <div class="header-container">
                <div class="header-brand">University HR System</div>
                <ul class="header-nav">
                    <li><a href="HR_Dashboard.aspx?view=Employee_Approve_Leave">Approvals</a></li>
                    <li><a href="HR_Dashboard.aspx?view=Leave">Requests</a></li>
                    <li><a href="HR_Dashboard.aspx?view=Payroll">Payroll</a></li>
                    <li><a href="HR_Dashboard.aspx?view=Deduction">Deduction</a></li>
                    <li>
                        <asp:LinkButton ID="btnHeaderLogout" runat="server" CssClass="header-nav-link" OnClick="logout">Logout</asp:LinkButton>
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="page-wrapper">
            <div class="main-content">
            <div class="content-wrapper">
                    <div style="display:flex; justify-content:space-between; align-items:center; animation: fadeIn 0.5s; margin-bottom: 20px;">
                        <h1>HR Portal</h1>
                        <div style="display:flex; align-items:center; gap:15px;">
                            <div class="profile-section">
                                <div class="profile-icon"><i class="fas fa-user"></i></div>
                                <div class="profile-info">
                                    <h3><asp:Label ID="lblHRName" runat="server"></asp:Label></h3>
                                    <p><asp:Label ID="lblHRRole" runat="server"></asp:Label> (ID: <asp:Label ID="lblHRID" runat="server"></asp:Label>)</p>
                                </div>
                            </div>
                        </div>
                    </div>

                <asp:Label ID="lblMessage" runat="server" Font-Bold="true" style="display:block; margin-bottom:15px; padding: 10px; border-radius: 6px; text-align:center;" Visible="false"></asp:Label>

                <asp:Panel ID="pnlDashboard" runat="server">
                
                <div style="display: grid; grid-template-columns: 2.2fr 1.2fr; gap: 25px; align-items: start;">
                    <!-- Left Column: Approvals -->
                    <div class="card">
                        <h2>My Assigned Approvals</h2>
                        <div class="table-responsive">
                            <asp:GridView ID="gvLeaves" runat="server" AutoGenerateColumns="False" CssClass="custom-table" OnRowCommand="gvLeaves_RowCommand" GridLines="None" EmptyDataText="All caught up! No pending approvals.">
                                <Columns>
                                    <asp:BoundField DataField="request_ID" HeaderText="ID" ItemStyle-Font-Bold="true" />
                                    <asp:TemplateField HeaderText="Employee"><ItemTemplate><div><%# Eval("Applicant") %></div><div style="font-size:10px; color:#666;"><%# Eval("Department") %></div></ItemTemplate></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Type"><ItemTemplate><span class='badge type-<%# Eval("leave_type").ToString().ToLower() %>'><%# Eval("leave_type") %></span></ItemTemplate></asp:TemplateField>
                                    <asp:BoundField DataField="start_date" HeaderText="Start" DataFormatString="{0:MMM dd}" />
                                    <asp:BoundField DataField="end_date" HeaderText="End" DataFormatString="{0:MMM dd}" />
                                    <asp:TemplateField HeaderText="Days"><ItemTemplate><strong><%# Eval("num_days") %></strong></ItemTemplate></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status"><ItemTemplate><span class='badge status-<%# Eval("final_approval_status").ToString().ToLower() %>'><%# Eval("final_approval_status") %></span></ItemTemplate></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:Button ID="btnApprove" runat="server" Text="✔ Accept" CommandName="ApproveLeave" CommandArgument='<%# Eval("request_ID") + "," + Eval("leave_type") %>' CssClass="btn btn-accept" Visible='<%# Eval("final_approval_status").ToString().Trim().ToLower() == "pending" && Eval("leave_type").ToString() != "Medical" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                    
                    <!-- Right Column: Deductions and Payroll stacked -->
                    <div style="display: flex; flex-direction: column; gap: 20px;">
                        <div class="card">
                            <h2>Manage Deductions</h2>
                            <div class="input-group" style="margin-bottom: 20px;">
                                <label>Target Employee ID</label>
                                <asp:TextBox ID="txtDedEmpID" runat="server" TextMode="Number"></asp:TextBox>
                            </div>
                            <div style="display:flex; gap:10px; flex-wrap:wrap;">
                                <asp:Button ID="btnDedHours" runat="server" Text="Missing Hours" CssClass="btn btn-outline" OnClick="applyDeductionHours" />
                                <asp:Button ID="btnDedDays" runat="server" Text="Missing Days" CssClass="btn btn-outline" OnClick="applyDeductionDays" />
                                <asp:Button ID="btnDedUnpaid" runat="server" Text="Unpaid Leave" CssClass="btn btn-outline" OnClick="applyDeductionUnpaid" />
                            </div>
                        </div>

                        <div class="card">
                            <h2>Generate Payroll</h2>
                            <div class="input-group" style="margin-bottom: 15px;">
                                <label>Target Employee ID</label>
                                <asp:TextBox ID="txtPayEmpID" runat="server" TextMode="Number"></asp:TextBox>
                            </div>
                            <div style="display:flex; gap:15px; margin-bottom: 20px;">
                                <div class="input-group"><label>From Date</label><asp:TextBox ID="txtFromDate" runat="server" TextMode="Date"></asp:TextBox></div>
                                <div class="input-group"><label>To Date</label><asp:TextBox ID="txtToDate" runat="server" TextMode="Date"></asp:TextBox></div>
                            </div>
                            <asp:Button ID="btnPayroll" runat="server" Text="Generate Payroll" CssClass="btn btn-primary" OnClick="generatePayroll" style="width:100%; justify-content: center;" />
                        </div>
                    </div>
                </div>
                </asp:Panel>

                <asp:Panel ID="pnlDataView" runat="server" Visible="false">
                <div class="card">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                        <h2><asp:Label ID="lblTableName" runat="server"></asp:Label></h2>
                        <a href="HR_Dashboard.aspx" class="btn btn-primary">Back</a>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvGeneric" runat="server" AutoGenerateColumns="true" CssClass="custom-table" GridLines="None" EmptyDataText="No data found."></asp:GridView>
                    </div>
                </div>
                </asp:Panel>

                <!-- Return to Home -->
                <div style="text-align:center; margin:25px 0 5px 0;">
                    <asp:Button ID="btnHRDashboardHome" runat="server" Text="Return to Home" CssClass="btn btn-outline" PostBackUrl="~/Default.aspx" />
                </div>
            </div>
        </div>
    </form>
    </div>
</body>
</html>