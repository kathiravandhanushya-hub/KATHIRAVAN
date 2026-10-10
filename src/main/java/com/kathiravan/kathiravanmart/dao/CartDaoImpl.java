package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.CartItem;
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
import java.util.Optional;

/**
 * JDBC implementation of CartDao.
 */
public class CartDaoImpl implements CartDao {
    private static final Logger LOGGER = LoggerFactory.getLogger(CartDaoImpl.class);
    private final DataSource dataSource;

    public CartDaoImpl() {
        this.dataSource = null;
    }

    public CartDaoImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private Connection getConnection() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        }
        return DatabaseUtil.getConnection();
    }

    @Override
    public Long addItem(Long userId, Long productId, int quantity) {
        Optional<CartItem> existing = findByUserAndProduct(userId, productId);
        if (existing.isPresent()) {
            CartItem item = existing.get();
            int newQty = item.getQuantity() + quantity;
            updateQuantity(item.getId(), newQty);
            return item.getId();
        }

        String sql = "INSERT INTO cart_items (user_id, product_id, quantity, created_at) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setLong(1, userId);
            ps.setLong(2, productId);
            ps.setInt(3, quantity);

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error adding item to cart: {}", e.getMessage(), e);
            throw new RuntimeException("Database error adding to cart", e);
        }
        return null;
    }

    @Override
    public boolean updateQuantity(Long cartItemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setLong(2, cartItemId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error updating cart item quantity {}: {}", cartItemId, e.getMessage(), e);
            throw new RuntimeException("Database error updating cart item", e);
        }
    }

    @Override
    public boolean removeItem(Long cartItemId, Long userId) {
        String sql = "DELETE FROM cart_items WHERE id = ? AND user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, cartItemId);
            ps.setLong(2, userId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error removing cart item {}: {}", cartItemId, e.getMessage(), e);
            throw new RuntimeException("Database error removing cart item", e);
        }
    }

    @Override
    public boolean clearCart(Long userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            LOGGER.error("Error clearing cart for user {}: {}", userId, e.getMessage(), e);
            throw new RuntimeException("Database error clearing cart", e);
        }
    }

    @Override
    public List<CartItem> findByUserId(Long userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT c.id, c.user_id, c.product_id, c.quantity, c.created_at, " +
                     "       p.name AS product_name, p.price AS product_price, p.image_url, p.stock_qty, p.category " +
                     "FROM cart_items c " +
                     "JOIN products p ON c.product_id = p.id " +
                     "WHERE c.user_id = ? " +
                     "ORDER BY c.created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getLong("id"));
                    item.setUserId(rs.getLong("user_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setCreatedAt(rs.getTimestamp("created_at"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductPrice(rs.getBigDecimal("product_price"));
                    item.setProductImage(rs.getString("image_url"));
                    item.setStockQty(rs.getInt("stock_qty"));
                    item.setCategory(rs.getString("category"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding cart items for user {}: {}", userId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving cart", e);
        }
        return list;
    }

    @Override
    public Optional<CartItem> findById(Long cartItemId) {
        String sql = "SELECT c.id, c.user_id, c.product_id, c.quantity, c.created_at, " +
                     "       p.name AS product_name, p.price AS product_price, p.image_url, p.stock_qty, p.category " +
                     "FROM cart_items c " +
                     "JOIN products p ON c.product_id = p.id " +
                     "WHERE c.id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, cartItemId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getLong("id"));
                    item.setUserId(rs.getLong("user_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setCreatedAt(rs.getTimestamp("created_at"));
                    item.setProductName(rs.getString("product_name"));
                    item.setProductPrice(rs.getBigDecimal("product_price"));
                    item.setProductImage(rs.getString("image_url"));
                    item.setStockQty(rs.getInt("stock_qty"));
                    item.setCategory(rs.getString("category"));
                    return Optional.of(item);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding cart item {}: {}", cartItemId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving cart item", e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<CartItem> findByUserAndProduct(Long userId, Long productId) {
        String sql = "SELECT id, user_id, product_id, quantity, created_at FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, userId);
            ps.setLong(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getLong("id"));
                    item.setUserId(rs.getLong("user_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setCreatedAt(rs.getTimestamp("created_at"));
                    return Optional.of(item);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding cart item by user {} and product {}: {}", userId, productId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving cart item", e);
        }
        return Optional.empty();
    }
}
