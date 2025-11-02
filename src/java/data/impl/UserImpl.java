package data.impl;

import data.dao.UserDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserImpl implements UserDao {

    public static Connection con;

    @Override
    public List<User> findAll() {
        List<User> listUsers = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listUsers;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String passwordHash = rs.getString("password_hash");
                String role = rs.getString("role");

                listUsers.add(new User(id, fullName, email, phone, passwordHash, role));
            }
            System.out.println("Found " + listUsers.size() + " users");
        } catch (SQLException ex) {
            System.err.println("SQL Error in findAll(): " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listUsers;
    }

    @Override
    public User find(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
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
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String passwordHash = rs.getString("password_hash");
                String role = rs.getString("role");

                return new User(id, fullName, email, phone, passwordHash, role);
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in find(): " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return null;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, email);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int id = rs.getInt("id");
                String fullName = rs.getString("full_name");
                String phone = rs.getString("phone");
                String passwordHash = rs.getString("password_hash");
                String role = rs.getString("role");

                return new User(id, fullName, email, phone, passwordHash, role);
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in findByEmail(): " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public List<User> findByRole(String role) {
        List<User> listUsers = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listUsers;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, role);
            ResultSet rs = sttm.executeQuery();
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String passwordHash = rs.getString("password_hash");

                listUsers.add(new User(id, fullName, email, phone, passwordHash, role));
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in findByRole(): " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listUsers;
    }

    @Override
    public boolean insert(User user) {
        String sql = "INSERT INTO users (full_name, email, phone, password_hash, role) VALUES (?, ?, ?, ?, ?)";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, user.getFullName());
            sttm.setString(2, user.getEmail());
            sttm.setString(3, user.getPhone());
            sttm.setString(4, user.getPasswordHash());
            sttm.setString(5, user.getRole());
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in insert(): " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean update(User user) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ?, password_hash = ?, role = ? WHERE id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, user.getFullName());
            sttm.setString(2, user.getEmail());
            sttm.setString(3, user.getPhone());
            sttm.setString(4, user.getPasswordHash());
            sttm.setString(5, user.getRole());
            sttm.setInt(6, user.getId());
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in update(): " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
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
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public User authenticate(String email, String passwordHash) {
        String sql = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
        System.out.println("🔍 Đang xác thực: email=" + email + ", password=" + passwordHash);
        
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("❌ Database connection is null!");
                return null;
            }
            
            System.out.println("✅ Kết nối database thành công");
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, email);
            sttm.setString(2, passwordHash);
            
            System.out.println("🔍 Thực thi SQL: " + sql);
            System.out.println("🔍 Parameters: email=" + email + ", password=" + passwordHash);
            
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int id = rs.getInt("id");
                String fullName = rs.getString("full_name");
                String phone = rs.getString("phone");
                String role = rs.getString("role");

                System.out.println("✅ Đăng nhập thành công: " + fullName + " (Role: " + role + ")");
                return new User(id, fullName, email, phone, passwordHash, role);
            } else {
                System.out.println("❌ Không tìm thấy user với email: " + email);
            }
        } catch (SQLException ex) {
            System.err.println("❌ SQL Error in authenticate(): " + ex.getMessage());
            ex.printStackTrace();
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, email);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in emailExists(): " + ex.getMessage());
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // Method test để kiểm tra database
    public void testDatabase() {
        System.out.println("🧪 Bắt đầu test database...");
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("❌ Không thể kết nối database!");
                return;
            }
            
            System.out.println("✅ Kết nối database thành công!");
            
            // Test query đơn giản
            String sql = "SELECT COUNT(*) FROM users";
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("📊 Tổng số user trong database: " + count);
            }
            
            // Test xem bảng users có đúng cấu trúc không
            sql = "DESCRIBE users";
            sttm = con.prepareStatement(sql);
            rs = sttm.executeQuery();
            
            System.out.println("🏗️ Cấu trúc bảng users:");
            while (rs.next()) {
                String field = rs.getString("Field");
                String type = rs.getString("Type");
                String null_ = rs.getString("Null");
                String key = rs.getString("Key");
                System.out.println("   " + field + " | " + type + " | " + null_ + " | " + key);
            }
            
        } catch (SQLException ex) {
            System.err.println("❌ Lỗi SQL trong testDatabase(): " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
