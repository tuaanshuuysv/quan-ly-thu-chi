package com.store.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession(false);
        
        // Nếu có session thì hủy nó đi (Xóa toàn bộ dữ liệu lưu trữ tạm thời)
        if (session != null) {
            session.invalidate();
        }
        
        // Chuyển hướng về trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/login");
    }
}