package com.kathiravan.kathiravanmart.ai;

import java.util.Locale;

/**
 * MockChatProvider implementing ChatProvider with domain FAQ intelligence
 * and static degraded responses. Requires no external network calls (Section 11 & 17).
 */
public class MockChatProvider implements ChatProvider {

    @Override
    public String getReply(String userMessage, String context) {
        if (userMessage == null || userMessage.trim().isEmpty()) {
            return "Hello! I am your KathiravanMart shopping assistant. How may I assist you with our catalog or orders today?";
        }

        String msg = userMessage.toLowerCase(Locale.ENGLISH).trim();

        if (msg.contains("hello") || msg.contains("hi") || msg.contains("hey")) {
            return "Greetings! Welcome to KathiravanMart. You can ask me about our products, placing orders, seller registration, or checkout details.";
        }

        if (msg.contains("order") && (msg.contains("how") || msg.contains("place") || msg.contains("buy"))) {
            return "To place an order: 1) Browse our catalog, 2) Click 'Add to Cart', 3) Review items in your Cart, and 4) Proceed to Checkout with our instant mock payment confirmation!";
        }

        if (msg.contains("payment") || msg.contains("pay") || msg.contains("card") || msg.contains("mock")) {
            return "KathiravanMart uses a secure mock payment confirmation workflow. No real credit card details or external gateways are required during checkout.";
        }

        if (msg.contains("seller") || msg.contains("sell") || msg.contains("listing") || msg.contains("list product")) {
            return "To become a seller: Register a new account and choose the 'Seller' role. From your Seller Dashboard, you can add, edit, and manage product inventory anytime.";
        }

        if (msg.contains("status") || msg.contains("track") || msg.contains("shipped") || msg.contains("delivered")) {
            return "KathiravanMart tracks order lifecycle stages: Pending → Confirmed → Shipped → Delivered. You can check real-time progress on your 'My Orders' page.";
        }

        if (msg.contains("category") || msg.contains("categories") || msg.contains("what do you sell") || msg.contains("products")) {
            String catInfo = (context != null && !context.isEmpty()) ? " Currently available: " + context : " We feature Electronics, Fashion, Home & Living, and more!";
            return "We offer high-quality products from verified sellers." + catInfo;
        }

        if (msg.contains("review") || msg.contains("rating") || msg.contains("star")) {
            return "Buyers can leave 1 to 5-star ratings and detailed feedback on products from their completed order history.";
        }

        if (msg.contains("return") || msg.contains("cancel") || msg.contains("refund")) {
            return "Orders in 'Pending' status can be cancelled via support. Delivered orders can be reviewed for seller resolution.";
        }

        if (msg.contains("who are you") || msg.contains("kathiravanmart") || msg.contains("about")) {
            return "KathiravanMart is a multi-seller e-commerce marketplace built on Java Servlets, JDBC, and Apache Tomcat for Anna University R2025 Semester 3.";
        }

        // Domain guardrail response
        return "Thank you for asking! I specialize in KathiravanMart products, orders, cart checkout, and seller listings. Please let me know how I can help with our catalog!";
    }
}
