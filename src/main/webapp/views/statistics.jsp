<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê Báo cáo</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 0; display: flex; height: 100vh; background-color: #f4f7f6; }
        .sidebar { width: 250px; background-color: #2c3e50; color: white; display: flex; flex-direction: column; }
        .sidebar a { color: #ecf0f1; text-decoration: none; padding: 15px 20px; display: block; border-bottom: 1px solid #34495e; }
        .main-content { flex: 1; padding: 30px; overflow-y: auto; }
        .chart-container { display: flex; gap: 30px; margin-top: 20px; flex-wrap: wrap; }
        .chart-box { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); flex: 1; min-width: 400px; text-align: center; }
        h2 { color: #333; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2 style="text-align:center; padding:20px; background:#1a252f; margin:0; font-size:20px;">💰 QL Thu Chi</h2>
        <a href="${pageContext.request.contextPath}/dashboard">Trang chủ (Dashboard)</a>
        <a href="${pageContext.request.contextPath}/add-transaction">📝 Thêm Giao Dịch</a>
        <a href="${pageContext.request.contextPath}/manage?type=INCOME">💰 Quản lý Khoản Thu</a>
        <a href="${pageContext.request.contextPath}/manage?type=EXPENSE">💸 Quản lý Khoản Chi</a>
        <a href="${pageContext.request.contextPath}/statistics" style="background:#007bff;">📊 Thống kê - Báo cáo</a>
    </div>

    <div class="main-content">
        <h2>Phân tích Thống kê Thu Chi</h2>
        <p>Tổng quát tình hình kinh doanh của cửa hàng.</p>

        <div class="chart-container">
            <div class="chart-box">
                <h3>Cơ cấu Khoản Thu</h3>
                <canvas id="incomeChart"></canvas>
            </div>

            <div class="chart-box">
                <h3>Cơ cấu Khoản Chi</h3>
                <canvas id="expenseChart"></canvas>
            </div>
        </div>
    </div>

    <script>
        // Lấy dữ liệu từ Java gửi sang
        <%
            Map<String, Double> incomeData = (Map<String, Double>) request.getAttribute("incomeData");
            Map<String, Double> expenseData = (Map<String, Double>) request.getAttribute("expenseData");
        %>

        // Cấu hình Biểu đồ Thu
        const incomeCtx = document.getElementById('incomeChart').getContext('2d');
        new Chart(incomeCtx, {
            type: 'pie',
            data: {
                labels: [<% for(String key : incomeData.keySet()) { %> '<%= key %>', <% } %>],
                datasets: [{
                    data: [<% for(Double val : incomeData.values()) { %> <%= val %>, <% } %>],
                    backgroundColor: ['#2ecc71', '#3498db', '#9b59b6', '#f1c40f', '#e67e22']
                }]
            }
        });

        // Cấu hình Biểu đồ Chi
        const expenseCtx = document.getElementById('expenseChart').getContext('2d');
        new Chart(expenseCtx, {
            type: 'doughnut', // Kiểu biểu đồ hình vành khăn cho đa dạng
            data: {
                labels: [<% for(String key : expenseData.keySet()) { %> '<%= key %>', <% } %>],
                datasets: [{
                    data: [<% for(Double val : expenseData.values()) { %> <%= val %>, <% } %>],
                    backgroundColor: ['#e74c3c', '#e67e22', '#f1c40f', '#95a5a6', '#34495e']
                }]
            }
        });
    </script>
</body>
</html>