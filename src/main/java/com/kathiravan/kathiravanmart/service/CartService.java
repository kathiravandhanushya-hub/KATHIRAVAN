package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dto.CartItemDTO;

import java.math.BigDecimal;
import java.util.List;

/**
 * Service interface for shopping cart operations.
 */
public interface CartService {

    /**
     * Adds an item to the buyer's cart.
     */
    CartItemDTO addToCart(Long userId, Long productId, int quantity);

    /**
     * Updates item quantity in the cart.
     */
    boolean updateCartItemQuantity(Long userId, Long cartItemId, int quantity);

    /**
     * Removes an item from the cart.
     */
    boolean removeFromCart(Long userId, Long cartItemId);

    /**
     * Clears all items in the cart.
     */
    boolean clearCart(Long userId);

    /**
     * Retrieves cart items for a buyer.
     */
    List<CartItemDTO> getCartItems(Long userId);

    /**
     * Computes the running total of all items in the cart (F4).
     */
    BigDecimal calculateRunningTotal(Long userId);
}
