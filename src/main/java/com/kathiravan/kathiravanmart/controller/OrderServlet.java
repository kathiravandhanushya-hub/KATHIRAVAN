package com.kathiravan.kathiravanmart.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.CartItemDTO;
import com.kathiravan.kathiravanmart.dto.OrderDTO;
import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.service.CartService;
import com.kathiravan.kathiravanmart.service.CartServiceImpl;
import com.kathiravan.kathiravanmart.service.OrderService;
import com.kathiravan.kathiravanmart.service.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * Controller handling checkout, mock payment confirmation, order history, and status updates (F5, F6, O2).
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/orders/*", "/checkout/*", "/api/v1/orders/*"})
public class OrderServlet extends BaseServlet {

    private final OrderService orderService;
    private final CartService cartService;

    public OrderServlet() {
        this.orderService = new OrderServiceImpl();
        this.cartService = new CartServiceImpl();
    }

    public OrderServlet(OrderService orderService, CartService cartService) {
        this.orderService = orderService;
        this.cartService = cartService;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getCurrentUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + request.getRequestURI());
            return;
        }

        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        boolean isApi = isJsonRequest(request);

        try {
            if ("/checkout".equals(servletPath)) {
                // Checkout page
                List<CartItemDTO> cartItems = cartService.getCartItems(user.getId());
                if (cartItems.isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/cart");
                    return;
                }
                BigDecimal total = cartService.calculateRunningTotal(user.getId());
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("runningTotal", total);
                request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
                return;
            }

            if (pathInfo != null && !pathInfo.equals("/")) {
                // Specific order detail: /orders/{id}
                Long orderId = Long.parseLong(pathInfo.substring(1));
                OrderDTO order = orderService.getOrderById(orderId, user.getId(), user.getRole() == Role.ADMIN);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(order));
                } else {
                    request.setAttribute("order", order);
                    request.getRequestDispatcher("/WEB-INF/views/order-detail.jsp").forward(request, response);
                }
            } else {
                // Order history: /orders or /api/v1/orders
                List<OrderDTO> orders;
                if (user.getRole() == Role.SELLER) {
                    orders = orderService.getSellerIncomingOrders(user.getId());
                } else {
                    orders = orderService.getBuyerOrders(user.getId());
                }

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(orders));
                } else {
                    request.setAttribute("orders", orders);
                    request.getRequestDispatcher("/WEB-INF/views/order-history.jsp").forward(request, response);
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
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        boolean isApi = isJsonRequest(request);

        try {
            if ("/checkout".equals(servletPath) || "/api/v1/orders".equals(servletPath) || (pathInfo != null && pathInfo.equals("/create"))) {
                // Place order
                String shippingAddress;
                String paymentMethod = "MOCK_PAYMENT";

                if (isApi && request.getContentType() != null && request.getContentType().contains("application/json")) {
                    JsonObject json = parseJson(request);
                    shippingAddress = json.has("shippingAddress") ? json.get("shippingAddress").getAsString() : null;
                    if (json.has("paymentMethod")) {
                        paymentMethod = json.get("paymentMethod").getAsString();
                    }
                } else {
                    shippingAddress = request.getParameter("shippingAddress");
                    if (request.getParameter("paymentMethod") != null) {
                        paymentMethod = request.getParameter("paymentMethod");
                    }
                }

                OrderDTO order = orderService.checkout(user.getId(), shippingAddress, paymentMethod);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_CREATED, ApiResponse.success(order));
                } else {
                    response.sendRedirect(request.getContextPath() + "/orders?success=true&orderId=" + order.getId());
                }
            } else if (pathInfo != null && pathInfo.endsWith("/status")) {
                // Status update (O2)
                String[] segments = pathInfo.split("/");
                Long orderId = Long.parseLong(segments[1]);
                String newStatus = request.getParameter("status");

                if (newStatus == null && request.getContentType() != null && request.getContentType().contains("application/json")) {
                    JsonObject json = parseJson(request);
                    newStatus = json.get("status").getAsString();
                }

                orderService.updateOrderStatus(orderId, newStatus);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(true));
                } else {
                    response.sendRedirect(request.getContextPath() + "/orders");
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
