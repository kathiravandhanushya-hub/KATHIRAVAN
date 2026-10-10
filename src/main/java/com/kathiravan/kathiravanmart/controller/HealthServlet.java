package com.kathiravan.kathiravanmart.controller;

import com.kathiravan.kathiravanmart.util.DatabaseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Health check endpoint as required by Section 18.
 * GET /api/v1/health returns { "status": "UP", "db": "UP" }.
 */
@WebServlet(name = "HealthServlet", urlPatterns = {"/api/v1/health"})
public class HealthServlet extends BaseServlet {
    private static final Logger LOGGER = LoggerFactory.getLogger(HealthServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        boolean dbUp = false;
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT 1");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                dbUp = true;
            }
        } catch (SQLException e) {
            LOGGER.error("Health check database probe failed: {}", e.getMessage());
        }

        if (dbUp) {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"status\": \"UP\", \"db\": \"UP\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            response.getWriter().write("{\"status\": \"DOWN\", \"db\": \"DOWN\"}");
        }
    }
}
