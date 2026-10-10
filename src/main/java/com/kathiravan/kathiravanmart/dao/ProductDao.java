package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.Product;

import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for Product listings.
 */
public interface ProductDao {

    /**
     * Inserts a new product listing.
     *
     * @param product Product entity to create
     * @return Generated product ID
     */
    Long create(Product product);

    /**
     * Finds a product by ID.
     *
     * @param id Product ID
     * @return Optional containing Product if found
     */
    Optional<Product> findById(Long id);

    /**
     * Retrieves all active products.
     *
     * @return List of active products
     */
    List<Product> findAllActive();

    /**
     * Retrieves all products (including moderated/inactive) for Admin.
     *
     * @return List of all products
     */
    List<Product> findAll();

    /**
     * Retrieves all products listed by a specific seller.
     *
     * @param sellerId Seller's user ID
     * @return List of products owned by seller
     */
    List<Product> findBySellerId(Long sellerId);

    /**
     * Searches and filters products by optional keyword and optional category.
     *
     * @param keyword Search term matched against product name or description
     * @param category Category filter
     * @return Filtered list of products
     */
    List<Product> searchAndFilter(String keyword, String category);

    /**
     * Retrieves distinct categories of existing active products.
     *
     * @return List of distinct category strings
     */
    List<String> findDistinctCategories();

    /**
     * Updates product details.
     *
     * @param product Product entity with updated fields
     * @return true if updated, false otherwise
     */
    boolean update(Product product);

    /**
     * Updates product stock quantity.
     *
     * @param productId Product ID
     * @param newStock New stock quantity
     * @return true if updated, false otherwise
     */
    boolean updateStock(Long productId, int newStock);

    /**
     * Sets active/moderated status of a product.
     *
     * @param productId Product ID
     * @param active true for active, false for moderated/hidden
     * @return true if updated, false otherwise
     */
    boolean setActiveStatus(Long productId, boolean active);

    /**
     * Deletes a product permanently.
     *
     * @param id Product ID
     * @return true if deleted, false otherwise
     */
    boolean delete(Long id);

    /**
     * Counts active products.
     *
     * @return Total count
     */
    long countActive();
}
