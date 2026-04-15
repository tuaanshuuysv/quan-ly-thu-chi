<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.store.model.Transaction" %>
<%@ page import="com.store.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String currentType = (String) request.getAttribute("currentType");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Giao dịch</title>
    <style>
        /* CSS dùng chung với dashboard */
        body { font-family: 'Segoe UI', sans-serif; margin: 0; display: flex; height: 100vh; background-color: #f4f7f6; }
        .sidebar { width: 250px; background-color: #2c3e50; color: white; display: flex; flex-direction: column; }
        .sidebar h2 { text-align: center; padding: 20px 0; margin: 0; background-color: #1a252f; font-size: 20px; }
        .sidebar a { color: #ecf0f1; text-decoration: none; padding: 15px 20px; display: block; border-bottom: 1px solid #34495e; transition: background 0.3s; }
        .sidebar a:hover { background-color: #34495e; }
        .main-content { flex: 1; padding: 30px; overflow-y: auto; }
        
        /* CSS cho trang quản lý */
        .tabs { margin-bottom: 20px; display: flex; gap: 10px; }
        .tabs a { padding: 10px 20px; background: white; border-radius: 5px; text-decoration: none; color: #333; border: 1px solid #ddd; font-weight: bold; }
        .tabs a.active { background: #007bff; color: white; border-color: #007bff; }
        
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #34495e; color: white; }
        .badge { padding: 5px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; color: white; }
        .badge-thu { background-color: #2ecc71; }
        .badge-chi { background-color: #e74c3c; }
        .btn-delete { color: white; background-color: #dc3545; padding: 6px 12px; text-decoration: none; border-radius: 4px; font-size: 13px; }
        .btn-delete:hover { background-color: #c82333; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>💰 QL Thu Chi</h2>
        <a href="${pageContext.request.contextPath}/dashboard">Trang chủ (Dashboard)</a>
        <a href="${pageContext.request.contextPath}/add-transaction">📝 Thêm Giao Dịch</a>
        <a href="${pageContext.request.contextPath}/manage?type=INCOME" <%= "INCOME".equals(currentType) ? "style='background:#007bff;'" : "" %>>💰 Quản lý Khoản Thu</a>
        <a href="${pageContext.request.contextPath}/manage?type=EXPENSE" <%= "EXPENSE".equals(currentType) ? "style='background:#007bff;'" : "" %>>💸 Quản lý Khoản Chi</a>
        <a href="${pageContext.request.contextPath}/statistics">📊 Thống kê - Báo cáo</a>
    </div>

    <div class="main-content">
        <h2>Quản lý Giao Dịch</h2>
        
        <div class="tabs">
            <a href="${pageContext.request.contextPath}/manage" class="<%= currentType == null ? "active" : "" %>">Tất cả</a>
            <a href="${pageContext.request.contextPath}/manage?type=INCOME" class="<%= "INCOME".equals(currentType) ? "active" : "" %>">Chỉ hiện Khoản Thu</a>
            <a href="${pageContext.request.contextPath}/manage?type=EXPENSE" class="<%= "EXPENSE".equals(currentType) ? "active" : "" %>">Chỉ hiện Khoản Chi</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Mã GD</th>
                    <th>Ngày</th>
                    <th>Danh mục</th>
                    <th>Loại</th>
                    <th>Số tiền (VNĐ)</th>
                    <th>Ghi chú</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Transaction> list = (List<Transaction>) request.getAttribute("transactionList");
                    if(list != null && !list.isEmpty()) {
                        for(Transaction t : list) {
                            boolean isIncome = "INCOME".equals(t.getCategoryType());
                %>
                <tr>
                    <td>#<%= t.getId() %></td>
                    <td><%= t.getTransactionDate() %></td>
                    <td><%= t.getCategoryName() %></td>
                    <td><span class="badge <%= isIncome ? "badge-thu" : "badge-chi" %>"><%= isIncome ? "THU" : "CHI" %></span></td>
                    <td style="color: <%= isIncome ? "#2ecc71" : "#e74c3c" %>; font-weight: bold;">
                        <%= isIncome ? "+" : "-" %> <%= String.format("%,.0f", t.getAmount()) %>
                    </td>
                    <td><%= t.getNote() != null ? t.getNote() : "" %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/delete-transaction?id=<%= t.getId() %>" 
                           class="btn-delete" 
                           onclick="return confirm('Bạn có chắc chắn muốn xóa giao dịch này không?');">Xóa</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="7" style="text-align: center;">Chưa có giao dịch nào phù hợp!</td></tr>
                <%  } %>
            </tbody>
        </table>
    </div>
</body>
</html>