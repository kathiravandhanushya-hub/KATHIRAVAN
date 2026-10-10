package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.ProductDao;
import com.kathiravan.kathiravanmart.dao.WishlistDao;
import com.kathiravan.kathiravanmart.exception.ResourceNotFoundException;
import com.kathiravan.kathiravanmart.factory.DaoFactory;
import com.kathiravan.kathiravanmart.model.WishlistItem;

import java.util.List;

/**
 * Implementation of WishlistService.
 */
public class WishlistServiceImpl implements WishlistService {

    private final WishlistDao wishlistDao;
    private final ProductDao productDao;

    public WishlistServiceImpl() {
        this.wishlistDao = DaoFactory.getWishlistDao();
        this.productDao = DaoFactory.getProductDao();
    }

    public WishlistServiceImpl(WishlistDao wishlistDao, ProductDao productDao) {
        this.wishlistDao = wishlistDao;
        this.productDao = productDao;
    }

    @Override
    public boolean addToWishlist(Long userId, Long productId) {
        productDao.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        return wishlistDao.addItem(userId, productId) != null;
    }

    @Override
    public boolean removeFromWishlist(Long userId, Long productId) {
        return wishlistDao.removeItem(userId, productId);
    }

    @Override
    public List<WishlistItem> getWishlist(Long userId) {
        return wishlistDao.findByUserId(userId);
    }

    @Override
    public boolean isInWishlist(Long userId, Long productId) {
        return wishlistDao.exists(userId, productId);
    }
}
