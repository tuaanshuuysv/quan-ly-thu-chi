package com.store.dao;

import com.store.model.Transaction;
import com.store.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class TransactionDAO {
    
    // Hàm thêm giao dịch mới
    public boolean addTransaction(Transaction t) {
        String sql = "INSERT INTO transactions (amount, transaction_date, note, category_id, user_id) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDouble(1, t.getAmount());
            ps.setDate(2, t.getTransactionDate());
            ps.setString(3, t.getNote());
            ps.setInt(4, t.getCategoryId());
            ps.setInt(5, t.getUserId());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu chèn thành công
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}