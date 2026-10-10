package com.kathiravan.kathiravanmart.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.dto.ProductDTO;
import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.service.AdminService;
import com.kathiravan.kathiravanmart.service.AdminServiceImpl;
import com.kathiravan.kathiravanmart.service.OrderService;
import com.kathiravan.kathiravanmart.service.OrderServiceImpl;
import com.kathiravan.kathiravanmart.service.ProductService;
import com.kathiravan.kathiravanmart.service.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Controller for Seller Dashboard, Listing Management, and Incoming Orders (F2, F6, O3).
 */
@WebServlet(name = "SellerServlet", urlPatterns = {"/seller/*", "/api/v1/seller/*"})
public class SellerServlet extends BaseServlet {

    private final ProductService productService;
    private final OrderService orderService;
    private final AdminService adminService;

    public SellerServlet() {
        this.productService = new ProductServiceImpl();
        this.orderService = new OrderServiceImpl();
        this.adminService = new AdminServiceImpl();
    }

    public SellerServlet(ProductService productService, OrderService orderService, AdminService adminService) {
        this.productService = productService;
        this.orderService = orderService;
        this.adminService = adminService;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getCurrentUser(request);
        if (user == null || (user.getRole() != Role.SELLER && user.getRole() != Role.ADMIN)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Seller access required.");
            return;
        }

        String pathInfo = request.getPathInfo();
        boolean isApi = isJsonRequest(request);

        try {
            if ("/orders".equals(pathInfo)) {
                // Incoming orders for seller products (F6)
                List<OrderDTO> incomingOrders = orderService.getSellerIncomingOrders(user.getId());
                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(incomingOrders));
                } else {
                    request.setAttribute("orders", incomingOrders);
                    request.getRequestDispatcher("/WEB-INF/views/order-history.jsp").forward(request, response);
                }
            } else {
                // Seller Dashboard (F2, O3)
                List<ProductDTO> products = productService.getProductsBySeller(user.getId());
                Map<String, Object> metrics = adminService.getSellerDashboardStats(user.getId());
                List<OrderDTO> incomingOrders = orderService.getSellerIncomingOrders(user.getId());

                if (isApi) {
                    JsonObject data = new JsonObject();
                    data.add("metrics", com.kathiravan.kathiravanmart.util.JsonUtil.getGson().toJsonTree(metrics));
                    data.add("products", com.kathiravan.kathiravanmart.util.JsonUtil.getGson().toJsonTree(products));
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(data));
                } else {
                    request.setAttribute("products", products);
                    request.setAttribute("metrics", metrics);
                    request.setAttribute("incomingOrders", incomingOrders);
                    request.getRequestDispatcher("/WEB-INF/views/seller-dashboard.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getCurrentUser(request);
        if (user == null || (user.getRole() != Role.SELLER && user.getRole() != Role.ADMIN)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Seller access required.");
            return;
        }

        String pathInfo = request.getPathInfo();
        boolean isApi = isJsonRequest(request);

        try {
            if ("/products".equals(pathInfo) || "/products/create".equals(pathInfo)) {
                // Create product (F2)
                String name;
                String description;
                BigDecimal price;
                int stockQty;
                String category;
                String imageUrl;

                if (isApi && request.getContentType() != null && request.getContentType().contains("application/json")) {
                    JsonObject json = parseJson(request);
                    name = json.get("name").getAsString();
                    description = json.has("description") ? json.get("description").getAsString() : "";
                    price = json.get("price").getAsBigDecimal();
                    stockQty = json.get("stockQty").getAsInt();
                    category = json.get("category").getAsString();
                    imageUrl = json.has("imageUrl") ? json.get("imageUrl").getAsString() : "";
                } else {
                    name = request.getParameter("name");
                    description = request.getParameter("description");
                    price = new BigDecimal(request.getParameter("price"));
                    stockQty = Integer.parseInt(request.getParameter("stockQty"));
                    category = request.getParameter("category");
                    imageUrl = request.getParameter("imageUrl");
                }

                ProductDTO created = productService.createProduct(user.getId(), name, description, price, stockQty, category, imageUrl);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_CREATED, ApiResponse.success(created));
                } else {
                    response.sendRedirect(request.getContextPath() + "/seller/dashboard?success=created");
                }
            } else if ("/products/update".equals(pathInfo)) {
                // Edit product (F2)
                Long productId = Long.parseLong(request.getParameter("productId"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                BigDecimal price = new BigDecimal(request.getParameter("price"));
                int stockQty = Integer.parseInt(request.getParameter("stockQty"));
                String category = request.getParameter("category");
                String imageUrl = request.getParameter("imageUrl");

                ProductDTO updated = productService.updateProduct(user.getId(), productId, name, description, price, stockQty, category, imageUrl);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(updated));
                } else {
                    response.sendRedirect(request.getContextPath() + "/seller/dashboard?success=updated");
                }
            } else if ("/products/delete".equals(pathInfo)) {
                // Delete product (F2)
                Long productId = Long.parseLong(request.getParameter("productId"));
                productService.deleteProduct(user.getId(), productId);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(true));
                } else {
                    response.sendRedirect(request.getContextPath() + "/seller/dashboard?success=deleted");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }

    private JsonObject parseJson(HttpServletRequest request) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        return JsonParser.parseString(sb.length() > 0 ? sb.toString() : "{}").getAsJsonObject();
    }
}
