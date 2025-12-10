<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Error</title>
    <style>
        body { background: #DBDBDB; font-family: 'Segoe UI', sans-serif; color: #706F6F; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        .error-box { background: #fff; padding: 40px 50px; border-radius: 16px; box-shadow: 0 4px 24px rgba(139, 69, 87, 0.15); max-width: 500px; text-align: center; }
        .error-title { color: #8B4557; font-size: 2em; margin-bottom: 16px; }
        .error-msg { margin-bottom: 18px; }
        .team-contact { color: #8B4557; font-weight: 600; }
    </style>
</head>
<body>
    <div class="error-box">
        <div class="error-title">Service Unavailable</div>
        <div class="error-msg">
            Sorry, we couldn't connect to the University HR database.<br/>
            Please check your connection and try again.
        </div>
        <div>
            If this problem persists, <span class="team-contact">notify Team 128</span>.
        </div>
    </div>
</body>
</html>
