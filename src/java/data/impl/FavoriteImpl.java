package data.impl;

import data.dao.FavoriteDao;
import data.driver.MySQLDriver;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.Favorite;
import model.Product;
import model.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Implementation of FavoriteDao interface
 * Handles database operations for the favorites table
 * 
 * @author Duy Khánh
 */
public class FavoriteImpl implements FavoriteDao {

    public static Connection con;

    @Override
    public List<Favorite> findAll() {
        List<Favorite> listFavorites = new ArrayList<>();
        String sql = "SELECT * FROM favorites";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listFavorites;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                int productId = rs.getInt("product_id");
                String note = rs.getString("note");

                listFavorites.add(new Favorite(userId, productId, note));
            }
            System.out.println("Found " + listFavorites.size() + " favorites");
        } catch (SQLException ex) {
            System.err.println("SQL Error in findAll(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listFavorites;
    }

    @Override
    public Favorite findByUserAndProduct(int userId, int productId) {
        String sql = "SELECT * FROM favorites WHERE user_id = ? AND product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return null;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, userId);
            sttm.setInt(2, productId);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                String note = rs.getString("note");
                return new Favorite(userId, productId, note);
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in findByUserAndProduct(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public List<Favorite> findByUserId(int userId) {
        List<Favorite> listFavorites = new ArrayList<>();
        String sql = "SELECT f.user_id, f.product_id, f.note, p.* FROM favorites f " +
                     "JOIN products p ON f.product_id = p.id " +
                     "WHERE f.user_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listFavorites;
            }
            
            System.out.println("Executing SQL: " + sql + " with userId: " + userId);
            
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, userId);
            ResultSet rs = sttm.executeQuery();
            
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                String note = rs.getString("note");
                
                // Debug: In ra tất cả các cột để kiểm tra
                System.out.println("Product ID: " + productId);
                System.out.println("Note: " + note);
                
                // Create Product object
                Product product = new Product();
                product.setId(productId);
                
                try {
                    int categoryId = rs.getInt("category_id");
                    product.setCategoryId(categoryId);
                    System.out.println("Category ID: " + categoryId);
                } catch (Exception e) {
                    System.err.println("Error getting category_id: " + e.getMessage());
                }
                
                try {
                    String name = rs.getString("name");
                    product.setName(name);
                    System.out.println("Product Name: " + name);
                } catch (Exception e) {
                    System.err.println("Error getting name: " + e.getMessage());
                }
                
                try {
                    BigDecimal price = rs.getBigDecimal("price");
                    product.setPrice(price);
                    System.out.println("Price: " + price);
                } catch (Exception e) {
                    System.err.println("Error getting price: " + e.getMessage());
                }
                
                try {
                    int year = rs.getInt("year");
                    product.setYear(year);
                    System.out.println("Year: " + year);
                } catch (Exception e) {
                    System.err.println("Error getting year: " + e.getMessage());
                }
                
                try {
                    String engine = rs.getString("engine");
                    product.setEngine(engine);
                    System.out.println("Engine: " + engine);
                } catch (Exception e) {
                    System.err.println("Error getting engine: " + e.getMessage());
                }
                
                try {
                    int horsepower = rs.getInt("horsepower");
                    product.setHorsepower(horsepower);
                    System.out.println("Horsepower: " + horsepower);
                } catch (Exception e) {
                    System.err.println("Error getting horsepower: " + e.getMessage());
                }
                
                try {
                    int torque = rs.getInt("torque");
                    product.setTorque(torque);
                    System.out.println("Torque: " + torque);
                } catch (Exception e) {
                    System.err.println("Error getting torque: " + e.getMessage());
                }
                
                try {
                    int topSpeed = rs.getInt("top_speed");
                    product.setTopSpeed(topSpeed);
                    System.out.println("Top Speed: " + topSpeed);
                } catch (Exception e) {
                    System.err.println("Error getting top_speed: " + e.getMessage());
                }
                
                try {
                    String image = rs.getString("image");
                    product.setImage(image);
                    System.out.println("Image: " + image);
                } catch (Exception e) {
                    System.err.println("Error getting image: " + e.getMessage());
                }
                
                try {
                    String description = rs.getString("description");
                    product.setDescription(description);
                    System.out.println("Description: " + description);
                } catch (Exception e) {
                    System.err.println("Error getting description: " + e.getMessage());
                }
                
                // Create Favorite with Product
                Favorite favorite = new Favorite(userId, productId, note, product);
                listFavorites.add(favorite);
                
                System.out.println("Added favorite: " + favorite.toString());
            }
            System.out.println("Found " + listFavorites.size() + " favorites for user ID: " + userId);
        } catch (SQLException ex) {
            System.err.println("SQL Error in findByUserId(): " + ex.getMessage());
            ex.printStackTrace();
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    System.err.println("Error closing connection: " + e.getMessage());
                }
            }
        }
        return listFavorites;
    }

    @Override
    public List<Favorite> findByProductId(int productId) {
        List<Favorite> listFavorites = new ArrayList<>();
        String sql = "SELECT * FROM favorites WHERE product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listFavorites;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, productId);
            ResultSet rs = sttm.executeQuery();
            
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                String note = rs.getString("note");
                listFavorites.add(new Favorite(userId, productId, note));
            }
            System.out.println("Found " + listFavorites.size() + " favorites for product ID: " + productId);
        } catch (SQLException ex) {
            System.err.println("SQL Error in findByProductId(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listFavorites;
    }

    @Override
    public boolean exists(int userId, int productId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ? AND product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, userId);
            sttm.setInt(2, productId);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in exists(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean insert(Favorite favorite) {
        String sql = "INSERT INTO favorites (user_id, product_id, note) VALUES (?, ?, ?)";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, favorite.getUserId());
            sttm.setInt(2, favorite.getProductId());
            sttm.setString(3, favorite.getNote());
            
            int result = sttm.executeUpdate();
            if (result > 0) {
                System.out.println("Added product ID " + favorite.getProductId() + " to favorites for user ID " + favorite.getUserId());
                return true;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in insert(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean update(Favorite favorite) {
        String sql = "UPDATE favorites SET note = ? WHERE user_id = ? AND product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, favorite.getNote());
            sttm.setInt(2, favorite.getUserId());
            sttm.setInt(3, favorite.getProductId());
            
            int result = sttm.executeUpdate();
            if (result > 0) {
                System.out.println("Updated favorite for user ID " + favorite.getUserId() + " and product ID " + favorite.getProductId());
                return true;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in update(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean updateNote(int userId, int productId, String note) {
        String sql = "UPDATE favorites SET note = ? WHERE user_id = ? AND product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, note);
            sttm.setInt(2, userId);
            sttm.setInt(3, productId);
            
            int result = sttm.executeUpdate();
            if (result > 0) {
                System.out.println("Updated note for user ID " + userId + " and product ID " + productId);
                return true;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in updateNote(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean delete(int userId, int productId) {
        String sql = "DELETE FROM favorites WHERE user_id = ? AND product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, userId);
            sttm.setInt(2, productId);
            
            int result = sttm.executeUpdate();
            if (result > 0) {
                System.out.println("Removed product ID " + productId + " from favorites for user ID " + userId);
                return true;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in delete(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean deleteByUserId(int userId) {
        String sql = "DELETE FROM favorites WHERE user_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, userId);
            
            int result = sttm.executeUpdate();
            if (result > 0) {
                System.out.println("Removed " + result + " favorites for user ID " + userId);
                return true;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in deleteByUserId(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean deleteByProductId(int productId) {
        String sql = "DELETE FROM favorites WHERE product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
                PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, productId);
            
            int result = sttm.executeUpdate();
            if (result > 0) {
                System.out.println("Removed " + result + " favorites for product ID " + productId);
                return true;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in deleteByProductId(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE user_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return 0;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, userId);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("User ID " + userId + " has " + count + " favorites");
                return count;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in countByUserId(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    @Override
    public int countByProductId(int productId) {
        String sql = "SELECT COUNT(*) FROM favorites WHERE product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return 0;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, productId);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Product ID " + productId + " has " + count + " favorites");
                return count;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in countByProductId(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    @Override
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM favorites";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return 0;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Total favorites in system: " + count);
                return count;
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in getTotalCount(): " + ex.getMessage());
            Logger.getLogger(FavoriteImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
