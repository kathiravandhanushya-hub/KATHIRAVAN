package com.kathiravan.kathiravanmart.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.UserResponseDTO;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.service.AuthService;
import com.kathiravan.kathiravanmart.service.AuthServiceImpl;
import com.kathiravan.kathiravanmart.util.ConfigUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;

/**
 * Controller handling user registration, authentication, session regeneration, and logout.
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/auth/*", "/login", "/register", "/logout", "/api/v1/auth/*"})
public class AuthServlet extends BaseServlet {

    private final AuthService authService;

    public AuthServlet() {
        this.authService = new AuthServiceImpl();
    }

    public AuthServlet(AuthService authService) {
        this.authService = authService;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        String pathInfo = request.getPathInfo();

        if ("/logout".equals(path) || (pathInfo != null && pathInfo.equals("/logout"))) {
            handleLogout(request, response);
            return;
        }

        if ("/login".equals(path)) {
            if (getCurrentUser(request) != null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        if ("/register".equals(path)) {
            if (getCurrentUser(request) != null) {
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }

        if (path.startsWith("/api/v1/auth") && "/me".equals(pathInfo)) {
            User current = getCurrentUser(request);
            if (current == null) {
                sendJsonResponse(response, HttpServletResponse.SC_UNAUTHORIZED,
                        ApiResponse.error("UNAUTHENTICATED", "No active session found"));
                return;
            }
            sendJsonResponse(response, HttpServletResponse.SC_OK,
                    ApiResponse.success(UserResponseDTO.fromEntity(current)));
            return;
        }

        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        String pathInfo = request.getPathInfo();
        boolean isApi = isJsonRequest(request);

        try {
            if ("/login".equals(path) || (path.startsWith("/api/v1/auth") && "/login".equals(pathInfo))) {
                handleLogin(request, response, isApi);
            } else if ("/register".equals(path) || (path.startsWith("/api/v1/auth") && "/register".equals(pathInfo))) {
                handleRegister(request, response, isApi);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleException(request, response, e);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response, boolean isApi)
            throws IOException, ServletException {
        String email;
        String password;

        if (isApi && request.getContentType() != null && request.getContentType().contains("application/json")) {
            JsonObject json = parseJsonBody(request);
            email = json.has("email") ? json.get("email").getAsString() : null;
            password = json.has("password") ? json.get("password").getAsString() : null;
        } else {
            email = request.getParameter("email");
            password = request.getParameter("password");
        }

        try {
            User user = authService.login(email, password);

            // Regenerate session ID on login (Section 4 Rule 3)
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession newSession = request.getSession(true);
            int timeoutMinutes = ConfigUtil.getInt("app.session.timeoutMinutes", 30);
            newSession.setMaxInactiveInterval(timeoutMinutes * 60);
            newSession.setAttribute("currentUser", user);

            UserResponseDTO responseDto = UserResponseDTO.fromEntity(user);

            if (isApi) {
                sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(responseDto));
            } else {
                String redirect = request.getParameter("redirect");
                if (redirect != null && !redirect.trim().isEmpty() && !redirect.contains("login") && !redirect.contains("register")) {
                    response.sendRedirect(redirect);
                } else if (user.getRole() == com.kathiravan.kathiravanmart.model.Role.SELLER) {
                    response.sendRedirect(request.getContextPath() + "/seller/dashboard");
                } else if (user.getRole() == com.kathiravan.kathiravanmart.model.Role.ADMIN) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/products");
                }
            }
        } catch (Exception e) {
            if (isApi) {
                throw e;
            } else {
                request.setAttribute("errorMessage", e.getMessage());
                request.setAttribute("email", email);
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response, boolean isApi)
            throws IOException, ServletException {
        String name;
        String email;
        String password;
        String role;

        if (isApi && request.getContentType() != null && request.getContentType().contains("application/json")) {
            JsonObject json = parseJsonBody(request);
            name = json.has("name") ? json.get("name").getAsString() : null;
            email = json.has("email") ? json.get("email").getAsString() : null;
            password = json.has("password") ? json.get("password").getAsString() : null;
            role = json.has("role") ? json.get("role").getAsString() : "BUYER";
        } else {
            name = request.getParameter("name");
            email = request.getParameter("email");
            password = request.getParameter("password");
            role = request.getParameter("role");
        }

        try {
            UserResponseDTO createdUser = authService.register(name, email, password, role);

            if (isApi) {
                sendJsonResponse(response, HttpServletResponse.SC_CREATED, ApiResponse.success(createdUser));
            } else {
                request.setAttribute("successMessage", "Registration successful! Please sign in with your credentials.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            if (isApi) {
                throw e;
            } else {
                request.setAttribute("errorMessage", e.getMessage());
                request.setAttribute("name", name);
                request.setAttribute("email", email);
                request.setAttribute("role", role);
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            }
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        if (isJsonRequest(request)) {
            sendJsonResponse(response, HttpServletResponse.SC_OK,
                    ApiResponse.success("Successfully logged out"));
        } else {
            response.sendRedirect(request.getContextPath() + "/login?loggedOut=true");
        }
    }

    private JsonObject parseJsonBody(HttpServletRequest request) throws IOException {
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
