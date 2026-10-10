package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.Order;
import com.kathiravan.kathiravanmart.model.OrderItem;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Data Access Object interface for Orders and Order Items.
 */
public interface OrderDao {

    /**
     * Creates an order with items in a single transaction.
     *
     * @param order Order entity
     * @param items List of line items
     * @return Generated order ID
     */
    Long createOrderWithItems(Order order, List<OrderItem> items);

    /**
     * Finds an order by ID including line items.
     *
     * @param id Order ID
     * @return Optional containing Order
     */
    Optional<Order> findById(Long id);

    /**
     * Finds all orders placed by a buyer.
     *
     * @param buyerId Buyer's user ID
     * @return List of buyer orders
     */
    List<Order> findByBuyerId(Long buyerId);

    /**
     * Finds all incoming orders containing products from a specific seller (F6).
     *
     * @param sellerId Seller's user ID
     * @return List of orders containing seller's products
     */
    List<Order> findBySellerId(Long sellerId);

    /**
     * Finds all orders in the system for Admin management (F7).
     *
     * @return List of all orders
     */
    List<Order> findAll();

    /**
     * Updates status of an order (O2: PENDING -> CONFIRMED -> SHIPPED -> DELIVERED).
     *
     * @param orderId Order ID
     * @param status New order status
     * @return true if updated
     */
    boolean updateStatus(Long orderId, Order.Status status);

    /**
     * Retrieves seller dashboard metrics: total revenue and count of orders (O3).
     *
     * @param sellerId Seller's user ID
     * @return Map with metrics: "revenue" (BigDecimal) and "orderCount" (Long)
     */
    Map<String, Object> getSellerMetrics(Long sellerId);

    /**
     * Retrieves system-wide metrics for Admin dashboard: total revenue, order count.
     *
     * @return Map with metrics: "totalRevenue" (BigDecimal) and "totalOrders" (Long)
     */
    Map<String, Object> getAdminMetrics();

    /**
     * Checks if a buyer has purchased and received a specific product (for review eligibility F8).
     *
     * @param buyerId Buyer ID
     * @param productId Product ID
     * @return true if buyer has completed order with this product
     */
    boolean hasPurchasedAndCompleted(Long buyerId, Long productId);
}
