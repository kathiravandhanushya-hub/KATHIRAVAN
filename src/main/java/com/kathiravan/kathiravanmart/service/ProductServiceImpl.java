package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.ProductDao;
import com.kathiravan.kathiravanmart.dto.ProductDTO;
import com.kathiravan.kathiravanmart.exception.ResourceNotFoundException;
import com.kathiravan.kathiravanmart.exception.UnauthorizedException;
import com.kathiravan.kathiravanmart.factory.DaoFactory;
import com.kathiravan.kathiravanmart.model.Product;
import com.kathiravan.kathiravanmart.util.ValidationUtil;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of ProductService.
 */
public class ProductServiceImpl implements ProductService {

    private final ProductDao productDao;

    public ProductServiceImpl() {
        this.productDao = DaoFactory.getProductDao();
    }

    public ProductServiceImpl(ProductDao productDao) {
        this.productDao = productDao;
    }

    @Override
    public ProductDTO createProduct(Long sellerId, String name, String description, BigDecimal price,
                                     Integer stockQty, String category, String imageUrl) {
        // Validation at top of service method
        ValidationUtil.validateProduct(name, description, price, stockQty, category);

        Product p = new Product();
        p.setSellerId(sellerId);
        p.setName(name.trim());
        p.setDescription(description != null ? description.trim() : "");
        p.setPrice(price);
        p.setStockQty(stockQty);
        p.setCategory(category.trim());
        p.setImageUrl(imageUrl != null && !imageUrl.trim().isEmpty() ? imageUrl.trim() : "https://via.placeholder.com/300?text=No+Image");
        p.setIsActive(true);

        Long id = productDao.create(p);
        p.setId(id);
        return ProductDTO.fromEntity(p);
    }

    @Override
    public ProductDTO updateProduct(Long sellerId, Long productId, String name, String description,
                                     BigDecimal price, Integer stockQty, String category, String imageUrl) {
        // Validation at top of service method
        ValidationUtil.validateProduct(name, description, price, stockQty, category);

        Product existing = productDao.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID " + productId));

        if (!existing.getSellerId().equals(sellerId)) {
            throw new UnauthorizedException("You are not authorized to update this product listing");
        }

        existing.setName(name.trim());
        existing.setDescription(description != null ? description.trim() : "");
        existing.setPrice(price);
        existing.setStockQty(stockQty);
        existing.setCategory(category.trim());
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            existing.setImageUrl(imageUrl.trim());
        }

        productDao.update(existing);
        return ProductDTO.fromEntity(existing);
    }

    @Override
    public boolean deleteProduct(Long sellerId, Long productId) {
        Product existing = productDao.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID " + productId));

        if (!existing.getSellerId().equals(sellerId)) {
            throw new UnauthorizedException("You are not authorized to delete this product");
        }

        return productDao.delete(productId);
    }

    @Override
    public ProductDTO getProductById(Long productId) {
        Product p = productDao.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID " + productId));
        return ProductDTO.fromEntity(p);
    }

    @Override
    public List<ProductDTO> getAllActiveProducts() {
        return productDao.findAllActive().stream()
                .map(ProductDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public List<ProductDTO> searchProducts(String keyword, String category) {
        return productDao.searchAndFilter(keyword, category).stream()
                .map(ProductDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public List<String> getCategories() {
        return productDao.findDistinctCategories();
    }

    @Override
    public List<ProductDTO> getProductsBySeller(Long sellerId) {
        return productDao.findBySellerId(sellerId).stream()
                .map(ProductDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public boolean setProductModerationStatus(Long productId, boolean active) {
        productDao.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID " + productId));
        return productDao.setActiveStatus(productId, active);
    }

    @Override
    public List<ProductDTO> getAllProductsForAdmin() {
        return productDao.findAll().stream()
                .map(ProductDTO::fromEntity)
                .collect(Collectors.toList());
    }
}
