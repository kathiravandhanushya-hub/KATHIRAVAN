package com.kathiravan.kathiravanmart.controller;

import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.dto.ProductDTO;
import com.kathiravan.kathiravanmart.dto.UserResponseDTO;
import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.service.AdminService;
import com.kathiravan.kathiravanmart.service.AdminServiceImpl;
import com.kathiravan.kathiravanmart.service.ProductService;
import com.kathiravan.kathiravanmart.service.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Controller for Admin Panel (F7): user directory, global order monitoring, listing moderation.
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin/*", "/api/v1/admin/*"})
public class AdminServlet extends BaseServlet {

    private final AdminService adminService;
    private final ProductService productService;

    public AdminServlet() {
        this.adminService = new AdminServiceImpl();
        this.productService = new ProductServiceImpl();
    }

    public AdminServlet(AdminService adminService, ProductService productService) {
        this.adminService = adminService;
        this.productService = productService;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getCurrentUser(request);
        if (user == null || user.getRole() != Role.ADMIN) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Administrative privileges required.");
            return;
        }

        boolean isApi = isJsonRequest(request);

        try {
            List<UserResponseDTO> users = adminService.getAllUsers();
            List<OrderDTO> orders = adminService.getAllOrders();
            List<ProductDTO> products = productService.getAllProductsForAdmin();
            Map<String, Object> stats = adminService.getAdminDashboardStats();

            if (isApi) {
                java.util.Map<String, Object> data = new java.util.HashMap<>();
                data.put("stats", stats);
                data.put("users", users);
                data.put("orders", orders);
                data.put("products", products);
                sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(data));
            } else {
                request.setAttribute("users", users);
                request.setAttribute("orders", orders);
                request.setAttribute("products", products);
                request.setAttribute("stats", stats);
                request.getRequestDispatcher("/WEB-INF/views/admin-dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getCurrentUser(request);
        if (user == null || user.getRole() != Role.ADMIN) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Administrative privileges required.");
            return;
        }

        String pathInfo = request.getPathInfo();
        boolean isApi = isJsonRequest(request);

        try {
            if ("/moderate".equals(pathInfo)) {
                Long productId = Long.parseLong(request.getParameter("productId"));
                boolean active = Boolean.parseBoolean(request.getParameter("active"));
                adminService.moderateProduct(productId, active);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(true));
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=moderated");
                }
            } else if ("/delete-product".equals(pathInfo)) {
                Long productId = Long.parseLong(request.getParameter("productId"));
                adminService.deleteProduct(productId);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(true));
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=deleted");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }
}
