package com.store.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.store.model.User;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session hiện tại (false nghĩa là không tạo mới nếu chưa có)
        HttpSession session = request.getSession(false);
        
        // Kiểm tra xem session có tồn tại và có chứa thông tin user không
        if (session != null && session.getAttribute("user") != null) {
            // Đã đăng nhập -> Cho phép vào trang dashboard.jsp
            request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
        } else {
            // Chưa đăng nhập hoặc hết phiên -> Đuổi về trang login kèm thông báo
            request.setAttribute("errorMessage", "Vui lòng đăng nhập để truy cập hệ thống!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}