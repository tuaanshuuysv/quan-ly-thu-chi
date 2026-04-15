package com.store.controller;

import com.store.dao.TransactionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/delete-transaction")
public class DeleteTransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TransactionDAO dao = new TransactionDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // Lấy ID cần xóa
            String idStr = request.getParameter("id");
            if (idStr != null) {
                dao.deleteTransaction(Integer.parseInt(idStr));
            }
        }
        // Xóa xong quay lại trang quản lý chung
        response.sendRedirect(request.getContextPath() + "/manage");
    }
}