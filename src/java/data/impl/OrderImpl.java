package data.impl;

import data.dao.OrderDao;
import data.dao.OrderItemDao;
import data.impl.OrderItemImpl;
import data.driver.MySQLDriver;
import data.utils.OrderStatus;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderItem;
import model.User;

/**
 * OrderImpl - Implementation của OrderDao
 * @author Duy Khánh
 */
public class OrderImpl implements OrderDao {
    
    @Override
    public boolean insert(Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, order_date, status, total_amount, note) VALUES (?, ?, ?, ?, ?)";
        
        // ✅ THÊM: Validation và logging cho status
        String status = order.getStatus();
        System.out.println("🔍 DEBUG insert - Status to insert: '" + status + "' (length: " + (status != null ? status.length() : 0) + ")");
        
        // Validate status length và sử dụng OrderStatus utility
        if (status != null && status.length() > OrderStatus.MAX_STATUS_LENGTH) {
            System.err.println("❌ ERROR: Status too long: " + status.length() + " characters. Max allowed: " + OrderStatus.MAX_STATUS_LENGTH);
            throw new SQLException("Status too long: " + status.length() + " characters. Max allowed: " + OrderStatus.MAX_STATUS_LENGTH);
        }
        
        // Validate status value
        if (!OrderStatus.isValidStatus(status)) {
            System.err.println("❌ ERROR: Invalid status: '" + status + "'. Valid values: " + String.join(", ", OrderStatus.getAllValidStatuses()));
            throw new SQLException("Invalid status: '" + status + "'. Valid values: " + String.join(", ", OrderStatus.getAllValidStatuses()));
        }
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, Timestamp.valueOf(order.getOrderDate()));
            ps.setString(3, status);
            ps.setBigDecimal(4, order.getTotalAmount());
            ps.setString(5, order.getNote());
            
            System.out.println("🔍 DEBUG insert - Executing INSERT with status: '" + status + "'");
            
            int affectedRows = ps.executeUpdate();
            System.out.println("🔍 DEBUG insert - Rows affected: " + affectedRows);
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        order.setId(rs.getInt(1));
                        System.out.println("✅ DEBUG insert - Order created successfully with ID: " + order.getId());
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            System.err.println("❌ SQLException in insert: " + e.getMessage());
            System.err.println("❌ SQL State: " + e.getSQLState());
            System.err.println("❌ Error Code: " + e.getErrorCode());
            e.printStackTrace();
            throw e;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
    }
    
    @Override
    public boolean update(Order order) throws SQLException {
        String sql = "UPDATE orders SET user_id = ?, order_date = ?, status = ?, total_amount = ?, note = ? WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, Timestamp.valueOf(order.getOrderDate()));
            ps.setString(3, order.getStatus());
            ps.setBigDecimal(4, order.getTotalAmount());
            ps.setString(5, order.getNote());
            ps.setInt(6, order.getId());
            
            return ps.executeUpdate() > 0;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
    }
    
    @Override
    public boolean delete(int orderId) throws SQLException {
        String sql = "DELETE FROM orders WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
    }
    
    @Override
    public Order findById(int orderId) throws SQLException {
        String sql = "SELECT o.*, u.full_name, u.email, u.phone " +
                     "FROM orders o " +
                     "LEFT JOIN users u ON o.user_id = u.id " +
                     "WHERE o.id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, orderId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    
                    // Tạo user object với thông tin từ JOIN
                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    
                    order.setUser(user);
                    return order;
                }
            }
            return null;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
    }
    
    @Override
    public List<Order> findByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    
                    // Load order items for the current order
                    OrderItemDao orderItemDao = new OrderItemImpl();
                    List<OrderItem> orderItems = orderItemDao.findByOrderId(order.getId());
                    order.setOrderItems(orderItems);
                    
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ SQLException in findByUserId: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        
        return orders;
    }
    
    @Override
    public List<Order> findAll() throws SQLException {
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                
                // Load order items for the current order
                OrderItemDao orderItemDao = new OrderItemImpl();
                order.setOrderItems(orderItemDao.findByOrderId(order.getId()));
                
                orders.add(order);
            }
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        return orders;
    }
    
    @Override
    public boolean updateStatus(int orderId, String newStatus) throws SQLException {
        // ✅ THÊM: Log để debug
        System.out.println("🔄 OrderImpl.updateStatus called with: " + newStatus);
        
        // ✅ THÊM: Validation cho status sử dụng OrderStatus utility
        if (newStatus == null || newStatus.trim().isEmpty()) {
            System.err.println("❌ ERROR: Status cannot be null or empty");
            throw new SQLException("Status cannot be null or empty");
        }
        
        if (newStatus.length() > OrderStatus.MAX_STATUS_LENGTH) {
            System.err.println("❌ ERROR: Status too long: " + newStatus.length() + " characters. Max allowed: " + OrderStatus.MAX_STATUS_LENGTH);
            throw new SQLException("Status too long: " + newStatus.length() + " characters. Max allowed: " + OrderStatus.MAX_STATUS_LENGTH);
        }
        
        // Validate status values sử dụng OrderStatus utility
        if (!OrderStatus.isValidStatus(newStatus)) {
            System.err.println("❌ ERROR: Invalid status: '" + newStatus + "'. Valid values: " + String.join(", ", OrderStatus.getAllValidStatuses()));
            throw new SQLException("Invalid status: '" + newStatus + "'. Valid values: " + String.join(", ", OrderStatus.getAllValidStatuses()));
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            System.out.println("🔍 DEBUG updateStatus - Starting...");
            System.out.println("🔍 DEBUG updateStatus - Order ID: " + orderId);
            System.out.println("🔍 DEBUG updateStatus - New Status: '" + newStatus + "' (length: " + newStatus.length() + ")");
            
            conn = MySQLDriver.getConnection();
            System.out.println("🔍 DEBUG updateStatus - Database connection established");
            
            conn.setAutoCommit(false); // Disable auto-commit
            System.out.println("🔍 DEBUG updateStatus - Auto-commit disabled");
            
            // Update status
            String sql = "UPDATE orders SET status = ? WHERE id = ?";
            System.out.println("🔍 DEBUG updateStatus - SQL: " + sql);
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newStatus);
            pstmt.setInt(2, orderId);
            System.out.println("🔍 DEBUG updateStatus - Parameters set: status='" + newStatus + "', id=" + orderId);
            
            System.out.println("🔍 DEBUG updateStatus - Executing UPDATE...");
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("🔍 DEBUG updateStatus - Rows affected: " + rowsAffected);
            
            if (rowsAffected > 0) {
                System.out.println("🔍 DEBUG updateStatus - Update successful, committing transaction...");
                conn.commit();
                System.out.println("✅ Transaction committed successfully");
                
                // Verification sau khi commit
                System.out.println("🔍 DEBUG updateStatus - Verifying update...");
                String verifySql = "SELECT status FROM orders WHERE id = ?";
                PreparedStatement verifyStmt = conn.prepareStatement(verifySql);
                verifyStmt.setInt(1, orderId);
                ResultSet rs = verifyStmt.executeQuery();
                
                if (rs.next()) {
                    String actualStatus = rs.getString("status");
                    System.out.println("🔍 DEBUG updateStatus - Actual status in DB: '" + actualStatus + "'");
                    System.out.println("🔍 DEBUG updateStatus - Expected status: '" + newStatus + "'");
                    
                    if (newStatus.equals(actualStatus)) {
                        System.out.println("✅ Status updated successfully: " + newStatus);
                        rs.close();
                        verifyStmt.close();
                        return true;
                    } else {
                        System.out.println("❌ Status verification failed");
                        rs.close();
                        verifyStmt.close();
                        return false;
                    }
                } else {
                    System.out.println("❌ No rows found during verification");
                    rs.close();
                    verifyStmt.close();
                    return false;
                }
            } else {
                // Rollback nếu không có rows nào được update
                System.out.println("❌ No rows affected, rolling back");
                conn.rollback();
                return false;
            }
            
        } catch (SQLException e) {
            System.err.println("❌ SQLException in updateStatus: " + e.getMessage());
            System.err.println("❌ SQL State: " + e.getSQLState());
            System.err.println("❌ Error Code: " + e.getErrorCode());
            e.printStackTrace();
            
            // Rollback nếu có lỗi
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("Error occurred, rolling back transaction");
                } catch (SQLException rollbackEx) {
                    System.err.println("Rollback failed: " + rollbackEx.getMessage());
                }
            }
            throw e;
        } catch (Exception e) {
            System.err.println("❌ Unexpected Exception in updateStatus: " + e.getMessage());
            e.printStackTrace();
            
            // Rollback nếu có lỗi
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("Error occurred, rolling back transaction");
                } catch (SQLException rollbackEx) {
                    System.err.println("Rollback failed: " + rollbackEx.getMessage());
                }
            }
            throw new SQLException("Unexpected error: " + e.getMessage(), e);
        } finally {
            // Close resources
            if (pstmt != null) {
                try {
                    pstmt.close();
                    System.out.println("🔍 DEBUG updateStatus - PreparedStatement closed");
                } catch (SQLException e) {
                    System.err.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Re-enable auto-commit
                    conn.close();
                    System.out.println("🔍 DEBUG updateStatus - Connection closed");
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
    }
    
    @Override
    public List<Order> findByStatus(String status) throws SQLException {
        String sql = "SELECT * FROM orders WHERE status = ? ORDER BY order_date DESC";
        List<Order> orders = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, status);
            
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                
                // Load order items for the current order
                OrderItemDao orderItemDao = new OrderItemImpl();
                order.setOrderItems(orderItemDao.findByOrderId(order.getId()));
                
                orders.add(order);
            }
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        return orders;
    }
    
    @Override
    public int countByUserId(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE user_id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setInt(1, userId);
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0; // Return 0 if no results
        } finally {
            // ✅ SỬA: Đóng ResultSet trước
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            
            // ✅ SỬA: Đóng PreparedStatement
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            
            // ✅ SỬA: Return connection to pool
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
    }
    
    @Override
    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        return 0;
    }
    
    @Override
    public List<Order> findWithFilters(String status, String dateFrom, String dateTo, String search, int pageSize, int offset) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.*, u.full_name, u.email, u.phone FROM orders o ");
        sql.append("LEFT JOIN users u ON o.user_id = u.id WHERE 1=1");
        
        List<Object> params = new ArrayList<>();
        
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND o.status = ?");
            params.add(status);
        }
        
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND DATE(o.order_date) >= ?");
            params.add(dateFrom);
        }
        
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND DATE(o.order_date) <= ?");
            params.add(dateTo);
        }
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        sql.append(" ORDER BY o.order_date DESC");
        if (pageSize > 0) {
            sql.append(" LIMIT ?");
            params.add(pageSize);
            if (offset > 0) {
                sql.append(" OFFSET ?");
                params.add(offset);
            }
        }
        
        // Debug logging
        System.out.println("=== DEBUG OrderImpl.findWithFilters ===");
        System.out.println("Input parameters:");
        System.out.println("  Status: " + status);
        System.out.println("  DateFrom: " + dateFrom);
        System.out.println("  DateTo: " + dateTo);
        System.out.println("  Search: " + search);
        System.out.println("  PageSize: " + pageSize);
        System.out.println("  Offset: " + offset);
        System.out.println("SQL: " + sql.toString());
        System.out.println("Params: " + params);
        
        List<Order> orders = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            System.out.println("✅ Database connection successful");
            
            // Test query để kiểm tra bảng orders có dữ liệu không
            try (var testStmt = conn.createStatement();
                 var testRs = testStmt.executeQuery("SELECT COUNT(*) as total FROM orders")) {
                if (testRs.next()) {
                    int totalOrders = testRs.getInt("total");
                    System.out.println("📊 Total orders in database: " + totalOrders);
                    
                    if (totalOrders == 0) {
                        System.out.println("⚠️ WARNING: Bảng orders không có dữ liệu!");
                        return orders;
                    }
                }
            }
            
            // Test query để kiểm tra bảng users có dữ liệu không
            try (var testStmt = conn.createStatement();
                 var testRs = testStmt.executeQuery("SELECT COUNT(*) as total FROM users")) {
                if (testRs.next()) {
                    int totalUsers = testRs.getInt("total");
                    System.out.println("👥 Total users in database: " + totalUsers);
                }
            }
            
            // Test JOIN query để kiểm tra có dữ liệu không
            try (var testStmt = conn.createStatement();
                 var testRs = testStmt.executeQuery("SELECT o.*, u.full_name, u.email, u.phone FROM orders o LEFT JOIN users u ON o.user_id = u.id LIMIT 1")) {
                if (testRs.next()) {
                    System.out.println("✅ JOIN query test successful - Found data");
                    System.out.println("   Order ID: " + testRs.getInt("id"));
                    System.out.println("   User ID: " + testRs.getInt("user_id"));
                    System.out.println("   Status: " + testRs.getString("status"));
                    System.out.println("   User Name: " + testRs.getString("full_name"));
                    System.out.println("   JOIN thành công! ✅");
                } else {
                    System.out.println("⚠️ WARNING: JOIN query test returned no data!");
                }
            } catch (Exception e) {
                System.err.println("❌ JOIN query test failed: " + e.getMessage());
                e.printStackTrace();
            }
            
            ps = conn.prepareStatement(sql.toString());
            System.out.println("✅ PreparedStatement created successfully");
            
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                System.out.println("   Setting Param " + (i+1) + ": " + param + " (type: " + (param != null ? param.getClass().getSimpleName() : "NULL") + ")");
                ps.setObject(i + 1, param);
            }
            
            rs = ps.executeQuery();
            System.out.println("✅ Query executed successfully");
            int rowCount = 0;
            
            while (rs.next()) {
                try {
                    rowCount++;
                    
                    // Debug: In ra tất cả columns để kiểm tra
                    System.out.println("🔍 Row " + rowCount + " data:");
                    System.out.println("   Order ID: " + rs.getInt("id"));
                    System.out.println("   User ID: " + rs.getInt("user_id"));
                    System.out.println("   Status: " + rs.getString("status"));
                    System.out.println("   Full Name: " + rs.getString("full_name"));
                    System.out.println("   Email: " + rs.getString("email"));
                    System.out.println("   Phone: " + rs.getString("phone"));
                    
                    Order order = mapResultSetToOrder(rs);
                    System.out.println("✅ Order mapped successfully: " + order.getId());
                    
                    // Tạo user object với thông tin cơ bản (xử lý NULL)
                    User user = new User();
                    user.setId(rs.getInt("user_id")); // user_id từ bảng orders
                    
                    String fullName = rs.getString("full_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    
                    user.setFullName(fullName != null ? fullName : "Khách hàng không xác định");
                    user.setEmail(email != null ? email : "N/A");
                    user.setPhone(phone != null ? phone : "N/A");
                    order.setUser(user);
                    
                    System.out.println("✅ User mapped successfully: " + user.getFullName());
                    System.out.println("   User details - ID: " + user.getId() + ", Email: " + user.getEmail() + ", Phone: " + user.getPhone());

                    // Tạm thời bỏ qua order items để tập trung vào JOIN query
                    order.setOrderItems(new ArrayList<>()); // Set empty list
                    
                    System.out.println("📦 Order " + rowCount + ": ID=" + order.getId() + 
                                     ", User=" + user.getFullName() + 
                                     ", Status=" + order.getStatus());
                    
                    orders.add(order);
                    System.out.println("✅ Order added to list. Total orders so far: " + orders.size());
                    
                } catch (Exception e) {
                    System.err.println("❌ Error processing row " + rowCount + ": " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            System.out.println("📊 Total rows returned: " + rowCount);
        } catch (SQLException e) {
            System.err.println("❌ SQL Error in findWithFilters: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } catch (Exception e) {
            System.err.println("❌ General Error in findWithFilters: " + e.getMessage());
            e.printStackTrace();
            throw new SQLException("Error loading orders: " + e.getMessage(), e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        
        System.out.println("📊 Final orders list size: " + orders.size());
        System.out.println("=== END DEBUG ===");
        
        return orders;
    }
    
    // Method để test đơn giản
    public List<Order> findAllWithJoin() throws SQLException {
        String sql = "SELECT o.id, o.user_id, o.order_date, o.status, o.total_amount, o.note, " +
                    "u.full_name, u.email, u.phone " +
                    "FROM orders o LEFT JOIN users u ON o.user_id = u.id " +
                    "ORDER BY o.order_date DESC";
        
        List<Order> orders = new ArrayList<>();
        
        System.out.println("=== SIMPLE TEST: findAllWithJoin ===");
        System.out.println("SQL: " + sql);
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            System.out.println("✅ Query executed successfully");
            int count = 0;
            
            while (rs.next()) {
                count++;
                System.out.println("🔍 Row " + count + ":");
                System.out.println("   Order ID: " + rs.getInt("id"));
                System.out.println("   User ID: " + rs.getInt("user_id"));
                System.out.println("   Status: " + rs.getString("status"));
                System.out.println("   Full Name: " + rs.getString("full_name"));
                
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                
                Timestamp timestamp = rs.getTimestamp("order_date");
                if (timestamp != null) {
                    order.setOrderDate(timestamp.toLocalDateTime());
                }
                
                order.setStatus(rs.getString("status"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setNote(rs.getString("note"));
                
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                order.setUser(user);
                
                orders.add(order);
            }
            
            System.out.println("📊 Total orders found: " + orders.size());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        
        System.out.println("=== END SIMPLE TEST ===");
        return orders;
    }
    
    @Override
    public int countWithFilters(String status, String dateFrom, String dateTo, String search) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM orders o ");
        sql.append("LEFT JOIN users u ON o.user_id = u.id WHERE 1=1");
        
        List<Object> params = new ArrayList<>();
        
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND o.status = ?");
            params.add(status);
        }
        
        if (dateFrom != null && !dateFrom.trim().isEmpty()) {
            sql.append(" AND DATE(o.order_date) >= ?");
            params.add(dateFrom);
        }
        
        if (dateTo != null && !dateTo.trim().isEmpty()) {
            sql.append(" AND DATE(o.order_date) <= ?");
            params.add(dateTo);
        }
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?)");
            String searchPattern = "%" + search + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql.toString());
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            // ✅ SỬA: Không sử dụng try-with-resources cho ResultSet
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            // ✅ SỬA: Đóng ResultSet trước
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        return 0;
    }
    
    @Override
    public int countByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, status);
            
            // ✅ SỬA: Không sử dụng try-with-resources cho ResultSet
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            // ✅ SỬA: Đóng ResultSet trước
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
        return 0;
    }
    
    // Test method để kiểm tra trạng thái đơn hàng
    public String getOrderStatus(int orderId) throws SQLException {
        String sql = "SELECT status FROM orders WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
            return null;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
    }
    
        // Test method để kiểm tra xem đơn hàng có tồn tại không
    public boolean orderExists(int orderId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = MySQLDriver.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing ResultSet: " + e.getMessage());
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    System.err.println("❌ Error closing PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                MySQLDriver.returnConnection(conn);
            }
        }
    }
    
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        
        Timestamp timestamp = rs.getTimestamp("order_date");
        if (timestamp != null) {
            order.setOrderDate(timestamp.toLocalDateTime());
        }
        
        order.setStatus(rs.getString("status"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setNote(rs.getString("note"));
        
        return order;
    }

    // ✅ THÊM: Method kiểm tra status hợp lệ sử dụng OrderStatus utility
    private boolean isValidStatus(String status) {
        return OrderStatus.isValidStatus(status);
    }
}
