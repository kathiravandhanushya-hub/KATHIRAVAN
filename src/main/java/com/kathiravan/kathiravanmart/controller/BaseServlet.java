package com.kathiravan.kathiravanmart.controller;

import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.exception.AppException;
import com.kathiravan.kathiravanmart.exception.ValidationException;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.util.JsonUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Base abstract servlet providing unified JSON responses, error handling,
 * and user session helpers according to Section 13 API standards.
 */
public abstract class BaseServlet extends HttpServlet {
    private static final Logger LOGGER = LoggerFactory.getLogger(BaseServlet.class);

    protected void sendJsonResponse(HttpServletResponse response, int statusCode, ApiResponse<?> apiResponse)
            throws IOException {
        response.setStatus(statusCode);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(JsonUtil.toJson(apiResponse));
    }

    protected void handleException(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws IOException {
        LOGGER.warn("Request error in servlet: {}", e.getMessage());

        boolean isApi = request.getRequestURI().contains("/api/");

        if (e instanceof ValidationException) {
            ValidationException ve = (ValidationException) e;
            if (isApi) {
                sendJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                        ApiResponse.error(ve.getErrorCode(), ve.getMessage(), ve.getFieldErrors()));
            } else {
                request.setAttribute("errorMessage", ve.getMessage());
                request.setAttribute("fieldErrors", ve.getFieldErrors());
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, ve.getMessage());
            }
            return;
        }

        if (e instanceof AppException) {
            AppException ae = (AppException) e;
            if (isApi) {
                sendJsonResponse(response, ae.getStatusCode(), ApiResponse.error(ae.getErrorCode(), ae.getMessage()));
            } else {
                response.sendError(ae.getStatusCode(), ae.getMessage());
            }
            return;
        }

        LOGGER.error("Unhandled server exception: {}", e.getMessage(), e);
        if (isApi) {
            sendJsonResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    ApiResponse.error("INTERNAL_SERVER_ERROR", "An unexpected error occurred."));
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected internal server error occurred.");
        }
    }

    protected User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("currentUser");
        }
        return null;
    }

    protected boolean isJsonRequest(HttpServletRequest request) {
        String accept = request.getHeader("Accept");
        String contentType = request.getContentType();
        String uri = request.getRequestURI();
        return (uri != null && uri.contains("/api/"))
                || (accept != null && accept.contains("application/json"))
                || (contentType != null && contentType.contains("application/json"));
    }
}
