package com.kathiravan.kathiravanmart.controller;

import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.ProductDTO;
import com.kathiravan.kathiravanmart.dto.ReviewDTO;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.service.ProductService;
import com.kathiravan.kathiravanmart.service.ProductServiceImpl;
import com.kathiravan.kathiravanmart.service.ReviewService;
import com.kathiravan.kathiravanmart.service.ReviewServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for product browsing, searching, filtering, and detail views.
 * Serves both server-rendered JSP views and REST API JSON responses.
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/products/*", "/api/v1/products/*"})
public class ProductServlet extends BaseServlet {

    private final ProductService productService;
    private final ReviewService reviewService;

    public ProductServlet() {
        this.productService = new ProductServiceImpl();
        this.reviewService = new ReviewServiceImpl();
    }

    public ProductServlet(ProductService productService, ReviewService reviewService) {
        this.productService = productService;
        this.reviewService = reviewService;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        String pathInfo = request.getPathInfo();
        boolean isApi = isJsonRequest(request);

        try {
            if (pathInfo != null && !pathInfo.equals("/")) {
                // Product detail request: /products/{id} or /api/v1/products/{id}
                String idStr = pathInfo.substring(1);
                Long productId = Long.parseLong(idStr);
                ProductDTO product = productService.getProductById(productId);
                List<ReviewDTO> reviews = reviewService.getReviewsByProduct(productId);

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(product));
                } else {
                    User user = getCurrentUser(request);
                    boolean eligibleToReview = false;
                    if (user != null) {
                        eligibleToReview = reviewService.isEligibleToReview(user.getId(), productId);
                    }
                    request.setAttribute("product", product);
                    request.setAttribute("reviews", reviews);
                    request.setAttribute("eligibleToReview", eligibleToReview);
                    request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(request, response);
                }
            } else {
                // Catalog browsing / search: /products or /api/v1/products
                String keyword = request.getParameter("q");
                String category = request.getParameter("category");

                List<ProductDTO> products;
                if ((keyword != null && !keyword.trim().isEmpty()) || (category != null && !category.trim().isEmpty())) {
                    products = productService.searchProducts(keyword, category);
                } else {
                    products = productService.getAllActiveProducts();
                }

                List<String> categories = productService.getCategories();

                if (isApi) {
                    sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(products));
                } else {
                    request.setAttribute("products", products);
                    request.setAttribute("categories", categories);
                    request.setAttribute("selectedCategory", category != null ? category : "ALL");
                    request.setAttribute("searchKeyword", keyword != null ? keyword : "");
                    request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }
}
