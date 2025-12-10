<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee1.aspx.cs" Inherits="UniversityHRSystem128.Employee1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Login - University HR System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #DBDBDB; min-height: 100vh; }
        .container { max-width: 410px; margin: 70px auto; background: #FFF; border-radius: 12px; box-shadow: 0 6px 24px rgba(112,111,111,0.18); padding: 35px; }
        .header { background: #706F6F; color: #FFF; padding: 25px 0 15px 0; border-radius: 12px 12px 0 0; text-align: center; }
        .header h1 { margin: 0; font-size: 1.7em; font-weight: 600; }
        .input-group { display: flex; flex-direction: column; margin: 20px 0 0 0; }
        .input-group label { color: #706F6F; font-weight: 600; margin-bottom: 6px; }
        .input-group input[type="text"], .input-group input[type="password"] { padding: 13px 10px; border: 2px solid #706F6F; border-radius: 6px; font-size: 15px; color: #706F6F; transition: border-color 0.3s, box-shadow 0.3s; }
        .input-group input:focus { outline: none; border-color: #8B4557; box-shadow: 0 0 0 2px rgba(139, 69, 87, 0.17); }
        .btn { padding: 13px 0; border: none; border-radius: 6px; font-size: 16px; font-weight: 600; cursor: pointer; background: #8B4557; color: #FFF; width: 100%; margin-top: 25px; transition: background 0.3s, box-shadow 0.3s; text-transform: uppercase; }
        .btn:hover { background: #706F6F; box-shadow: 0 4px 12px rgba(112,111,111,0.12); }
        .alert { margin-top: 18px; font-size: 1em; padding: 10px 16px; background: #f8d7da; border-radius: 6px; color: #bc1a3a; border: 1px solid #f5c6cb; text-align:center;}
        .login-footer {
            text-align: center;
            padding: 20px 0 25px 0;
            margin-top: 20px;
            border-top: 1px solid rgba(112, 111, 111, 0.2);
        }
        .login-footer p {
            margin: 0 0 12px 0;
            font-size: 12px;
            color: rgba(112, 111, 111, 0.7);
            letter-spacing: 0.3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header"><h1>Employee Login</h1></div>
            <div class="input-group">
                <label for="txtEmployeeID">Employee ID</label>
                <asp:TextBox ID="txtEmployeeID" runat="server" CssClass="form-control" />
            </div>
            <div class="input-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
            <div class="login-footer">
                <p>Team 128 • HR Management System</p>
                <asp:Button ID="btnEmployeeLoginHome" runat="server" Text="Return to Home" CssClass="btn" PostBackUrl="~/Default.aspx" />
            </div>
        </div>
    </form>
</body>
</html>
