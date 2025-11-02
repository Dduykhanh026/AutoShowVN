package data.dao;

import java.sql.SQLException;
import java.util.List;
import model.Order;

/**
 * OrderDao - Interface cho việc thao tác với bảng orders
 * @author Duy Khánh
 */
public interface OrderDao {
    
    /**
     * Thêm đơn hàng mới
     */
    boolean insert(Order order) throws SQLException;
    
    /**
     * Cập nhật đơn hàng
     */
    boolean update(Order order) throws SQLException;
    
    /**
     * Xóa đơn hàng
     */
    boolean delete(int orderId) throws SQLException;
    
    /**
     * Tìm đơn hàng theo ID
     */
    Order findById(int orderId) throws SQLException;
    
    /**
     * Lấy tất cả đơn hàng của người dùng
     */
    List<Order> findByUserId(int userId) throws SQLException;
    
    /**
     * Lấy tất cả đơn hàng
     */
    List<Order> findAll() throws SQLException;
    
    /**
     * Cập nhật trạng thái đơn hàng
     */
    boolean updateStatus(int orderId, String status) throws SQLException;
    
    /**
     * Lấy đơn hàng theo trạng thái
     */
    List<Order> findByStatus(String status) throws SQLException;
    
    /**
     * Đếm số đơn hàng của người dùng
     */
    int countByUserId(int userId) throws SQLException;
    
    /**
     * Đếm tổng số đơn hàng
     */
    int countAll() throws SQLException;
    
    /**
     * Tìm đơn hàng với bộ lọc và phân trang
     */
    List<Order> findWithFilters(String status, String dateFrom, String dateTo, String search, int pageSize, int offset) throws SQLException;
    
    /**
     * Đếm số đơn hàng với bộ lọc
     */
    int countWithFilters(String status, String dateFrom, String dateTo, String search) throws SQLException;
    
    /**
     * Đếm số đơn hàng theo trạng thái
     */
    int countByStatus(String status) throws SQLException;
    
    // Test method để kiểm tra trạng thái đơn hàng
    String getOrderStatus(int orderId) throws SQLException;
    
    // Test method để kiểm tra xem đơn hàng có tồn tại không
    boolean orderExists(int orderId) throws SQLException;
}
