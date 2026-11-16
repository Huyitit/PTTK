<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (username != null && !username.trim().isEmpty()) {
            session.setAttribute("username", username.trim());
            session.setAttribute("role", role);
            if ("manager".equalsIgnoreCase(role) || username.toLowerCase().contains("manager") || username.toLowerCase().contains("admin")) {
                response.sendRedirect("view/manager/ManagerScreen.jsp");
                return;
            } else {
                response.sendRedirect("view/customer/CustomerScreen.jsp");
                return;
            }
        } else {
            message = "Please enter your username!";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Cinema Management System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        .login-box {
            max-width: 450px;
            margin: 60px auto;
            background-color: #bfbfbf;
            border: 2px solid #222222;
            padding: 30px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.2);
        }
        .form-group {
            margin-bottom: 16px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
        }
        .form-group input, .form-group select {
            width: 100%;
        }
        .quick-actions {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px dashed #666;
            text-align: center;
        }
        .error-msg {
            color: #d32f2f;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <div class="screen-title">Cinema Management System</div>
        <div style="text-align: center; margin-bottom: 20px; font-weight: bold; font-size: 16px;">
            System Login
        </div>

        <% if (!message.isEmpty()) { %>
            <div class="error-msg"><%= message %></div>
        <% } %>

        <form action="LoginScreen.jsp" method="post">
            <div class="form-group">
                <label for="username">Username / Email:</label>
                <input type="text" id="username" name="username" class="input-text" placeholder="Enter username..." value="customer01" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" class="input-text" placeholder="Enter password..." value="123456" required>
            </div>

            <div class="form-group">
                <label for="role">Role:</label>
                <select id="role" name="role" class="input-select">
                    <option value="customer" selected>Customer</option>
                    <option value="manager">Cinema Manager</option>
                </select>
            </div>

            <div style="text-align: center; margin-top: 20px;">
                <button type="submit" class="btn-blue" style="width: 100%; padding: 10px;">Login</button>
            </div>
        </form>

        <div class="quick-actions">
            <div style="font-size: 13px; font-weight: bold; margin-bottom: 10px;">Quick Test Navigation:</div>
            <div style="display: flex; gap: 10px; justify-content: center;">
                <a href="view/customer/CustomerScreen.jsp" class="btn-white" style="font-size: 13px; padding: 6px 12px;">Customer Home</a>
                <a href="view/manager/ManagerScreen.jsp" class="btn-white" style="font-size: 13px; padding: 6px 12px;">Manager Home</a>
            </div>
        </div>
    </div>

</body>
</html>
