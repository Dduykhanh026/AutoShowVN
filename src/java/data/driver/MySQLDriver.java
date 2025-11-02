package data.driver;

import data.utils.Constants;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.ConcurrentLinkedQueue;

public class MySQLDriver {
    private static final ConcurrentLinkedQueue<Connection> connectionPool = new ConcurrentLinkedQueue<>();
    private static final int MAX_POOL_SIZE = 10;
    
    static {
        try {
            // Load driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    // ✅ SỬA: Tạo connection mới mỗi lần cần thiết
    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(Constants.DB_URL, Constants.USER, Constants.PASS);
            // Set transaction isolation level
            conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
            return conn;
        } catch (SQLException e) {
            throw e;
        }
    }
    
    public static void returnConnection(Connection connection) {
        if (connection != null && connectionPool.size() < MAX_POOL_SIZE) {
            try {
                if (!connection.isClosed()) {
                    // Reset connection state
                    connection.setAutoCommit(true);
                    connectionPool.offer(connection);
                }
                    } catch (SQLException e) {
            closeConnection(connection);
        }
        } else {
            closeConnection(connection);
        }
    }
    
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    System.out.println(" Connection closed");
                }
                    } catch (SQLException e) {
            // Handle silently
        }
        }
    }
    
    public static void closeAllConnections() {
        Connection connection;
        while ((connection = connectionPool.poll()) != null) {
            closeConnection(connection);
        }
        // Shutdown MySQL cleanup thread
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
        } catch (Exception e) {
            // Handle silently
        }
    }
    
    // Shutdown hook để đảm bảo dọn dẹp khi JVM tắt
    static {
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            closeAllConnections();
        }));
    }
}
