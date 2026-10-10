package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.WishlistItem;
import com.kathiravan.kathiravanmart.util.DatabaseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * JDBC implementation of WishlistDao.
 */
public class WishlistDaoImpl implements WishlistDao {
    private static final Logger LOGGER = LoggerFactory.getLogger(WishlistDaoImpl.class);
    private final DataSource dataSource;

    public WishlistDaoImpl() {
        this.dataSource = null;
    }

    public WishlistDaoImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private Connection getConnection() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        }
        return DatabaseUtil.getConnection();
    }

    @Override
    public Long addItem(Long userId, Long productId) {
        if (exists(userId, productId)) {
            return null;
        }

        String sql = "INSERT INTO wishlist_items (user_id, product_id, created_at) VALUES (?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setLong(1, userId);
            ps.setLong(2, productId);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error adding to wishlist: {}", e.getMessage(), e);
            throw new RuntimeException("Database error adding to wishlist", e);
        }
        return null;
    }

    @Override
    public boolean removeItem(Long userId, Long productId) {
        String sql = "DELETE FROM wishlist_items WHERE user_id = ? AND product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            ps.setLong(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error removing from wishlist: {}", e.getMessage(), e);
            throw new RuntimeException("Database error removing from wishlist", e);
        }
    }

    @Override
    public List<WishlistItem> findByUserId(Long userId) {
        List<WishlistItem> list = new ArrayList<>();
        String sql = "SELECT w.id, w.user_id, w.product_id, w.created_at, " +
                     "       p.name AS product_name, p.price AS product_price, p.image_url, p.category, p.stock_qty " +
                     "FROM wishlist_items w " +
                     "JOIN products p ON w.product_id = p.id " +
                     "WHERE w.user_id = ? " +
                     "ORDER BY w.created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    WishlistItem item = new WishlistItem();
                    item.setId(rs.getLong("id"));
                    item.setUserId(rs.getLong("user_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setCreatedAt(rs.getTimestamp("created_at"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductPrice(rs.getBigDecimal("product_price"));
                    item.setProductImage(rs.getString("image_url"));
                    item.setCategory(rs.getString("category"));
                    item.setStockQty(rs.getInt("stock_qty"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error retrieving wishlist for user {}: {}", userId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving wishlist", e);
        }
        return list;
    }

    @Override
    public boolean exists(Long userId, Long productId) {
        String sql = "SELECT COUNT(*) FROM wishlist_items WHERE user_id = ? AND product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            ps.setLong(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error checking wishlist existence: {}", e.getMessage(), e);
        }
        return false;
    }
}
