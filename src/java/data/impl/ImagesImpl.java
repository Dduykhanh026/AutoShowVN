package data.impl;

import data.dao.ImagesDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.Images;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ImagesImpl implements ImagesDao {

    public static Connection con;

    @Override
    public List<Images> findAll() {
        List<Images> listImages = new ArrayList<>();
        String sql = "SELECT * FROM images";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listImages;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int productId = rs.getInt("product_id");
                String imageUrl = rs.getString("image_url");
                String imageSideUrl = rs.getString("image_side_url");
                String altText = rs.getString("alt_text");

                listImages.add(new Images(id, productId, imageUrl, imageSideUrl, altText));
            }
            System.out.println("Found " + listImages.size() + " images");
        } catch (SQLException ex) {
            System.err.println("SQL Error in findAll(): " + ex.getMessage());
            Logger.getLogger(ImagesImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listImages;
    }

    @Override
    public List<Images> findByProductId(int productId) {
        List<Images> listImages = new ArrayList<>();
        String sql = "SELECT * FROM images WHERE product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return listImages;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, productId);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String imageUrl = rs.getString("image_url");
                String imageSideUrl = rs.getString("image_side_url");
                String altText = rs.getString("alt_text");

                listImages.add(new Images(id, productId, imageUrl, imageSideUrl, altText));
            }
            System.out.println("Found " + listImages.size() + " images for product ID: " + productId);
        } catch (SQLException ex) {
            System.err.println("SQL Error in findByProductId(): " + ex.getMessage());
            Logger.getLogger(ImagesImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listImages;
    }

    @Override
    public Images find(int id) {
        String sql = "SELECT * FROM images WHERE id = ?";
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
                int productId = rs.getInt("product_id");
                String imageUrl = rs.getString("image_url");
                String imageSideUrl = rs.getString("image_side_url");
                String altText = rs.getString("alt_text");

                return new Images(id, productId, imageUrl, imageSideUrl, altText);
            }
        } catch (SQLException ex) {
            System.err.println("SQL Error in find(): " + ex.getMessage());
            Logger.getLogger(ImagesImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean insert(Images images) {
        String sql = "INSERT INTO images (product_id, image_url, image_side_url, alt_text) VALUES (?, ?, ?, ?)";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, images.getProductId());
            sttm.setString(2, images.getImageUrl());
            sttm.setString(3, images.getImageSideUrl());
            sttm.setString(4, images.getAltText());
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in insert(): " + ex.getMessage());
            Logger.getLogger(ImagesImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean update(Images images) {
        String sql = "UPDATE images SET product_id=?, image_url=?, image_side_url=?, alt_text=? WHERE id=?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, images.getProductId());
            sttm.setString(2, images.getImageUrl());
            sttm.setString(3, images.getImageSideUrl());
            sttm.setString(4, images.getAltText());
            sttm.setInt(5, images.getId());
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in update(): " + ex.getMessage());
            Logger.getLogger(ImagesImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM images WHERE id = ?";
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
            Logger.getLogger(ImagesImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    @Override
    public boolean deleteByProductId(int productId) {
        String sql = "DELETE FROM images WHERE product_id = ?";
        try {
            con = MySQLDriver.getConnection();
            if (con == null) {
                System.err.println("Database connection is null!");
                return false;
            }
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, productId);
            
            int result = sttm.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            System.err.println("SQL Error in deleteByProductId(): " + ex.getMessage());
            Logger.getLogger(ImagesImpl.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
