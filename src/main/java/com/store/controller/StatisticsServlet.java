package com.store.controller;

import com.store.dao.TransactionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/statistics")
public class StatisticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TransactionDAO dao = new TransactionDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy dữ liệu thống kê
        Map<String, Double> incomeData = dao.getIncomeStats();
        Map<String, Double> expenseData = dao.getExpenseStats();
        
        // Tính tổng để hiển thị nhanh
        double totalIncome = dao.getTotalByType("INCOME");
        double totalExpense = dao.getTotalByType("EXPENSE");

        // Gửi sang JSP
        request.setAttribute("incomeData", incomeData);
        request.setAttribute("expenseData", expenseData);
        request.setAttribute("totalIncome", totalIncome);
        request.setAttribute("totalExpense", totalExpense);

        request.getRequestDispatcher("/views/statistics.jsp").forward(request, response);
    }
}