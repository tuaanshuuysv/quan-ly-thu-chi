package com.store.controller;

import com.store.dao.TransactionDAO;
import com.store.model.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/manage")
public class ManageTransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TransactionDAO dao = new TransactionDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy tham số type từ URL (VD: localhost:8080/manage?type=INCOME)
        String type = request.getParameter("type");
        
        // Gọi DAO lấy danh sách
        List<Transaction> list = dao.getAllTransactions(type);
        
        // Truyền dữ liệu sang JSP
        request.setAttribute("transactionList", list);
        request.setAttribute("currentType", type); // Để giao diện biết đang ở tab nào
        
        request.getRequestDispatcher("/views/manage.jsp").forward(request, response);
    }
}