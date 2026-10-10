package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.model.WishlistItem;

import java.util.List;

/**
 * Service interface for Wishlist / save-for-later management (Feature O1).
 */
public interface WishlistService {

    /**
     * Adds a product to wishlist.
     */
    boolean addToWishlist(Long userId, Long productId);

    /**
     * Removes a product from wishlist.
     */
    boolean removeFromWishlist(Long userId, Long productId);

    /**
     * Retrieves wishlist items for a user.
     */
    List<WishlistItem> getWishlist(Long userId);

    /**
     * Checks if product is in user's wishlist.
     */
    boolean isInWishlist(Long userId, Long productId);
}
