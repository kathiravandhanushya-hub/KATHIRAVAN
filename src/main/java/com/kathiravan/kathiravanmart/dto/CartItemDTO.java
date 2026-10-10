package com.kathiravan.kathiravanmart.dto;

import com.kathiravan.kathiravanmart.model.CartItem;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Cart item DTO using Builder pattern.
 */
public class CartItemDTO {
    private final Long id;
    private final Long userId;
    private final Long productId;
    private final String productName;
    private final BigDecimal productPrice;
    private final String productImage;
    private final Integer quantity;
    private final Integer stockQty;
    private final BigDecimal subtotal;
    private final Timestamp createdAt;

    private CartItemDTO(Builder builder) {
        this.id = builder.id;
        this.userId = builder.userId;
        this.productId = builder.productId;
        this.productName = builder.productName;
        this.productPrice = builder.productPrice;
        this.productImage = builder.productImage;
        this.quantity = builder.quantity;
        this.stockQty = builder.stockQty;
        this.subtotal = builder.subtotal;
        this.createdAt = builder.createdAt;
    }

    public static CartItemDTO fromEntity(CartItem item) {
        if (item == null) {
            return null;
        }
        return new Builder()
                .id(item.getId())
                .userId(item.getUserId())
                .productId(item.getProductId())
                .productName(item.getProductName())
                .productPrice(item.getProductPrice())
                .productImage(item.getProductImage())
                .quantity(item.getQuantity())
                .stockQty(item.getStockQty())
                .subtotal(item.getSubtotal())
                .createdAt(item.getCreatedAt())
                .build();
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
    }

    public Long getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public String getProductImage() {
        return productImage;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public Integer getStockQty() {
        return stockQty;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public static class Builder {
        private Long id;
        private Long userId;
        private Long productId;
        private String productName;
        private BigDecimal productPrice;
        private String productImage;
        private Integer quantity;
        private Integer stockQty;
        private BigDecimal subtotal;
        private Timestamp createdAt;

        public Builder id(Long id) {
            this.id = id;
            return this;
        }

        public Builder userId(Long userId) {
            this.userId = userId;
            return this;
        }

        public Builder productId(Long productId) {
            this.productId = productId;
            return this;
        }

        public Builder productName(String productName) {
            this.productName = productName;
            return this;
        }

        public Builder productPrice(BigDecimal productPrice) {
            this.productPrice = productPrice;
            return this;
        }

        public Builder productImage(String productImage) {
            this.productImage = productImage;
            return this;
        }

        public Builder quantity(Integer quantity) {
            this.quantity = quantity;
            return this;
        }

        public Builder stockQty(Integer stockQty) {
            this.stockQty = stockQty;
            return this;
        }

        public Builder subtotal(BigDecimal subtotal) {
            this.subtotal = subtotal;
            return this;
        }

        public Builder createdAt(Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public CartItemDTO build() {
            return new CartItemDTO(this);
        }
    }
}
