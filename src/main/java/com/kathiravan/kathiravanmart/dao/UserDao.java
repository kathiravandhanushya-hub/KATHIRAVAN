package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.User;

import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for User entities.
 */
public interface UserDao {

    /**
     * Inserts a new user record.
     *
     * @param user User entity to save
     * @return Generated user ID
     */
    Long create(User user);

    /**
     * Finds a user by unique identifier.
     *
     * @param id User ID
     * @return Optional containing User if found
     */
    Optional<User> findById(Long id);

    /**
     * Finds a user by unique email address.
     *
     * @param email User email
     * @return Optional containing User if found
     */
    Optional<User> findByEmail(String email);

    /**
     * Retrieves all registered users.
     *
     * @return List of all users
     */
    List<User> findAll();

    /**
     * Updates an existing user's details.
     *
     * @param user User entity with updated values
     * @return true if updated, false otherwise
     */
    boolean update(User user);

    /**
     * Deletes a user by identifier.
     *
     * @param id User ID
     * @return true if deleted, false otherwise
     */
    boolean delete(Long id);

    /**
     * Counts total registered users.
     *
     * @return Total count
     */
    long count();
}
