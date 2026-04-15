package com.store.controller;

import com.store.dao.UserDAO;

import com.store.model.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


// Đường dẫn URL để gọi Servlet này
@WebServlet("/login") 
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    // Xử lý khi người dùng gõ thanh địa chỉ: localhost:8080/QuanLyThuChi/login
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Mở trang giao diện đăng nhập
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    // Xử lý khi người dùng bấm nút "Đăng nhập" trên form
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ file jsp gửi lên
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Gọi DAO để kiểm tra DB
        User loggedInUser = userDAO.checkLogin(user, pass);

        if (loggedInUser != null) {
            // Đăng nhập thành công: Lưu User vào Session để dùng cho các trang sau
            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);
            
            // Chuyển hướng sang trang Dashboard (Trang chủ)
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            // Đăng nhập thất bại: Gửi câu thông báo lỗi và quay lại trang login
            request.setAttribute("errorMessage", "Tài khoản hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}