package com.store.dao;

import com.store.model.Category;
import com.store.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	// Hàm lấy danh sách danh mục theo loại (INCOME hoặc EXPENSE)
	public List<Category> getCategoriesByType(String type) {
		List<Category> list = new ArrayList<>();
		String sql = "SELECT * FROM categories WHERE type = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, type);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("type")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Hàm lấy TẤT CẢ danh mục
	public List<Category> getAllCategories() {
		List<Category> list = new ArrayList<>();
		String sql = "SELECT * FROM categories";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(new Category(rs.getInt("id"), rs.getString("name"), rs.getString("type")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}