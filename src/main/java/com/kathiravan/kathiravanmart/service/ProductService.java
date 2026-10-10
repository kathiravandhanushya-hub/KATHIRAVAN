package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dto.ProductDTO;
import com.kathiravan.kathiravanmart.model.Product;

import java.math.BigDecimal;
import java.util.List;

/**
 * Service interface for Product management and catalog browsing.
 */
public interface ProductService {

    /**
     * Creates a product listing for a seller (F2).
     */
    ProductDTO createProduct(Long sellerId, String name, String description, BigDecimal price,
                             Integer stockQty, String category, String imageUrl);

    /**
     * Updates an existing product listing for a seller (F2).
     */
    ProductDTO updateProduct(Long sellerId, Long productId, String name, String description,
                             BigDecimal price, Integer stockQty, String category, String imageUrl);

    /**
     * Deletes a product listing (F2).
     */
    boolean deleteProduct(Long sellerId, Long productId);

    /**
     * Finds a single active product by ID (F3).
     */
    ProductDTO getProductById(Long productId);

    /**
     * Retrieves all active products.
     */
    List<ProductDTO> getAllActiveProducts();

    /**
     * Searches and filters products by keyword and category (F3).
     */
    List<ProductDTO> searchProducts(String keyword, String category);

    /**
     * Retrieves all distinct product categories.
     */
    List<String> getCategories();

    /**
     * Retrieves products listed by a seller (F2/F6).
     */
    List<ProductDTO> getProductsBySeller(Long sellerId);

    /**
     * Moderates (activates or deactivates) a product listing (F7).
     */
    boolean setProductModerationStatus(Long productId, boolean active);

    /**
     * Retrieves all products including moderated ones for admin (F7).
     */
    List<ProductDTO> getAllProductsForAdmin();
}
