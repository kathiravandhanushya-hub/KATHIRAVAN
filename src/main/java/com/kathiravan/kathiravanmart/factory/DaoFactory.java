package com.kathiravan.kathiravanmart.factory;

import com.kathiravan.kathiravanmart.dao.*;

/**
 * Factory pattern implementation for producing DAO instances.
 * Satisfies Section 12 Design Patterns requirement.
 */
public final class DaoFactory {

    private static final UserDao USER_DAO = new UserDaoImpl();
    private static final ProductDao PRODUCT_DAO = new ProductDaoImpl();
    private static final CartDao CART_DAO = new CartDaoImpl();
    private static final OrderDao ORDER_DAO = new OrderDaoImpl();
    private static final ReviewDao REVIEW_DAO = new ReviewDaoImpl();
    private static final WishlistDao WISHLIST_DAO = new WishlistDaoImpl();

    private DaoFactory() {
    }

    public static UserDao getUserDao() {
        return USER_DAO;
    }

    public static ProductDao getProductDao() {
        return PRODUCT_DAO;
    }

    public static CartDao getCartDao() {
        return CART_DAO;
    }

    public static OrderDao getOrderDao() {
        return ORDER_DAO;
    }

    public static ReviewDao getReviewDao() {
        return REVIEW_DAO;
    }

    public static WishlistDao getWishlistDao() {
        return WISHLIST_DAO;
    }
}
