package data.dao;

import java.sql.SQLException;
import java.util.List;
import model.OrderItem;

/**
 * OrderItemDao - Interface cho việc thao tác với bảng order_items
 * @author Duy Khánh
 */
public interface OrderItemDao {
    
    /**
     * Thêm item mới vào đơn hàng
     */
    boolean insert(OrderItem orderItem) throws SQLException;
    
    /**
     * Cập nhật item
     */
    boolean update(OrderItem orderItem) throws SQLException;
    
    /**
     * Xóa item
     */
    boolean delete(int orderItemId) throws SQLException;
    
    /**
     * Tìm item theo ID
     */
    OrderItem findById(int orderItemId) throws SQLException;
    
    /**
     * Lấy tất cả items của một đơn hàng
     */
    List<OrderItem> findByOrderId(int orderId) throws SQLException;
    
    /**
     * Lấy tất cả items
     */
    List<OrderItem> findAll() throws SQLException;
    
    /**
     * Xóa tất cả items của một đơn hàng
     */
    boolean deleteByOrderId(int orderId) throws SQLException;
    
    /**
     * Đếm số items của một đơn hàng
     */
    int countByOrderId(int orderId) throws SQLException;
}
