package data.impl;

import data.dao.OrderItemDao;
import data.driver.MySQLDriver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.OrderItem;
import model.Product;
import model.Categories;

/**
 * OrderItemImpl - Implementation của OrderItemDao
 * @author Duy Khánh
 */
public class OrderItemImpl implements OrderItemDao {
    
    @Override
    public boolean insert(OrderItem orderItem) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getProductId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setBigDecimal(4, orderItem.getPrice());
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderItem.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        }
        return false;
    }
    
    @Override
    public boolean update(OrderItem orderItem) throws SQLException {
        String sql = "UPDATE order_items SET order_id = ?, product_id = ?, quantity = ?, price = ? WHERE id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getProductId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setBigDecimal(4, orderItem.getPrice());
            ps.setInt(5, orderItem.getId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    @Override
    public boolean delete(int orderItemId) throws SQLException {
        String sql = "DELETE FROM order_items WHERE id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderItemId);
            return ps.executeUpdate() > 0;
        }
    }
    
    @Override
    public OrderItem findById(int orderItemId) throws SQLException {
        String sql = "SELECT * FROM order_items WHERE id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderItemId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToOrderItem(rs);
                }
            }
        }
        return null;
    }
    
    @Override
    public List<OrderItem> findByOrderId(int orderId) throws SQLException {
        String sql = "SELECT oi.*, p.name as product_name, p.description, p.image, p.year, p.engine, p.horsepower, p.torque, p.top_speed, " +
                     "c.id as category_id, c.name as category_name " +
                     "FROM order_items oi " +
                     "JOIN products p ON oi.product_id = p.id " +
                     "LEFT JOIN categories c ON p.category_id = c.id " +
                     "WHERE oi.order_id = ?";
        List<OrderItem> orderItems = new ArrayList<>();
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem orderItem = mapResultSetToOrderItem(rs);
                    
                    // Tạo Product object với thông tin đầy đủ
                    Product product = new Product();
                    product.setId(rs.getInt("product_id"));
                    product.setName(rs.getString("product_name"));
                    product.setDescription(rs.getString("description"));
                    product.setImage(rs.getString("image"));
                    product.setYear(rs.getInt("year"));
                    product.setEngine(rs.getString("engine"));
                    product.setHorsepower(rs.getInt("horsepower"));
                    product.setTorque(rs.getInt("torque"));
                    product.setTopSpeed(rs.getInt("top_speed"));
                    
                    // Tạo Categories object
                    Categories category = new Categories();
                    category.setId(rs.getInt("category_id"));
                    category.setName(rs.getString("category_name"));
                    product.setCategory(category);
                    
                    orderItem.setProduct(product);
                    orderItems.add(orderItem);
                }
            }
        }
        
        return orderItems;
    }
    
    @Override
    public List<OrderItem> findAll() throws SQLException {
        String sql = "SELECT * FROM order_items";
        List<OrderItem> orderItems = new ArrayList<>();
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                orderItems.add(mapResultSetToOrderItem(rs));
            }
        }
        return orderItems;
    }
    
    @Override
    public boolean deleteByOrderId(int orderId) throws SQLException {
        String sql = "DELETE FROM order_items WHERE order_id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        }
    }
    
    @Override
    public int countByOrderId(int orderId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM order_items WHERE order_id = ?";
        
        try (Connection conn = MySQLDriver.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    private OrderItem mapResultSetToOrderItem(ResultSet rs) throws SQLException {
        OrderItem orderItem = new OrderItem();
        orderItem.setId(rs.getInt("id"));
        orderItem.setOrderId(rs.getInt("order_id"));
        orderItem.setProductId(rs.getInt("product_id"));
        orderItem.setQuantity(rs.getInt("quantity"));
        orderItem.setPrice(rs.getBigDecimal("price"));
        
        return orderItem;
    }
}
