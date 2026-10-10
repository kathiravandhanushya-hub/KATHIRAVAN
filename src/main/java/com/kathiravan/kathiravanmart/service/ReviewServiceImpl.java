package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.OrderDao;
import com.kathiravan.kathiravanmart.dao.ProductDao;
import com.kathiravan.kathiravanmart.dao.ReviewDao;
import com.kathiravan.kathiravanmart.dto.ReviewDTO;
import com.kathiravan.kathiravanmart.exception.AppException;
import com.kathiravan.kathiravanmart.exception.ResourceNotFoundException;
import com.kathiravan.kathiravanmart.exception.ValidationException;
import com.kathiravan.kathiravanmart.factory.DaoFactory;
import com.kathiravan.kathiravanmart.model.Review;
import com.kathiravan.kathiravanmart.util.ValidationUtil;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Implementation of ReviewService.
 * Enforces requirement F8: Product reviews on completed orders.
 */
public class ReviewServiceImpl implements ReviewService {

    private final ReviewDao reviewDao;
    private final OrderDao orderDao;
    private final ProductDao productDao;

    public ReviewServiceImpl() {
        this.reviewDao = DaoFactory.getReviewDao();
        this.orderDao = DaoFactory.getOrderDao();
        this.productDao = DaoFactory.getProductDao();
    }

    public ReviewServiceImpl(ReviewDao reviewDao, OrderDao orderDao, ProductDao productDao) {
        this.reviewDao = reviewDao;
        this.orderDao = orderDao;
        this.productDao = productDao;
    }

    @Override
    public ReviewDTO addReview(Long userId, Long productId, int rating, String comment) {
        // 1. Validation at top of service method
        ValidationUtil.validateReview(rating, comment);

        productDao.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        // 2. Check completed purchase eligibility (F8)
        if (!orderDao.hasPurchasedAndCompleted(userId, productId)) {
            throw new AppException("You can only review products from completed orders.", 403, "FORBIDDEN");
        }

        // 3. Check duplicate review
        Optional<Review> existing = reviewDao.findByProductAndUser(productId, userId);
        if (existing.isPresent()) {
            throw new AppException("You have already reviewed this product.", 409, "CONFLICT");
        }

        Review r = new Review();
        r.setProductId(productId);
        r.setUserId(userId);
        r.setRating(rating);
        r.setComment(comment != null ? comment.trim() : "");

        Long id = reviewDao.create(r);
        r.setId(id);
        return ReviewDTO.fromEntity(r);
    }

    @Override
    public List<ReviewDTO> getReviewsByProduct(Long productId) {
        return reviewDao.findByProductId(productId).stream()
                .map(ReviewDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public boolean isEligibleToReview(Long userId, Long productId) {
        if (userId == null || productId == null) {
            return false;
        }
        if (reviewDao.findByProductAndUser(productId, userId).isPresent()) {
            return false;
        }
        return orderDao.hasPurchasedAndCompleted(userId, productId);
    }

    @Override
    public boolean deleteReview(Long reviewId, Long requestingUserId, boolean isAdmin) {
        return reviewDao.delete(reviewId);
    }
}
