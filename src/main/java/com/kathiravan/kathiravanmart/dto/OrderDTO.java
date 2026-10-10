package com.kathiravan.kathiravanmart.dto;

import com.kathiravan.kathiravanmart.model.Order;
import com.kathiravan.kathiravanmart.model.OrderItem;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Order DTO using Builder pattern.
 */
public class OrderDTO {
    private final Long id;
    private final Long buyerId;
    private final String buyerName;
    private final String buyerEmail;
    private final Order.Status status;
    private final BigDecimal totalAmount;
    private final String shippingAddress;
    private final String paymentMethod;
    private final String paymentStatus;
    private final Timestamp createdAt;
    private final List<OrderItem> items;

    private OrderDTO(Builder builder) {
        this.id = builder.id;
        this.buyerId = builder.buyerId;
        this.buyerName = builder.buyerName;
        this.buyerEmail = builder.buyerEmail;
        this.status = builder.status;
        this.totalAmount = builder.totalAmount;
        this.shippingAddress = builder.shippingAddress;
        this.paymentMethod = builder.paymentMethod;
        this.paymentStatus = builder.paymentStatus;
        this.createdAt = builder.createdAt;
        this.items = builder.items != null ? builder.items : new ArrayList<>();
    }

    public static OrderDTO fromEntity(Order order) {
        if (order == null) {
            return null;
        }
        return new Builder()
                .id(order.getId())
                .buyerId(order.getBuyerId())
                .buyerName(order.getBuyerName())
                .buyerEmail(order.getBuyerEmail())
                .status(order.getStatus())
                .totalAmount(order.getTotalAmount())
                .shippingAddress(order.getShippingAddress())
                .paymentMethod(order.getPaymentMethod())
                .paymentStatus(order.getPaymentStatus())
                .createdAt(order.getCreatedAt())
                .items(order.getItems())
                .build();
    }

    public Long getId() {
        return id;
    }

    public Long getBuyerId() {
        return buyerId;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public String getBuyerEmail() {
        return buyerEmail;
    }

    public Order.Status getStatus() {
        return status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public static class Builder {
        private Long id;
        private Long buyerId;
        private String buyerName;
        private String buyerEmail;
        private Order.Status status;
        private BigDecimal totalAmount;
        private String shippingAddress;
        private String paymentMethod;
        private String paymentStatus;
        private Timestamp createdAt;
        private List<OrderItem> items = new ArrayList<>();

        public Builder id(Long id) {
            this.id = id;
            return this;
        }

        public Builder buyerId(Long buyerId) {
            this.buyerId = buyerId;
            return this;
        }

        public Builder buyerName(String buyerName) {
            this.buyerName = buyerName;
            return this;
        }

        public Builder buyerEmail(String buyerEmail) {
            this.buyerEmail = buyerEmail;
            return this;
        }

        public Builder status(Order.Status status) {
            this.status = status;
            return this;
        }

        public Builder totalAmount(BigDecimal totalAmount) {
            this.totalAmount = totalAmount;
            return this;
        }

        public Builder shippingAddress(String shippingAddress) {
            this.shippingAddress = shippingAddress;
            return this;
        }

        public Builder paymentMethod(String paymentMethod) {
            this.paymentMethod = paymentMethod;
            return this;
        }

        public Builder paymentStatus(String paymentStatus) {
            this.paymentStatus = paymentStatus;
            return this;
        }

        public Builder createdAt(Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Builder items(List<OrderItem> items) {
            this.items = items;
            return this;
        }

        public OrderDTO build() {
            return new OrderDTO(this);
        }
    }
}
