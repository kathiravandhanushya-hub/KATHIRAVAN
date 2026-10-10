package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.dto.ProductDTO;
import com.kathiravan.kathiravanmart.dto.UserResponseDTO;

import java.util.List;
import java.util.Map;

/**
 * Service interface for Admin management and Seller analytics.
 */
public interface AdminService {

    /**
     * Retrieves all users registered in the system (F7).
     */
    List<UserResponseDTO> getAllUsers();

    /**
     * Retrieves all orders across the entire marketplace (F7).
     */
    List<OrderDTO> getAllOrders();

    /**
     * Moderates a product listing (enable/disable visibility) (F7).
     */
    boolean moderateProduct(Long productId, boolean active);

    /**
     * Permanently deletes a listing (F7).
     */
    boolean deleteProduct(Long productId);

    /**
     * Retrieves marketplace summary statistics for the admin panel.
     */
    Map<String, Object> getAdminDashboardStats();

    /**
     * Retrieves seller dashboard metrics: total revenue and orders (O3).
     */
    Map<String, Object> getSellerDashboardStats(Long sellerId);
}
