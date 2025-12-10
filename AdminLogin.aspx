<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="UniversityHRSystem128.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login - University HR System</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: #FFFFFF;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(112, 111, 111, 0.15);
            width: 100%;
            max-width: 420px;
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            background: #706F6F;
            color: #FFFFFF;
            padding: 30px;
            text-align: center;
        }

        .login-header h1 {
            font-size: 1.8em;
            font-weight: 600;
            margin-bottom: 8px;
            animation: fadeIn 0.8s ease-out 0.3s both;
        }

        .login-header p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.95em;
            animation: fadeIn 0.8s ease-out 0.5s both;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .login-body {
            padding: 35px 30px;
        }

        .input-group {
            margin-bottom: 20px;
            animation: slideIn 0.5s ease-out both;
        }

        .input-group:nth-child(1) {
            animation-delay: 0.4s;
        }

        .input-group:nth-child(2) {
            animation-delay: 0.5s;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .input-group label {
            display: block;
            font-weight: 600;
            color: #706F6F;
            margin-bottom: 8px;
            font-size: 0.9em;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-group input[type="text"],
        .input-group input[type="password"] {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #706F6F;
            border-radius: 6px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s, transform 0.2s;
            color: #706F6F;
            background: #FFFFFF;
        }

        .input-group input[type="text"]:focus,
        .input-group input[type="password"]:focus {
            outline: none;
            border-color: #8B4557;
            box-shadow: 0 0 0 3px rgba(139, 69, 87, 0.2);
            transform: translateY(-2px);
        }

        .input-group input[type="text"]::placeholder,
        .input-group input[type="password"]::placeholder {
            color: #999;
        }

        .btn-login {
            width: 100%;
            padding: 14px 28px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: #8B4557;
            color: #FFFFFF;
            border: 2px solid #8B4557;
            margin-top: 10px;
            animation: slideIn 0.5s ease-out 0.6s both;
        }

        .btn-login:hover {
            background: #706F6F;
            border-color: #706F6F;
            box-shadow: 0 4px 12px rgba(112, 111, 111, 0.3);
            transform: translateY(-2px);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .message {
            display: block;
            padding: 12px 16px;
            border-radius: 6px;
            margin-top: 20px;
            font-weight: 500;
            text-align: center;
            animation: fadeIn 0.4s ease-out;
        }

        .message-success {
            background: rgba(139, 69, 87, 0.15);
            color: #8B4557;
            border: 1px solid #8B4557;
        }

        .message-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .login-footer {
            text-align: center;
            padding: 0 30px 25px;
            animation: fadeIn 0.8s ease-out 0.7s both;
        }

        .login-footer p {
            color: #999;
            font-size: 0.85em;
        }

        .brand-accent {
            width: 60px;
            height: 4px;
            background: #8B4557;
            margin: 0 auto 15px;
            border-radius: 2px;
        }

        @media (max-width: 480px) {
            .login-container {
                margin: 20px;
                max-width: none;
            }

            .login-header {
                padding: 25px 20px;
            }

            .login-body {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h1>University HR System</h1>
                <p>Admin Portal Login</p>
            </div>
            <div class="login-body">
                <div class="input-group">
                    <label>Username</label>
                    <asp:TextBox ID="username" runat="server" placeholder="Enter your username"></asp:TextBox>
                </div>
                <div class="input-group">
                    <label>Password</label>
                    <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                </div>
                <asp:Button ID="signin" runat="server" OnClick="AdminLogin_Click" Text="Log In" CssClass="btn-login" />
                <asp:Panel ID="pnlError" runat="server" Visible="false">
                    <div class="message message-error">
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                    </div>
                </asp:Panel>
            </div>
            <div class="login-footer">
                <div class="brand-accent"></div>
                <p>Team 128 &bull; HR Management System</p>
                <asp:Button ID="btnAdminLoginHome" runat="server" Text="Return to Home" CssClass="btn-login" PostBackUrl="~/Default.aspx" />
            </div>
        </div>
    </form>
</body>
</html>

