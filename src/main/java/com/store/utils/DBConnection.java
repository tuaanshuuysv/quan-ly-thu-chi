package com.store.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static String getDbHost() {
        String host = System.getenv("DB_HOST");
        return (host != null) ? host : "localhost";
    }
	private static final String URL = "jdbc:mysql://" + getDbHost() + ":3306/quanly_thuchi";
    private static final String USER = "root";
    private static final String PASSWORD = "huy2406"; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Tạo kết nối
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Kết nối CSDL thành công!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Kết nối CSDL thất bại: " + e.getMessage());
        }
        return conn;
    }
}