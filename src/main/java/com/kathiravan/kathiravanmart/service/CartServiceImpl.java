package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.CartDao;
import com.kathiravan.kathiravanmart.dao.ProductDao;
import com.kathiravan.kathiravanmart.dto.CartItemDTO;
import com.kathiravan.kathiravanmart.exception.ResourceNotFoundException;
import com.kathiravan.kathiravanmart.exception.ValidationException;
import com.kathiravan.kathiravanmart.factory.DaoFactory;
import com.kathiravan.kathiravanmart.model.CartItem;
import com.kathiravan.kathiravanmart.model.Product;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Implementation of CartService.
 */
public class CartServiceImpl implements CartService {

    private final CartDao cartDao;
    private final ProductDao productDao;

    public CartServiceImpl() {
        this.cartDao = DaoFactory.getCartDao();
        this.productDao = DaoFactory.getProductDao();
    }

    public CartServiceImpl(CartDao cartDao, ProductDao productDao) {
        this.cartDao = cartDao;
        this.productDao = productDao;
    }

    @Override
    public CartItemDTO addToCart(Long userId, Long productId, int quantity) {
        if (quantity <= 0) {
            throw new ValidationException("quantity", "Quantity must be at least 1");
        }

        Product product = productDao.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with ID " + productId));

        if (!Boolean.TRUE.equals(product.getIsActive())) {
            throw new ValidationException("product", "This product is currently inactive and cannot be ordered");
        }

        if (product.getStockQty() < quantity) {
            throw new ValidationException("quantity", "Requested quantity exceeds available stock (" + product.getStockQty() + " available)");
        }

        Long cartItemId = cartDao.addItem(userId, productId, quantity);
        CartItem item = cartDao.findById(cartItemId)
                .orElse(new CartItem(cartItemId, userId, productId, quantity, null));
        return CartItemDTO.fromEntity(item);
    }

    @Override
    public boolean updateCartItemQuantity(Long userId, Long cartItemId, int quantity) {
        if (quantity <= 0) {
            return removeFromCart(userId, cartItemId);
        }

        CartItem item = cartDao.findById(cartItemId)
                .orElseThrow(() -> new ResourceNotFoundException("Cart item not found"));

        if (!item.getUserId().equals(userId)) {
            throw new ValidationException("cart", "Item does not belong to your cart");
        }

        Product product = productDao.findById(item.getProductId())
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        if (product.getStockQty() < quantity) {
            throw new ValidationException("quantity", "Requested quantity exceeds available stock (" + product.getStockQty() + " available)");
        }

        return cartDao.updateQuantity(cartItemId, quantity);
    }

    @Override
    public boolean removeFromCart(Long userId, Long cartItemId) {
        return cartDao.removeItem(cartItemId, userId);
    }

    @Override
    public boolean clearCart(Long userId) {
        return cartDao.clearCart(userId);
    }

    @Override
    public List<CartItemDTO> getCartItems(Long userId) {
        return cartDao.findByUserId(userId).stream()
                .map(CartItemDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public BigDecimal calculateRunningTotal(Long userId) {
        List<CartItem> items = cartDao.findByUserId(userId);
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
}
