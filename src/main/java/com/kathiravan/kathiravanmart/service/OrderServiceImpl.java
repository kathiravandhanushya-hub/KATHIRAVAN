package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.CartDao;
import com.kathiravan.kathiravanmart.dao.OrderDao;
import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.exception.ResourceNotFoundException;
import com.kathiravan.kathiravanmart.exception.UnauthorizedException;
import com.kathiravan.kathiravanmart.exception.ValidationException;
import com.kathiravan.kathiravanmart.factory.DaoFactory;
import com.kathiravan.kathiravanmart.model.CartItem;
import com.kathiravan.kathiravanmart.model.Order;
import com.kathiravan.kathiravanmart.model.OrderItem;
import com.kathiravan.kathiravanmart.strategy.MockPaymentStrategy;
import com.kathiravan.kathiravanmart.strategy.PaymentResult;
import com.kathiravan.kathiravanmart.strategy.PaymentStrategy;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of OrderService.
 * Coordinates checkout, payment strategy execution, and order workflow.
 */
public class OrderServiceImpl implements OrderService {

    private final OrderDao orderDao;
    private final CartDao cartDao;
    private final PaymentStrategy paymentStrategy;

    public OrderServiceImpl() {
        this.orderDao = DaoFactory.getOrderDao();
        this.cartDao = DaoFactory.getCartDao();
        this.paymentStrategy = new MockPaymentStrategy();
    }

    public OrderServiceImpl(OrderDao orderDao, CartDao cartDao, PaymentStrategy paymentStrategy) {
        this.orderDao = orderDao;
        this.cartDao = cartDao;
        this.paymentStrategy = paymentStrategy != null ? paymentStrategy : new MockPaymentStrategy();
    }

    @Override
    public OrderDTO checkout(Long buyerId, String shippingAddress, String paymentMethod) {
        // 1. Validation at top of service method
        if (shippingAddress == null || shippingAddress.trim().length() < 10) {
            throw new ValidationException("shippingAddress", "Please provide a valid shipping address (at least 10 characters)");
        }

        // 2. Fetch cart items
        List<CartItem> cartItems = cartDao.findByUserId(buyerId);
        if (cartItems.isEmpty()) {
            throw new ValidationException("cart", "Your cart is empty. Add products before checking out.");
        }

        // 3. Calculate order total and prepare line items
        BigDecimal totalAmount = BigDecimal.ZERO;
        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem ci : cartItems) {
            if (ci.getStockQty() < ci.getQuantity()) {
                throw new ValidationException("stock", "Product '" + ci.getProductName() + "' has insufficient stock.");
            }
            BigDecimal itemTotal = ci.getProductPrice().multiply(BigDecimal.valueOf(ci.getQuantity()));
            totalAmount = totalAmount.add(itemTotal);

            OrderItem oi = new OrderItem();
            oi.setProductId(ci.getProductId());
            oi.setQuantity(ci.getQuantity());
            oi.setUnitPrice(ci.getProductPrice());
            orderItems.add(oi);
        }

        // 4. Execute mock payment confirmation via Strategy pattern (F5)
        PaymentResult paymentResult = paymentStrategy.processPayment(null, totalAmount, paymentMethod);
        if (!paymentResult.isSuccessful()) {
            throw new ValidationException("payment", "Payment authorization failed: " + paymentResult.getMessage());
        }

        // 5. Construct Order entity
        Order order = new Order();
        order.setBuyerId(buyerId);
        order.setStatus(Order.Status.CONFIRMED);
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(shippingAddress.trim());
        order.setPaymentMethod(paymentStrategy.getPaymentMethodName());
        order.setPaymentStatus("COMPLETED");

        // 6. Create order in DB with atomic stock reduction
        Long orderId = orderDao.createOrderWithItems(order, orderItems);
        order.setId(orderId);

        // 7. Clear user cart
        cartDao.clearCart(buyerId);

        // 8. Return fresh OrderDTO
        return orderDao.findById(orderId)
                .map(OrderDTO::fromEntity)
                .orElseThrow(() -> new ResourceNotFoundException("Failed to load placed order"));
    }

    @Override
    public OrderDTO getOrderById(Long orderId, Long requestingUserId, boolean isAdmin) {
        Order order = orderDao.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with ID " + orderId));

        if (!isAdmin && !order.getBuyerId().equals(requestingUserId)) {
            // Check if seller owns any product in this order
            boolean isSellerOfItem = order.getItems().stream()
                    .anyMatch(item -> requestingUserId.equals(item.getSellerId()));
            if (!isSellerOfItem) {
                throw new UnauthorizedException("You are not authorized to view this order");
            }
        }

        return OrderDTO.fromEntity(order);
    }

    @Override
    public List<OrderDTO> getBuyerOrders(Long buyerId) {
        return orderDao.findByBuyerId(buyerId).stream()
                .map(OrderDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public List<OrderDTO> getSellerIncomingOrders(Long sellerId) {
        return orderDao.findBySellerId(sellerId).stream()
                .map(OrderDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public List<OrderDTO> getAllOrdersForAdmin() {
        return orderDao.findAll().stream()
                .map(OrderDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public boolean updateOrderStatus(Long orderId, String newStatus) {
        Order.Status status = Order.Status.fromString(newStatus);
        if (status == null) {
            throw new ValidationException("status", "Invalid order status value: " + newStatus);
        }

        orderDao.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with ID " + orderId));

        return orderDao.updateStatus(orderId, status);
    }
}
