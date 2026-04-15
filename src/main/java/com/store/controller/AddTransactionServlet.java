package com.store.controller;

import com.store.dao.CategoryDAO;
import com.store.dao.TransactionDAO;
import com.store.model.Category;
import com.store.model.Transaction;
import com.store.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/add-transaction")
public class AddTransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO = new CategoryDAO();
    private TransactionDAO transactionDAO = new TransactionDAO();

    // Hiển thị form nhập liệu
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy danh sách danh mục và gửi sang JSP
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/views/add-transaction.jsp").forward(request, response);
    }

    // Xử lý khi bấm nút "Lưu Giao Dịch"
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Hỗ trợ tiếng Việt

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            // Lấy dữ liệu từ form
            double amount = Double.parseDouble(request.getParameter("amount"));
            Date date = Date.valueOf(request.getParameter("transactionDate"));
            String note = request.getParameter("note");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            // Tạo đối tượng Transaction
            Transaction t = new Transaction(0, amount, date, note, categoryId, user.getId());

            // Lưu vào DB
            boolean isSuccess = transactionDAO.addTransaction(t);

            if (isSuccess) {
                // Nếu thành công, quay về Dashboard
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi lưu vào cơ sở dữ liệu!");
                doGet(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu nhập vào không hợp lệ!");
            doGet(request, response);
        }
    }
}