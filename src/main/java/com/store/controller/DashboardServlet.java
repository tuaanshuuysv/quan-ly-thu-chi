package com.store.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

import com.store.dao.TransactionDAO;
import com.store.model.Transaction;
import com.store.model.User;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session != null && session.getAttribute("user") != null) {
			// -- ĐOẠN CODE MỚI THÊM VÀO ĐÂY --
			TransactionDAO dao = new TransactionDAO();

			// Lấy tổng thu, tổng chi
			double totalIncome = dao.getTotalByType("INCOME");
			double totalExpense = dao.getTotalByType("EXPENSE");
			double balance = totalIncome - totalExpense;

			// Lấy danh sách giao dịch
			List<Transaction> recentList = dao.getRecentTransactions();

			// Gửi dữ liệu sang JSP
			request.setAttribute("totalIncome", totalIncome);
			request.setAttribute("totalExpense", totalExpense);
			request.setAttribute("balance", balance);
			request.setAttribute("recentList", recentList);
			// ---------------------------------

			request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
		} else {
			request.setAttribute("errorMessage", "Vui lòng đăng nhập để truy cập hệ thống!");
			request.getRequestDispatcher("/views/login.jsp").forward(request, response);
		}
	}
}