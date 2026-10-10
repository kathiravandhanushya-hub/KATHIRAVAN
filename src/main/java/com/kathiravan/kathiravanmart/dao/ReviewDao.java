package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.Review;

import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for Product Reviews.
 */
public interface ReviewDao {

    /**
     * Submits a new review.
     *
     * @param review Review entity to insert
     * @return Generated review ID
     */
    Long create(Review review);

    /**
     * Retrieves all reviews for a specific product.
     *
     * @param productId Product ID
     * @return List of reviews
     */
    List<Review> findByProductId(Long productId);

    /**
     * Retrieves a review by product and buyer.
     *
     * @param productId Product ID
     * @param userId Buyer ID
     * @return Optional containing Review
     */
    Optional<Review> findByProductAndUser(Long productId, Long userId);

    /**
     * Deletes a review by ID.
     *
     * @param id Review ID
     * @return true if deleted
     */
    boolean delete(Long id);
}
