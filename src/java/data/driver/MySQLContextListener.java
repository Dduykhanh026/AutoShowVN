package data.driver;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * ServletContextListener for managing MySQL database connections
 * Initializes database connections when the web application starts
 * and cleans up when it stops
 */
@WebListener
public class MySQLContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🚀 AutoShowVN Web Application Starting...");
        System.out.println("📊 Initializing MySQL database connections...");
        
        try {
            // Test database connection
            MySQLDriver.getConnection();
            System.out.println("✅ Database connection initialized successfully");
        } catch (Exception e) {
            System.err.println("❌ Failed to initialize database connection: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("🎯 AutoShowVN Web Application Started Successfully");
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("🛑 AutoShowVN Web Application Shutting Down...");
        System.out.println("🧹 Cleaning up database connections...");
        
        try {
            // Close all database connections
            MySQLDriver.closeAllConnections();
            System.out.println("✅ Database connections cleaned up successfully");
        } catch (Exception e) {
            System.err.println("❌ Error during database cleanup: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("👋 AutoShowVN Web Application Shut Down Successfully");
    }
}
