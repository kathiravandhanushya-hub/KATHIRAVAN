package com.kathiravan.kathiravanmart.dto;

import com.kathiravan.kathiravanmart.model.Product;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Product DTO using Builder pattern.
 */
public class ProductDTO {
    private final Long id;
    private final Long sellerId;
    private final String sellerName;
    private final String name;
    private final String description;
    private final BigDecimal price;
    private final Integer stockQty;
    private final String category;
    private final String imageUrl;
    private final Boolean isActive;
    private final Double averageRating;
    private final Integer reviewCount;
    private final Timestamp createdAt;

    private ProductDTO(Builder builder) {
        this.id = builder.id;
        this.sellerId = builder.sellerId;
        this.sellerName = builder.sellerName;
        this.name = builder.name;
        this.description = builder.description;
        this.price = builder.price;
        this.stockQty = builder.stockQty;
        this.category = builder.category;
        this.imageUrl = builder.imageUrl;
        this.isActive = builder.isActive;
        this.averageRating = builder.averageRating;
        this.reviewCount = builder.reviewCount;
        this.createdAt = builder.createdAt;
    }

    public static ProductDTO fromEntity(Product p) {
        if (p == null) {
            return null;
        }
        return new Builder()
                .id(p.getId())
                .sellerId(p.getSellerId())
                .sellerName(p.getSellerName())
                .name(p.getName())
                .description(p.getDescription())
                .price(p.getPrice())
                .stockQty(p.getStockQty())
                .category(p.getCategory())
                .imageUrl(p.getImageUrl())
                .isActive(p.getIsActive())
                .averageRating(p.getAverageRating())
                .reviewCount(p.getReviewCount())
                .createdAt(p.getCreatedAt())
                .build();
    }

    public Long getId() {
        return id;
    }

    public Long getSellerId() {
        return sellerId;
    }

    public String getSellerName() {
        return sellerName;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public Integer getStockQty() {
        return stockQty;
    }

    public String getCategory() {
        return category;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public Double getAverageRating() {
        return averageRating;
    }

    public Integer getReviewCount() {
        return reviewCount;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public static class Builder {
        private Long id;
        private Long sellerId;
        private String sellerName;
        private String name;
        private String description;
        private BigDecimal price;
        private Integer stockQty;
        private String category;
        private String imageUrl;
        private Boolean isActive = true;
        private Double averageRating = 0.0;
        private Integer reviewCount = 0;
        private Timestamp createdAt;

        public Builder id(Long id) {
            this.id = id;
            return this;
        }

        public Builder sellerId(Long sellerId) {
            this.sellerId = sellerId;
            return this;
        }

        public Builder sellerName(String sellerName) {
            this.sellerName = sellerName;
            return this;
        }

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder description(String description) {
            this.description = description;
            return this;
        }

        public Builder price(BigDecimal price) {
            this.price = price;
            return this;
        }

        public Builder stockQty(Integer stockQty) {
            this.stockQty = stockQty;
            return this;
        }

        public Builder category(String category) {
            this.category = category;
            return this;
        }

        public Builder imageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
            return this;
        }

        public Builder isActive(Boolean isActive) {
            this.isActive = isActive;
            return this;
        }

        public Builder averageRating(Double averageRating) {
            this.averageRating = averageRating;
            return this;
        }

        public Builder reviewCount(Integer reviewCount) {
            this.reviewCount = reviewCount;
            return this;
        }

        public Builder createdAt(Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public ProductDTO build() {
            return new ProductDTO(this);
        }
    }
}
