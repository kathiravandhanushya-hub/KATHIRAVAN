package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.CartDao;
import com.kathiravan.kathiravanmart.dao.OrderDao;
import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.exception.ValidationException;
import com.kathiravan.kathiravanmart.model.CartItem;
import com.kathiravan.kathiravanmart.model.Order;
import com.kathiravan.kathiravanmart.strategy.MockPaymentStrategy;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.Mockito.*;

/**
 * Unit tests for OrderService using JUnit 5 + Mockito (Section 9).
 */
@ExtendWith(MockitoExtension.class)
public class OrderServiceTest {

    @Mock
    private OrderDao orderDao;

    @Mock
    private CartDao cartDao;

    private OrderService orderService;

    @BeforeEach
    void setUp() {
        orderService = new OrderServiceImpl(orderDao, cartDao, new MockPaymentStrategy());
    }

    @Test
    @DisplayName("Should throw ValidationException when checking out with empty cart")
    void testCheckoutEmptyCart() {
        when(cartDao.findByUserId(1L)).thenReturn(Collections.emptyList());

        assertThrows(ValidationException.class, () ->
                orderService.checkout(1L, "Valid address 12345 Street", "MOCK_PAYMENT"));

        verify(orderDao, never()).createOrderWithItems(any(), anyList());
    }

    @Test
    @DisplayName("Should checkout successfully, charge mock payment, and clear cart")
    void testCheckoutSuccess() {
        CartItem item = new CartItem(10L, 1L, 5L, 2, null);
        item.setProductName("Laptop");
        item.setProductPrice(new BigDecimal("50000.00"));
        item.setStockQty(10);

        when(cartDao.findByUserId(1L)).thenReturn(List.of(item));
        when(orderDao.createOrderWithItems(any(Order.class), anyList())).thenReturn(999L);

        Order placedOrder = new Order(999L, 1L, Order.Status.CONFIRMED, new BigDecimal("100000.00"),
                "123 Anna Salai, Chennai", "MOCK_PAYMENT", "COMPLETED", null);
        when(orderDao.findById(999L)).thenReturn(Optional.of(placedOrder));

        OrderDTO dto = orderService.checkout(1L, "123 Anna Salai, Chennai", "MOCK_PAYMENT");

        assertNotNull(dto);
        assertEquals(999L, dto.getId());
        assertEquals(Order.Status.CONFIRMED, dto.getStatus());

        verify(cartDao, times(1)).clearCart(1L);
        verify(orderDao, times(1)).createOrderWithItems(any(Order.class), anyList());
    }

    @Test
    @DisplayName("Should update order status successfully")
    void testUpdateStatus() {
        Order order = new Order(10L, 1L, Order.Status.PENDING, BigDecimal.valueOf(500), "addr", "mock", "done", null);
        when(orderDao.findById(10L)).thenReturn(Optional.of(order));
        when(orderDao.updateStatus(10L, Order.Status.SHIPPED)).thenReturn(true);

        boolean updated = orderService.updateOrderStatus(10L, "SHIPPED");
        assertTrue(updated);
        verify(orderDao, times(1)).updateStatus(10L, Order.Status.SHIPPED);
    }
}
