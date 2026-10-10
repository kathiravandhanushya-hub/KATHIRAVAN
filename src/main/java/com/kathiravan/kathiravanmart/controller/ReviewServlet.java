package com.kathiravan.kathiravanmart.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.ReviewDTO;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.service.ReviewService;
import com.kathiravan.kathiravanmart.service.ReviewServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

/**
 * Controller handling product reviews and ratings on completed orders (F8).
 */
@WebServlet(name = "ReviewServlet", urlPatterns = {"/reviews/*", "/api/v1/reviews/*"})
public class ReviewServlet extends BaseServlet {

    private final ReviewService reviewService;

    public ReviewServlet() {
        this.reviewService = new ReviewServiceImpl();
    }

    public ReviewServlet(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing productId query parameter");
            return;
        }

        try {
            Long productId = Long.parseLong(productIdParam);
            List<ReviewDTO> reviews = reviewService.getReviewsByProduct(productId);
            sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(reviews));
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

        boolean isApi = isJsonRequest(request);

        try {
            Long productId;
            int rating;
            String comment;

            if (isApi && request.getContentType() != null && request.getContentType().contains("application/json")) {
                JsonObject json = parseJson(request);
                productId = json.get("productId").getAsLong();
                rating = json.get("rating").getAsInt();
                comment = json.has("comment") ? json.get("comment").getAsString() : "";
            } else {
                productId = Long.parseLong(request.getParameter("productId"));
                rating = Integer.parseInt(request.getParameter("rating"));
                comment = request.getParameter("comment");
            }

            ReviewDTO createdReview = reviewService.addReview(user.getId(), productId, rating, comment);

            if (isApi) {
                sendJsonResponse(response, HttpServletResponse.SC_CREATED, ApiResponse.success(createdReview));
            } else {
                response.sendRedirect(request.getContextPath() + "/products/" + productId + "?reviewed=true");
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
