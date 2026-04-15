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

        <style>
            .stats-container { display: flex; gap: 20px; margin-bottom: 30px; }
            .stat-card { flex: 1; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); text-align: center; }
            .stat-card h3 { margin: 0; color: #7f8c8d; font-size: 16px; text-transform: uppercase; }
            .stat-card .amount { font-size: 24px; font-weight: bold; margin-top: 10px; }
            .amount.income { color: #2ecc71; }
            .amount.expense { color: #e74c3c; }
            .amount.balance { color: #3498db; }
            
            table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
            th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
            th { background-color: #34495e; color: white; }
            .badge { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; color: white; }
            .badge-thu { background-color: #2ecc71; }
            .badge-chi { background-color: #e74c3c; }
        </style>

        <div class="stats-container">
            <div class="stat-card">
                <h3>Tổng Thu</h3>
                <div class="amount income">+ <%= String.format("%,.0f", request.getAttribute("totalIncome")) %> VNĐ</div>
            </div>
            <div class="stat-card">
                <h3>Tổng Chi</h3>
                <div class="amount expense">- <%= String.format("%,.0f", request.getAttribute("totalExpense")) %> VNĐ</div>
            </div>
            <div class="stat-card">
                <h3>Số Dư (Lợi Nhuận)</h3>
                <div class="amount balance"><%= String.format("%,.0f", request.getAttribute("balance")) %> VNĐ</div>
            </div>
        </div>

        <h3>Lịch sử giao dịch gần đây</h3>
        <table>
            <thead>
                <tr>
                    <th>Ngày</th>
                    <th>Danh mục</th>
                    <th>Loại</th>
                    <th>Số tiền (VNĐ)</th>
                    <th>Ghi chú</th>
                </tr>
            </thead>
            <tbody>
                <%@ page import="java.util.List" %>
                <%@ page import="com.store.model.Transaction" %>
                <%
                    List<Transaction> list = (List<Transaction>) request.getAttribute("recentList");
                    if(list != null && !list.isEmpty()) {
                        for(Transaction t : list) {
                            boolean isIncome = "INCOME".equals(t.getCategoryType());
                %>
                <tr>
                    <td><%= t.getTransactionDate() %></td>
                    <td><%= t.getCategoryName() %></td>
                    <td>
                        <span class="badge <%= isIncome ? "badge-thu" : "badge-chi" %>">
                            <%= isIncome ? "THU" : "CHI" %>
                        </span>
                    </td>
                    <td class="<%= isIncome ? "amount income" : "amount expense" %>">
                        <%= isIncome ? "+" : "-" %> <%= String.format("%,.0f", t.getAmount()) %>
                    </td>
                    <td><%= t.getNote() != null ? t.getNote() : "" %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" style="text-align: center;">Chưa có giao dịch nào!</td>
                </tr>
                <%  } %>
            </tbody>
        </table>
    </div>

</body>
</html>