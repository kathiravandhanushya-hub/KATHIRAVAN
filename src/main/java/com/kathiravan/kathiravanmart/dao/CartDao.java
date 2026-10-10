package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.CartItem;

import java.util.List;
import java.util.Optional;

/**
 * Data Access Object interface for Shopping Cart items.
 */
public interface CartDao {

    /**
     * Adds an item to the user's cart or increments quantity if it already exists.
     *
     * @param userId Buyer ID
     * @param productId Product ID
     * @param quantity Quantity to add
     * @return Generated or existing CartItem ID
     */
    Long addItem(Long userId, Long productId, int quantity);

    /**
     * Updates quantity of a cart item.
     *
     * @param cartItemId Cart item ID
     * @param quantity New quantity
     * @return true if updated, false otherwise
     */
    boolean updateQuantity(Long cartItemId, int quantity);

    /**
     * Removes an item from the cart.
     *
     * @param cartItemId Cart item ID
     * @param userId Buyer ID for ownership verification
     * @return true if removed, false otherwise
     */
    boolean removeItem(Long cartItemId, Long userId);

    /**
     * Clears all items in a user's cart (typically after order placement).
     *
     * @param userId Buyer ID
     * @return true if cleared
     */
    boolean clearCart(Long userId);

    /**
     * Retrieves all cart items with product details for a buyer.
     *
     * @param userId Buyer ID
     * @return List of cart items
     */
    List<CartItem> findByUserId(Long userId);

    /**
     * Finds a single cart item by ID.
     *
     * @param cartItemId Cart item ID
     * @return Optional containing CartItem
     */
    Optional<CartItem> findById(Long cartItemId);

    /**
     * Finds a cart item by user ID and product ID.
     *
     * @param userId Buyer ID
     * @param productId Product ID
     * @return Optional containing CartItem
     */
    Optional<CartItem> findByUserAndProduct(Long userId, Long productId);
}
