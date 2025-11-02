package data.impl;

import data.dao.ProductDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.math.BigDecimal;

public class ProductImpl implements ProductDao {

    public static Connection con;

    @Override
    public List<Product> findAll() {
        List<Product> listProduct = new ArrayList<>();
        String sql = "SELECT * FROM products";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listProduct;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int categoryId = rs.getInt("category_id");
                String name = rs.getString("name");
                BigDecimal price = rs.getBigDecimal("price");
                int year = rs.getInt("year");
                String engine = rs.getString("engine");
                int horsepower = rs.getInt("horsepower");
                int torque = rs.getInt("torque");
                int topSpeed = rs.getInt("top_speed");
                String image = rs.getString("image");
                String description = rs.getString("description");

                listProduct.add(new Product(id, categoryId, name, price, year, engine, 
                        horsepower, torque, topSpeed, image, description));
            }
            System.out.println("Found " + listProduct.size() + " products");
        } catch (SQLException ex) {
            System.err.println("SQL Error in findAll(): " + ex.getMessage());
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listProduct;
    }

    @Override
    public boolean insert(Product product) {
        String sql = "INSERT INTO products (category_id, name, price, year, engine, horsepower, torque, top_speed, image, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, product.getCategoryId());
            sttm.setString(2, product.getName());
            sttm.setBigDecimal(3, product.getPrice());
            sttm.setInt(4, product.getYear());
            sttm.setString(5, product.getEngine());
            sttm.setInt(6, product.getHorsepower());
            sttm.setInt(7, product.getTorque());
            sttm.setInt(8, product.getTopSpeed());
            sttm.setString(9, product.getImage());
            sttm.setString(10, product.getDescription());
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in insert(): " + ex.getMessage());
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean delete(String maxe) {
        // Chuyển đổi maxe thành id nếu cần
        try {
            int id = Integer.parseInt(maxe);
            return delete(id);
        } catch (NumberFormatException e) {
            System.err.println("Invalid ID format: " + maxe);
            return false;
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, id);
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in delete(): " + ex.getMessage());
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean update(String maxe) {
        // Phương thức này cần được cập nhật để nhận Product object
        throw new UnsupportedOperationException("Use update(Product product) instead");
    }

    public boolean update(Product product) {
        String sql = "UPDATE products SET category_id=?, name=?, price=?, year=?, engine=?, horsepower=?, torque=?, top_speed=?, image=?, description=? WHERE id=?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, product.getCategoryId());
            sttm.setString(2, product.getName());
            sttm.setBigDecimal(3, product.getPrice());
            sttm.setInt(4, product.getYear());
            sttm.setString(5, product.getEngine());
            sttm.setInt(6, product.getHorsepower());
            sttm.setInt(7, product.getTorque());
            sttm.setInt(8, product.getTopSpeed());
            sttm.setString(9, product.getImage());
            sttm.setString(10, product.getDescription());
            sttm.setInt(11, product.getId());
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in update(): " + ex.getMessage());
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public Product find(String maxe) {
        try {
            int id = Integer.parseInt(maxe);
            return find(id);
        } catch (NumberFormatException e) {
            System.err.println("Invalid ID format: " + maxe);
            return null;
        }
    }

    public Product find(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return null;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, id);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int categoryId = rs.getInt("category_id");
                String name = rs.getString("name");
                BigDecimal price = rs.getBigDecimal("price");
                int year = rs.getInt("year");
                String engine = rs.getString("engine");
                int horsepower = rs.getInt("horsepower");
                int torque = rs.getInt("torque");
                int topSpeed = rs.getInt("top_speed");
                String image = rs.getString("image");
                String description = rs.getString("description");

                return new Product(id, categoryId, name, price, year, engine, 
                        horsepower, torque, topSpeed, image, description);
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in find(): " + ex.getMessage());
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    @Override
    public List<Product> search(String keyword) {
        List<Product> searchResults = new ArrayList<>();
        
        // Kiểm tra keyword
        if (keyword == null || keyword.trim().isEmpty()) {
            System.out.println("ProductImpl.search() called with empty keyword, returning empty results");
            return searchResults;
        }
        
        String sql = "SELECT * FROM products WHERE LOWER(name) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?) OR LOWER(engine) LIKE LOWER(?)";
        
        System.out.println("ProductImpl.search() called with keyword: " + keyword);
        System.out.println("SQL query: " + sql);
        
        Connection connection = null;
        PreparedStatement sttm = null;
        ResultSet rs = null;
        
        try {
            connection = MySQLDriver.getConnection();
            if (connection == null) {
                System.err.println("Database connection is null!");
                return searchResults;
            }
            
            // Kiểm tra connection có hợp lệ không
            if (connection.isClosed()) {
                System.err.println("Database connection is closed!");
                return searchResults;
            }
            
            sttm = connection.prepareStatement(sql);
            String searchPattern = "%" + keyword.trim() + "%";
            
            System.out.println("Setting search pattern: " + searchPattern);
            
            // Set parameters với kiểm tra null
            sttm.setString(1, searchPattern);
            sttm.setString(2, searchPattern);
            sttm.setString(3, searchPattern);
            
            System.out.println("Executing query...");
            rs = sttm.executeQuery();
            
            while (rs.next()) {
                try {
                    int id = rs.getInt("id");
                    int categoryId = rs.getInt("category_id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price");
                    int year = rs.getInt("year");
                    String engine = rs.getString("engine");
                    int horsepower = rs.getInt("horsepower");
                    int torque = rs.getInt("torque");
                    int topSpeed = rs.getInt("top_speed");
                    String image = rs.getString("image");
                    String description = rs.getString("description");

                    Product product = new Product(id, categoryId, name, price, year, engine, 
                            horsepower, torque, topSpeed, image, description);
                    searchResults.add(product);
                    
                    System.out.println("Found product: " + name + " (ID: " + id + ")");
                } catch (Exception e) {
                    System.err.println("Error processing result row: " + e.getMessage());
                    continue; // Bỏ qua row lỗi và tiếp tục
                }
            }
            
            System.out.println("Search for '" + keyword + "' returned " + searchResults.size() + " results");
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in search(): " + ex.getMessage());
            System.err.println("SQL State: " + ex.getSQLState());
            System.err.println("Error Code: " + ex.getErrorCode());
            ex.printStackTrace();
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, "SQL Error in search method", ex);
        } catch (Exception ex) {
            System.err.println("Unexpected error in search(): " + ex.getMessage());
            ex.printStackTrace();
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, "Unexpected error in search method", ex);
        } finally {
            // Đóng resources theo thứ tự ngược lại
            try {
                if (rs != null) rs.close();
                if (sttm != null) sttm.close();
                if (connection != null) {
                    MySQLDriver.returnConnection(connection);
                }
            } catch (SQLException ex) {
                System.err.println("Error closing resources: " + ex.getMessage());
            }
        }
        
        return searchResults;
    }
    
    /**
     * Tìm kiếm sản phẩm theo category
     */
    public List<Product> searchByCategory(String categoryKeyword) {
        List<Product> searchResults = new ArrayList<>();
        
        if (categoryKeyword == null || categoryKeyword.trim().isEmpty()) {
            return searchResults;
        }
        
        String sql = "SELECT p.* FROM products p " +
                    "JOIN categories c ON p.category_id = c.id " +
                    "WHERE LOWER(c.name) LIKE LOWER(?)";
        
        Connection connection = null;
        PreparedStatement sttm = null;
        ResultSet rs = null;
        
        try {
            connection = MySQLDriver.getConnection();
            if (connection == null) {
                System.err.println("Database connection is null!");
                return searchResults;
            }
            
            sttm = connection.prepareStatement(sql);
            String searchPattern = "%" + categoryKeyword.trim() + "%";
            sttm.setString(1, searchPattern);
            
            rs = sttm.executeQuery();
            
            while (rs.next()) {
                try {
                    int id = rs.getInt("id");
                    int categoryId = rs.getInt("category_id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price");
                    int year = rs.getInt("year");
                    String engine = rs.getString("engine");
                    int horsepower = rs.getInt("horsepower");
                    int torque = rs.getInt("torque");
                    int topSpeed = rs.getInt("top_speed");
                    String image = rs.getString("image");
                    String description = rs.getString("description");

                    Product product = new Product(id, categoryId, name, price, year, engine, 
                            horsepower, torque, topSpeed, image, description);
                    searchResults.add(product);
                    
                    System.out.println("Found product by category: " + name + " (Category: " + categoryKeyword + ")");
                } catch (Exception e) {
                    System.err.println("Error processing result row: " + e.getMessage());
                    continue;
                }
            }
            
        } catch (SQLException ex) {
            System.err.println("SQL Error in searchByCategory(): " + ex.getMessage());
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, "SQL Error in searchByCategory method", ex);
        } finally {
            try {
                if (rs != null) rs.close();
                if (sttm != null) sttm.close();
                if (connection != null) {
                    MySQLDriver.returnConnection(connection);
                }
            } catch (SQLException ex) {
                System.err.println("Error closing resources: " + ex.getMessage());
            }
        }
        
        return searchResults;
    }
}
