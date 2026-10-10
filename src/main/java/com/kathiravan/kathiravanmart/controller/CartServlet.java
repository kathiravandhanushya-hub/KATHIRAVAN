package com.kathiravan.kathiravanmart.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.CartItemDTO;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.service.CartService;
import com.kathiravan.kathiravanmart.service.CartServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controller managing cart operations (F4).
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart/*", "/api/v1/cart/*"})
public class CartServlet extends BaseServlet {

    private final CartService cartService;

    public CartServlet() {
        this.cartService = new CartServiceImpl();
    }

    public CartServlet(CartService cartService) {
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

        boolean isApi = isJsonRequest(request);

        try {
            List<CartItemDTO> items = cartService.getCartItems(user.getId());
            BigDecimal runningTotal = cartService.calculateRunningTotal(user.getId());

            if (isApi) {
                Map<String, Object> data = new HashMap<>();
                data.put("items", items);
                data.put("runningTotal", runningTotal);
                sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(data));
            } else {
                request.setAttribute("cartItems", items);
                request.setAttribute("runningTotal", runningTotal);
                request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
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

        String pathInfo = request.getPathInfo();
        String servletPath = request.getServletPath();
        boolean isApi = isJsonRequest(request);

        try {
            if ("/add".equals(pathInfo) || "/items".equals(pathInfo) || "/cart/add".equals(servletPath)) {
                // Add item
                Long productId;
                int quantity = 1;

                if (isApi && request.getContentType() != null && request.getContentType().contains("application/json")) {
                    JsonObject json = parseJson(request);
                    productId = json.get("productId").getAsLong();
                    if (json.has("quantity")) {
                        quantity = json.get("quantity").getAsInt();
                    }
                } else {
                    productId = Long.parseLong(request.getParameter("productId"));
                    if (request.getParameter("quantity") != null) {
                        quantity = Integer.parseInt(request.getParameter("quantity"));
                    }
                }

                CartItemDTO item = cartService.addToCart(user.getId(), productId, quantity);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_CREATED, ApiResponse.success(item));
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart");
                }
            } else if ("/update".equals(pathInfo)) {
                Long cartItemId = Long.parseLong(request.getParameter("cartItemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                cartService.updateCartItemQuantity(user.getId(), cartItemId, quantity);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(true));
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart");
                }
            } else if ("/remove".equals(pathInfo)) {
                Long cartItemId = Long.parseLong(request.getParameter("cartItemId"));
                cartService.removeFromCart(user.getId(), cartItemId);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(true));
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart");
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
