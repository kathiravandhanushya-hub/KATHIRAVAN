package com.kathiravan.kathiravanmart.strategy;

import java.math.BigDecimal;
import java.util.UUID;

/**
 * Default mock payment confirmation strategy conforming to Scope Constraints
 * (Section 1: "No third-party payment gateway integration. Checkout implements a mock payment confirmation step.")
 */
public class MockPaymentStrategy implements PaymentStrategy {

    @Override
    public PaymentResult processPayment(Long orderId, BigDecimal amount, String details) {
        String txnId = "TXN-MOCK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        return new PaymentResult(true, txnId, "Mock payment processed successfully for ₹" + amount);
    }

    @Override
    public String getPaymentMethodName() {
        return "MOCK_PAYMENT";
    }
}
