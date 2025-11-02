package data.dao;

import java.util.List;
import model.Images;

/**
 * Data Access Object interface for Images entity
 * Defines basic CRUD operations for the images table
 */
public interface ImagesDao {
    
    /**
     * Retrieve all images from the database
     * @return List of all Images objects
     */
    List<Images> findAll();
    
    /**
     * Find images by product ID
     * @param productId the product ID to search for
     * @return List of Images objects for the specified product
     */
    List<Images> findByProductId(int productId);
    
    /**
     * Find a specific image by its ID
     * @param id the image ID to search for
     * @return Images object if found, null otherwise
     */
    Images find(int id);
    
    /**
     * Insert a new image record
     * @param images the Images object to insert
     * @return true if insertion successful, false otherwise
     */
    boolean insert(Images images);
    
    /**
     * Update an existing image record
     * @param images the Images object with updated data
     * @return true if update successful, false otherwise
     */
    boolean update(Images images);
    
    /**
     * Delete an image record by ID
     * @param id the image ID to delete
     * @return true if deletion successful, false otherwise
     */
    boolean delete(int id);
    
    /**
     * Delete all images for a specific product
     * @param productId the product ID whose images should be deleted
     * @return true if deletion successful, false otherwise
     */
    boolean deleteByProductId(int productId);
}
