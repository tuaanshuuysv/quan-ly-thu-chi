<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.store.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    // Đề phòng trường hợp ai đó truy cập thẳng file .jsp, ta đẩy về login
    if(user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Quản lý Thu Chi</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            display: flex;
            height: 100vh;
            background-color: #f4f7f6;
        }
        /* Thanh menu bên trái */
        .sidebar {
            width: 250px;
            background-color: #2c3e50;
            color: white;
            display: flex;
            flex-direction: column;
        }
        .sidebar h2 {
            text-align: center;
            padding: 20px 0;
            margin: 0;
            background-color: #1a252f;
            font-size: 20px;
        }
        .sidebar a {
            color: #ecf0f1;
            text-decoration: none;
            padding: 15px 20px;
            display: block;
            border-bottom: 1px solid #34495e;
            transition: background 0.3s;
        }
        .sidebar a:hover {
            background-color: #34495e;
        }
        .sidebar a.active {
            background-color: #007bff;
            border-left: 4px solid #fff;
        }
        
        /* Vùng nội dung bên phải */
        .main-content {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .btn-logout {
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            font-weight: bold;
        }
        .btn-logout:hover {
            background-color: #c82333;
        }
        .welcome-card {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>💰 QL Thu Chi</h2>
        <a href="${pageContext.request.contextPath}/dashboard" class="active">Trang chủ (Dashboard)</a>
        <a href="${pageContext.request.contextPath}/add-transaction">📝 Thêm Giao Dịch</a>
        <a href="#">📝 Quản lý Khoản Chi</a>
        <a href="#">📊 Thống kê - Báo cáo</a>
    </div>

    <div class="main-content">
        <div class="header">
            <div>Xin chào, <strong><%= user.getUsername() %></strong> (<%= user.getRole() %>)</div>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Đăng xuất</a>
        </div>

        <div class="welcome-card">
            <h1>Chào mừng đến với Hệ thống Quản lý Thu Chi</h1>
            <p>Hãy chọn các chức năng bên menu trái để bắt đầu làm việc.</p>
        </div>
    </div>

</body>
</html>