package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.WishlistItem;

import java.util.List;

/**
 * Data Access Object interface for Wishlist items (Feature O1).
 */
public interface WishlistDao {

    /**
     * Adds a product to user's wishlist.
     *
     * @param userId Buyer ID
     * @param productId Product ID
     * @return Generated wishlist ID
     */
    Long addItem(Long userId, Long productId);

    /**
     * Removes an item from wishlist.
     *
     * @param userId Buyer ID
     * @param productId Product ID
     * @return true if removed
     */
    boolean removeItem(Long userId, Long productId);

    /**
     * Retrieves wishlist items for a buyer.
     *
     * @param userId Buyer ID
     * @return List of Wishlist items
     */
    List<WishlistItem> findByUserId(Long userId);

    /**
     * Checks if product is already in user's wishlist.
     *
     * @param userId Buyer ID
     * @param productId Product ID
     * @return true if present
     */
    boolean exists(Long userId, Long productId);
}
