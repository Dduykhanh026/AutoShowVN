package data.impl;

import data.dao.CategoriesDao;
import data.driver.MySQLDriver;
import model.Categories;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriesImpl implements CategoriesDao {
    
    @Override
    public List<Categories> getAllCategories() {
        List<Categories> categories = new ArrayList<>();
        String sql = "SELECT id, name, description FROM categories ORDER BY id";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Categories category = new Categories();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all categories: " + e.getMessage());
        }
        
        return categories;
    }
    
    @Override
    public Categories getCategoryById(int id) {
        String sql = "SELECT id, name, description FROM categories WHERE id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Categories category = new Categories();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                    category.setDescription(rs.getString("description"));
                    return category;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting category by ID " + id + ": " + e.getMessage());
        }
        
        return null;
    }
    
    @Override
    public Categories getCategoryByName(String name) {
        String sql = "SELECT id, name, description FROM categories WHERE name = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Categories category = new Categories();
                    category.setId(rs.getInt("id"));
                    category.setName(rs.getString("name"));
                    category.setDescription(rs.getString("description"));
                    return category;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting category by name " + name + ": " + e.getMessage());
        }
        
        return null;
    }
    
    @Override
    public boolean addCategory(Categories category) {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding category: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean updateCategory(Categories category) {
        String sql = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getId());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating category: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean deleteCategory(int id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting category " + id + ": " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean categoryExists(int id) {
        String sql = "SELECT COUNT(*) FROM categories WHERE id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking if category exists: " + e.getMessage());
        }
        
        return false;
    }
    
    @Override
    public boolean categoryNameExists(String name) {
        String sql = "SELECT COUNT(*) FROM categories WHERE name = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking if category name exists: " + e.getMessage());
        }
        
        return false;
    }
}
