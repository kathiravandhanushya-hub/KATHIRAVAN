package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.OrderDao;
import com.kathiravan.kathiravanmart.dao.ProductDao;
import com.kathiravan.kathiravanmart.dao.UserDao;
import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.dto.ProductDTO;
import com.kathiravan.kathiravanmart.dto.UserResponseDTO;
import com.kathiravan.kathiravanmart.factory.DaoFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Implementation of AdminService.
 */
public class AdminServiceImpl implements AdminService {

    private final UserDao userDao;
    private final ProductDao productDao;
    private final OrderDao orderDao;

    public AdminServiceImpl() {
        this.userDao = DaoFactory.getUserDao();
        this.productDao = DaoFactory.getProductDao();
        this.orderDao = DaoFactory.getOrderDao();
    }

    public AdminServiceImpl(UserDao userDao, ProductDao productDao, OrderDao orderDao) {
        this.userDao = userDao;
        this.productDao = productDao;
        this.orderDao = orderDao;
    }

    @Override
    public List<UserResponseDTO> getAllUsers() {
        return userDao.findAll().stream()
                .map(UserResponseDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public List<OrderDTO> getAllOrders() {
        return orderDao.findAll().stream()
                .map(OrderDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    public boolean moderateProduct(Long productId, boolean active) {
        return productDao.setActiveStatus(productId, active);
    }

    @Override
    public boolean deleteProduct(Long productId) {
        return productDao.delete(productId);
    }

    @Override
    public Map<String, Object> getAdminDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", userDao.count());
        stats.put("activeProducts", productDao.countActive());
        Map<String, Object> orderStats = orderDao.getAdminMetrics();
        stats.put("totalRevenue", orderStats.getOrDefault("totalRevenue", 0));
        stats.put("totalOrders", orderStats.getOrDefault("totalOrders", 0));
        return stats;
    }

    @Override
    public Map<String, Object> getSellerDashboardStats(Long sellerId) {
        return orderDao.getSellerMetrics(sellerId);
    }
}
