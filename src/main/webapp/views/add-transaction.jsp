<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.store.model.Category" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Giao Dịch - Quản lý Thu Chi</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .form-container { background-color: #ffffff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 100%; max-width: 450px; }
        .form-container h2 { margin-top: 0; color: #333; text-align: center; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: 500; margin-bottom: 5px; color: #555; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; font-family: inherit; }
        .btn-submit { width: 100%; padding: 12px; background-color: #28a745; color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; font-size: 16px; margin-top: 10px; }
        .btn-submit:hover { background-color: #218838; }
        .btn-back { display: block; text-align: center; margin-top: 15px; color: #007bff; text-decoration: none; }
        .btn-back:hover { text-decoration: underline; }
        .error { color: red; text-align: center; margin-bottom: 15px; }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Thêm Giao Dịch Mới</h2>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/add-transaction" method="post">
            <div class="form-group">
                <label>Loại Danh mục:</label>
                <select name="categoryId" required>
                    <option value="">-- Chọn danh mục --</option>
                    <% 
                        List<Category> list = (List<Category>) request.getAttribute("categories");
                        if(list != null) {
                            for(Category c : list) {
                                String typeLabel = c.getType().equals("INCOME") ? "(Thu)" : "(Chi)";
                    %>
                                <option value="<%= c.getId() %>"><%= c.getName() %> <%= typeLabel %></option>
                    <%      }
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label>Số tiền (VNĐ):</label>
                <input type="number" name="amount" min="0" required placeholder="Ví dụ: 500000">
            </div>

            <div class="form-group">
                <label>Ngày giao dịch:</label>
                <input type="date" name="transactionDate" required>
            </div>

            <div class="form-group">
                <label>Ghi chú (Tùy chọn):</label>
                <textarea name="note" rows="3" placeholder="Nhập ghi chú..."></textarea>
            </div>

            <button type="submit" class="btn-submit">Lưu Giao Dịch</button>
        </form>
        
        <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">🔙 Quay lại Trang chủ</a>
    </div>

</body>
</html>