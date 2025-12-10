<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Login.aspx.cs" Inherits="UniversityHRSystem128.HR_Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HR Login | University</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        /* --- UNIVERSITY PALETTE --- */
        :root {
            --bg-main: #DBDBDB;       /* Light Grey Background */
            --bg-sidebar: #706F6F;    /* Dark Grey */
            --accent: #8B4557;        /* Burgundy */
            --accent-hover: #7a3d4d;  
            --text-main: #706F6F;     /* Dark Grey Text */
            --white: #FFFFFF;
        }

        body { 
            font-family: 'Inter', sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            background-color: var(--bg-main);
            margin: 0;
        }
        
        .login-container { 
            background: var(--white); 
            border-radius: 12px; 
            box-shadow: 0 8px 30px rgba(0,0,0,0.12); 
            width: 420px;
            overflow: hidden;
        }
        
        .login-header {
            background-color: var(--bg-sidebar);
            padding: 40px 30px 30px 30px;
            text-align: center;
            border-radius: 12px 12px 0 0;
        }
        
        .login-header h1 {
            color: var(--white);
            font-size: 28px;
            font-weight: 700;
            margin: 0 0 8px 0;
            letter-spacing: 0.5px;
        }
        
        .login-header h2 {
            color: var(--white);
            font-size: 14px;
            font-weight: 400;
            margin: 0;
            opacity: 0.95;
            letter-spacing: 0.5px;
        }
        
        .login-body {
            padding: 40px 30px 30px 30px;
        }
        
        .form-group { 
            margin-bottom: 24px; 
        }
        
        label { 
            display: block; 
            margin-bottom: 10px; 
            color: var(--text-main);
            font-weight: 600;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }
        
        input[type="text"], 
        input[type="number"], 
        input[type="password"] { 
            width: 100%; 
            padding: 14px 16px; 
            box-sizing: border-box;
            border: 1px solid var(--white);
            border-radius: 6px;
            font-size: 15px;
            color: var(--text-main);
            background: #E3F2FD;
            transition: border-color 0.3s, box-shadow 0.3s, background 0.3s;
            font-family: 'Inter', sans-serif;
        }
        
        input[type="text"]:focus, 
        input[type="number"]:focus, 
        input[type="password"]:focus {
            border-color: var(--white);
            outline: none;
            box-shadow: 0 0 0 2px rgba(139, 69, 87, 0.2);
            background: #BBDEFB;
        }
        
        .btn { 
            width: 100%; 
            padding: 16px; 
            background-color: var(--accent);
            color: var(--white);
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            transition: background-color 0.3s, transform 0.2s;
            margin-top: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn:hover { 
            background-color: var(--accent-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(139, 69, 87, 0.3);
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .login-footer {
            padding: 20px 30px 25px 30px;
            text-align: center;
            border-top: 1px solid var(--accent);
        }
        
        .login-footer p {
            margin: 12px 0 0 0;
            font-size: 12px;
            color: rgba(112, 111, 111, 0.7);
            letter-spacing: 0.3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h1>University HR System</h1>
                <h2>HR Portal Login</h2>
            </div>
            <div class="login-body">
                <div class="form-group">
                    <label>Username</label>
                    <asp:TextBox ID="username" runat="server" TextMode="Number"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn" OnClick="login" />
            </div>
            <div class="login-footer">
                <p>Team 128 • HR Management System</p>
                <asp:Button ID="btnHRLoginHome" runat="server" Text="Return to Home" CssClass="btn" PostBackUrl="~/Default.aspx" />
            </div>
        </div>
    </form>
</body>
</html>