package com.kathiravan.kathiravanmart.filter;

import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.util.JsonUtil;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication and Authorization Filter.
 * Strictly implements Section 9 Security Checklist:
 * "All protected servlets enforce session checks via AuthFilter."
 */
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        User currentUser = session != null ? (User) session.getAttribute("currentUser") : null;

        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = uri.substring(contextPath.length());
        boolean isApi = path.startsWith("/api/");

        // 1. Check if user is authenticated
        if (currentUser == null) {
            if (isApi) {
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.setContentType("application/json");
                httpResponse.getWriter().write(JsonUtil.toJson(
                        ApiResponse.error("UNAUTHENTICATED", "Authentication is required to access this resource.")
                ));
            } else {
                httpResponse.sendRedirect(contextPath + "/login?redirect=" + httpRequest.getRequestURI());
            }
            return;
        }

        // 2. Check Role-based authorization
        Role userRole = currentUser.getRole();

        // Admin route guard
        if (path.startsWith("/admin") || path.startsWith("/api/v1/admin")) {
            if (userRole != Role.ADMIN) {
                handleForbidden(httpRequest, httpResponse, isApi, contextPath);
                return;
            }
        }

        // Seller route guard
        if (path.startsWith("/seller") || path.startsWith("/api/v1/seller")) {
            if (userRole != Role.SELLER && userRole != Role.ADMIN) {
                handleForbidden(httpRequest, httpResponse, isApi, contextPath);
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private void handleForbidden(HttpServletRequest request, HttpServletResponse response, boolean isApi, String contextPath)
            throws IOException {
        if (isApi) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.setContentType("application/json");
            response.getWriter().write(JsonUtil.toJson(
                    ApiResponse.error("FORBIDDEN", "You do not have permission to perform this action.")
            ));
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Insufficient permissions.");
        }
    }

    @Override
    public void destroy() {
    }
}
