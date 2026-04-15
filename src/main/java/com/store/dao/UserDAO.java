package com.store.dao;

import com.store.model.User;
import com.store.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    // Hàm kiểm tra đăng nhập
    public User checkLogin(String username, String password) {
        // Dấu ? là tham số bảo mật giúp chống lỗi SQL Injection
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            // Truyền giá trị vào các dấu ?
            ps.setString(1, username);
            ps.setString(2, password);
            
            // Thực thi câu lệnh
            ResultSet rs = ps.executeQuery();
            
            // Nếu có kết quả trả về (đăng nhập đúng)
            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Trả về null nếu sai tài khoản hoặc mật khẩu
        return null; 
    }
}