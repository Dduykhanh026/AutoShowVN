package data.dao;

import java.util.List;
import model.User;

/**
 * Data Access Object interface for User entity
 * Defines basic CRUD operations for the user table
 */
public interface UserDao {
    
    /**
     * Retrieve all users from the database
     * @return List of all User objects
     */
    List<User> findAll();
    
    /**
     * Find a specific user by ID
     * @param id the user ID to search for
     * @return User object if found, null otherwise
     */
    User find(int id);
    
    /**
     * Find a user by email address
     * @param email the email to search for
     * @return User object if found, null otherwise
     */
    User findByEmail(String email);
    
    /**
     * Find users by role
     * @param role the role to search for
     * @return List of User objects with the specified role
     */
    List<User> findByRole(String role);
    
    /**
     * Insert a new user record
     * @param user the User object to insert
     * @return true if insertion successful, false otherwise
     */
    boolean insert(User user);
    
    /**
     * Update an existing user record
     * @param user the User object with updated data
     * @return true if update successful, false otherwise
     */
    boolean update(User user);
    
    /**
     * Delete a user record by ID
     * @param id the user ID to delete
     * @return true if deletion successful, false otherwise
     */
    boolean delete(int id);
    
    /**
     * Authenticate user by email and password
     * @param email the user's email
     * @param passwordHash the hashed password
     * @return User object if authentication successful, null otherwise
     */
    User authenticate(String email, String passwordHash);
    
    /**
     * Check if email already exists in the database
     * @param email the email to check
     * @return true if email exists, false otherwise
     */
    boolean emailExists(String email);
}
