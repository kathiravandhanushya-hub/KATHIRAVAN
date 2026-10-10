package com.kathiravan.kathiravanmart.strategy;

import java.math.BigDecimal;

/**
 * Strategy interface for payment handling (Section 12 Design Patterns).
 */
public interface PaymentStrategy {
    /**
     * Executes mock payment confirmation for an order.
     *
     * @param orderId Identifier of the order
     * @param amount Total order amount
     * @param details Additional payment metadata
     * @return PaymentResult representing outcome
     */
    PaymentResult processPayment(Long orderId, BigDecimal amount, String details);

    String getPaymentMethodName();
}
