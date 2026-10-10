package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.Review;
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
 * JDBC implementation of ReviewDao.
 */
public class ReviewDaoImpl implements ReviewDao {
    private static final Logger LOGGER = LoggerFactory.getLogger(ReviewDaoImpl.class);
    private final DataSource dataSource;

    public ReviewDaoImpl() {
        this.dataSource = null;
    }

    public ReviewDaoImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private Connection getConnection() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        }
        return DatabaseUtil.getConnection();
    }

    @Override
    public Long create(Review review) {
        String sql = "INSERT INTO reviews (product_id, user_id, rating, comment, created_at) " +
                     "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setLong(1, review.getProductId());
            ps.setLong(2, review.getUserId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    long id = rs.getLong(1);
                    review.setId(id);
                    return id;
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error creating review: {}", e.getMessage(), e);
            throw new RuntimeException("Database error saving review", e);
        }
        return null;
    }

    @Override
    public List<Review> findByProductId(Long productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.id, r.product_id, r.user_id, r.rating, r.comment, r.created_at, " +
                     "       u.name AS user_name, p.name AS product_name " +
                     "FROM reviews r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN products p ON r.product_id = p.id " +
                     "WHERE r.product_id = ? " +
                     "ORDER BY r.created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review r = new Review();
                    r.setId(rs.getLong("id"));
                    r.setProductId(rs.getLong("product_id"));
                    r.setUserId(rs.getLong("user_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getString("comment"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    r.setUserName(rs.getString("user_name"));
                    r.setProductName(rs.getString("product_name"));
                    list.add(r);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding reviews for product {}: {}", productId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving reviews", e);
        }
        return list;
    }

    @Override
    public Optional<Review> findByProductAndUser(Long productId, Long userId) {
        String sql = "SELECT r.id, r.product_id, r.user_id, r.rating, r.comment, r.created_at, " +
                     "       u.name AS user_name, p.name AS product_name " +
                     "FROM reviews r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN products p ON r.product_id = p.id " +
                     "WHERE r.product_id = ? AND r.user_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, productId);
            ps.setLong(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Review r = new Review();
                    r.setId(rs.getLong("id"));
                    r.setProductId(rs.getLong("product_id"));
                    r.setUserId(rs.getLong("user_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setComment(rs.getString("comment"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    r.setUserName(rs.getString("user_name"));
                    r.setProductName(rs.getString("product_name"));
                    return Optional.of(r);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding review: {}", e.getMessage(), e);
            throw new RuntimeException("Database error retrieving review", e);
        }
        return Optional.empty();
    }

    @Override
    public boolean delete(Long id) {
        String sql = "DELETE FROM reviews WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error deleting review {}: {}", id, e.getMessage(), e);
            throw new RuntimeException("Database error deleting review", e);
        }
    }
}
