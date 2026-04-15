package com.store.dao;

import com.store.model.Transaction;
import com.store.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TransactionDAO {

	// Hàm thêm giao dịch mới
	public boolean addTransaction(Transaction t) {
		String sql = "INSERT INTO transactions (amount, transaction_date, note, category_id, user_id) VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

	public double getTotalByType(String type) {
		double total = 0;
		// Kết hợp (JOIN) bảng transactions và categories để lọc theo loại
		// (INCOME/EXPENSE)
		String sql = "SELECT SUM(t.amount) as total FROM transactions t "
				+ "JOIN categories c ON t.category_id = c.id WHERE c.type = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, type);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				total = rs.getDouble("total");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

	// 2. Hàm lấy danh sách giao dịch gần đây (kèm tên danh mục)
	public List<Transaction> getRecentTransactions() {
		List<Transaction> list = new java.util.ArrayList<>();
		// JOIN 2 bảng để lấy được tên danh mục thay vì chỉ lấy ID
		String sql = "SELECT t.*, c.name as category_name, c.type as category_type "
				+ "FROM transactions t JOIN categories c ON t.category_id = c.id "
				+ "ORDER BY t.transaction_date DESC LIMIT 10"; // Lấy 10 dòng mới nhất

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Transaction t = new Transaction();
				t.setId(rs.getInt("id"));
				t.setAmount(rs.getDouble("amount"));
				t.setTransactionDate(rs.getDate("transaction_date"));
				t.setNote(rs.getString("note"));

				// Gán thêm 2 trường mới tạo
				t.setCategoryName(rs.getString("category_name"));
				t.setCategoryType(rs.getString("category_type"));

				list.add(t);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<Transaction> getAllTransactions(String typeFilter) {
        List<Transaction> list = new java.util.ArrayList<>();
        String sql = "SELECT t.*, c.name as category_name, c.type as category_type " +
                     "FROM transactions t JOIN categories c ON t.category_id = c.id ";
        
        // Nếu có truyền loại filter vào thì thêm điều kiện WHERE
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql += "WHERE c.type = ? ";
        }
        sql += "ORDER BY t.transaction_date DESC"; // Mới nhất lên đầu
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (typeFilter != null && !typeFilter.isEmpty()) {
                ps.setString(1, typeFilter);
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Transaction t = new Transaction();
                t.setId(rs.getInt("id"));
                t.setAmount(rs.getDouble("amount"));
                t.setTransactionDate(rs.getDate("transaction_date"));
                t.setNote(rs.getString("note"));
                t.setCategoryName(rs.getString("category_name"));
                t.setCategoryType(rs.getString("category_type"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Xóa giao dịch theo ID
    public boolean deleteTransaction(int id) {
        String sql = "DELETE FROM transactions WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Map<String, Double> getIncomeStats() {
        Map<String, Double> stats = new HashMap<>();
        String sql = "SELECT c.name, SUM(t.amount) as total FROM transactions t " +
                     "JOIN categories c ON t.category_id = c.id WHERE c.type = 'INCOME' " +
                     "GROUP BY c.name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getString("name"), rs.getDouble("total"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return stats;
    }
    
    
    public Map<String, Double> getExpenseStats() {
		Map<String, Double> stats = new HashMap<>();
		String sql = "SELECT c.name, SUM(t.amount) as total FROM transactions t " +
					 "JOIN categories c ON t.category_id = c.id WHERE c.type = 'EXPENSE' " +
					 "GROUP BY c.name";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				stats.put(rs.getString("name"), rs.getDouble("total"));
			}
		} catch (Exception e) { e.printStackTrace(); }
		return stats;
	}
}