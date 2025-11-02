package data.dao;

import java.util.List;
import model.Favorite;

/**
 * Data Access Object interface for Favorite entity
 * Defines basic CRUD operations for the favorites table
 * 
 * @author Duy Khánh
 */
public interface FavoriteDao {
    
    /**
     * Retrieve all favorites from the database
     * @return List of all Favorite objects
     */
    List<Favorite> findAll();
    
    /**
     * Find a specific favorite by user ID and product ID
     * @param userId the user ID
     * @param productId the product ID
     * @return Favorite object if found, null otherwise
     */
    Favorite findByUserAndProduct(int userId, int productId);
    
    /**
     * Find all favorites for a specific user
     * @param userId the user ID to search for
     * @return List of Favorite objects for the specified user
     */
    List<Favorite> findByUserId(int userId);
    
    /**
     * Find all favorites for a specific product
     * @param productId the product ID to search for
     * @return List of Favorite objects for the specified product
     */
    List<Favorite> findByProductId(int productId);
    
    /**
     * Check if a product is in user's favorites
     * @param userId the user ID
     * @param productId the product ID
     * @return true if product is in user's favorites, false otherwise
     */
    boolean exists(int userId, int productId);
    
    /**
     * Insert a new favorite record
     * @param favorite the Favorite object to insert
     * @return true if insertion successful, false otherwise
     */
    boolean insert(Favorite favorite);
    
    /**
     * Update an existing favorite record (mainly for updating notes)
     * @param favorite the Favorite object with updated data
     * @return true if update successful, false otherwise
     */
    boolean update(Favorite favorite);
    
    /**
     * Update only the note for a specific favorite
     * @param userId the user ID
     * @param productId the product ID
     * @param note the new note content
     * @return true if update successful, false otherwise
     */
    boolean updateNote(int userId, int productId, String note);
    
    /**
     * Delete a favorite record by user ID and product ID
     * @param userId the user ID
     * @param productId the product ID
     * @return true if deletion successful, false otherwise
     */
    boolean delete(int userId, int productId);
    
    /**
     * Delete all favorites for a specific user
     * @param userId the user ID
     * @return true if deletion successful, false otherwise
     */
    boolean deleteByUserId(int userId);
    
    /**
     * Delete all favorites for a specific product
     * @param productId the product ID
     * @return true if deletion successful, false otherwise
     */
    boolean deleteByProductId(int productId);
    
    /**
     * Count total number of favorites for a specific user
     * @param userId the user ID
     * @return total number of favorites
     */
    int countByUserId(int userId);
    
    /**
     * Count total number of favorites for a specific product
     * @param productId the product ID
     * @return total number of favorites
     */
    int countByProductId(int productId);
    
    /**
     * Get total number of favorites in the system
     * @return total number of favorites
     */
    int getTotalCount();
}
