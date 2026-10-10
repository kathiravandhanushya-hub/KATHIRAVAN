package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.model.Order;

import java.util.List;

/**
 * Service interface for order creation, checkout processing, and status workflow.
 */
public interface OrderService {

    /**
     * Places an order from current cart contents via mock payment confirmation (F5).
     *
     * @param buyerId Buyer's user ID
     * @param shippingAddress Delivery address
     * @param paymentMethod Selected payment method
     * @return OrderDTO representing placed order
     */
    OrderDTO checkout(Long buyerId, String shippingAddress, String paymentMethod);

    /**
     * Retrieves an order by ID (verifying access permissions).
     */
    OrderDTO getOrderById(Long orderId, Long requestingUserId, boolean isAdmin);

    /**
     * Retrieves all past orders placed by a buyer (F6).
     */
    List<OrderDTO> getBuyerOrders(Long buyerId);

    /**
     * Retrieves incoming orders containing products owned by a seller (F6).
     */
    List<OrderDTO> getSellerIncomingOrders(Long sellerId);

    /**
     * Retrieves all orders in the marketplace for admin (F7).
     */
    List<OrderDTO> getAllOrdersForAdmin();

    /**
     * Progresses order status through workflow (O2: PENDING -> CONFIRMED -> SHIPPED -> DELIVERED).
     */
    boolean updateOrderStatus(Long orderId, String newStatus);
}
