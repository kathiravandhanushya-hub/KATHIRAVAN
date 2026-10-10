package com.kathiravan.kathiravanmart.controller;

import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.model.WishlistItem;
import com.kathiravan.kathiravanmart.service.WishlistService;
import com.kathiravan.kathiravanmart.service.WishlistServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for Wishlist / Save-for-later management (Feature O1).
 */
@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist/*", "/api/v1/wishlist/*"})
public class WishlistServlet extends BaseServlet {

    private final WishlistService wishlistService;

    public WishlistServlet() {
        this.wishlistService = new WishlistServiceImpl();
    }

    public WishlistServlet(WishlistService wishlistService) {
        this.wishlistService = wishlistService;
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
            List<WishlistItem> items = wishlistService.getWishlist(user.getId());
            if (isApi) {
                sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(items));
            } else {
                request.setAttribute("wishlistItems", items);
                request.getRequestDispatcher("/WEB-INF/views/wishlist.jsp").forward(request, response);
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
        boolean isApi = isJsonRequest(request);

        try {
            Long productId = Long.parseLong(request.getParameter("productId"));

            if ("/remove".equals(pathInfo)) {
                wishlistService.removeFromWishlist(user.getId(), productId);
            } else {
                wishlistService.addToWishlist(user.getId(), productId);
            }

            if (isApi) {
                sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(true));
            } else {
                response.sendRedirect(request.getContextPath() + "/wishlist");
            }
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }
}
