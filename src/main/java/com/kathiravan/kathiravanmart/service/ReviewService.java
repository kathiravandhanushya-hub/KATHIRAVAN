package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dto.ReviewDTO;

import java.util.List;

/**
 * Service interface for Product Reviews and ratings (F8).
 */
public interface ReviewService {

    /**
     * Submits a review and rating for a product (verified completed purchase required).
     */
    ReviewDTO addReview(Long userId, Long productId, int rating, String comment);

    /**
     * Retrieves all reviews for a product.
     */
    List<ReviewDTO> getReviewsByProduct(Long productId);

    /**
     * Checks if a buyer is eligible to review a product.
     */
    boolean isEligibleToReview(Long userId, Long productId);

    /**
     * Deletes a review (by admin or review author).
     */
    boolean deleteReview(Long reviewId, Long requestingUserId, boolean isAdmin);
}
