package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.Product;
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
 * JDBC implementation of ProductDao.
 * Strictly adheres to PreparedStatement only and try-with-resources.
 */
public class ProductDaoImpl implements ProductDao {
    private static final Logger LOGGER = LoggerFactory.getLogger(ProductDaoImpl.class);
    private final DataSource dataSource;

    public ProductDaoImpl() {
        this.dataSource = null;
    }

    public ProductDaoImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private Connection getConnection() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        }
        return DatabaseUtil.getConnection();
    }

    private static final String BASE_SELECT =
            "SELECT p.id, p.seller_id, p.name, p.description, p.price, p.stock_qty, p.category, " +
            "       p.image_url, p.is_active, p.created_at, u.name AS seller_name, " +
            "       COALESCE(AVG(r.rating), 0.0) AS avg_rating, COUNT(r.id) AS review_count " +
            "FROM products p " +
            "JOIN users u ON p.seller_id = u.id " +
            "LEFT JOIN reviews r ON p.id = r.product_id ";

    private static final String GROUP_BY =
            " GROUP BY p.id, p.seller_id, p.name, p.description, p.price, p.stock_qty, p.category, " +
            "          p.image_url, p.is_active, p.created_at, u.name ";

    @Override
    public Long create(Product product) {
        String sql = "INSERT INTO products (seller_id, name, description, price, stock_qty, category, image_url, is_active, created_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_VERSION_KEYS > 0 ? Statement.RETURN_GENERATED_KEYS : 1)) {

            ps.setLong(1, product.getSellerId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setBigDecimal(4, product.getPrice());
            ps.setInt(5, product.getStockQty());
            ps.setString(6, product.getCategory());
            ps.setString(7, product.getImageUrl());
            ps.setBoolean(8, product.getIsActive() != null ? product.getIsActive() : true);

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    long generatedId = rs.getLong(1);
                    product.setId(generatedId);
                    return generatedId;
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error creating product: {}", e.getMessage(), e);
            throw new RuntimeException("Database error creating product", e);
        }
        return null;
    }

    @Override
    public Optional<Product> findById(Long id) {
        String sql = BASE_SELECT + " WHERE p.id = ?" + GROUP_BY;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding product by id {}: {}", id, e.getMessage(), e);
            throw new RuntimeException("Database error finding product", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Product> findAllActive() {
        List<Product> list = new ArrayList<>();
        String sql = BASE_SELECT + " WHERE p.is_active = TRUE" + GROUP_BY + " ORDER BY p.id DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding active products: {}", e.getMessage(), e);
            throw new RuntimeException("Database error retrieving products", e);
        }
        return list;
    }

    @Override
    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        String sql = BASE_SELECT + GROUP_BY + " ORDER BY p.id DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding all products: {}", e.getMessage(), e);
            throw new RuntimeException("Database error retrieving products", e);
        }
        return list;
    }

    @Override
    public List<Product> findBySellerId(Long sellerId) {
        List<Product> list = new ArrayList<>();
        String sql = BASE_SELECT + " WHERE p.seller_id = ?" + GROUP_BY + " ORDER BY p.id DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding products by seller {}: {}", sellerId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving seller products", e);
        }
        return list;
    }

    @Override
    public List<Product> searchAndFilter(String keyword, String category) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BASE_SELECT);
        sql.append(" WHERE p.is_active = TRUE ");

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasCategory = category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("ALL");

        if (hasKeyword) {
            sql.append(" AND (LOWER(p.name) LIKE ? OR LOWER(p.description) LIKE ?) ");
        }
        if (hasCategory) {
            sql.append(" AND LOWER(p.category) = ? ");
        }

        sql.append(GROUP_BY).append(" ORDER BY p.id DESC");

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (hasKeyword) {
                String pattern = "%" + keyword.trim().toLowerCase() + "%";
                ps.setString(paramIndex++, pattern);
                ps.setString(paramIndex++, pattern);
            }
            if (hasCategory) {
                ps.setString(paramIndex++, category.trim().toLowerCase());
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error searching products: {}", e.getMessage(), e);
            throw new RuntimeException("Database error searching products", e);
        }
        return list;
    }

    @Override
    public List<String> findDistinctCategories() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM products WHERE is_active = TRUE ORDER BY category ASC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            LOGGER.error("Error retrieving categories: {}", e.getMessage(), e);
            throw new RuntimeException("Database error retrieving categories", e);
        }
        return list;
    }

    @Override
    public boolean update(Product product) {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock_qty = ?, category = ?, image_url = ?, is_active = ? " +
                     "WHERE id = ? AND seller_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStockQty());
            ps.setString(5, product.getCategory());
            ps.setString(6, product.getImageUrl());
            ps.setBoolean(7, product.getIsActive() != null ? product.getIsActive() : true);
            ps.setLong(8, product.getId());
            ps.setLong(9, product.getSellerId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error updating product {}: {}", product.getId(), e.getMessage(), e);
            throw new RuntimeException("Database error updating product", e);
        }
    }

    @Override
    public boolean updateStock(Long productId, int newStock) {
        String sql = "UPDATE products SET stock_qty = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newStock);
            ps.setLong(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error updating stock for product {}: {}", productId, e.getMessage(), e);
            throw new RuntimeException("Database error updating stock", e);
        }
    }

    @Override
    public boolean setActiveStatus(Long productId, boolean active) {
        String sql = "UPDATE products SET is_active = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, active);
            ps.setLong(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error updating active status for product {}: {}", productId, e.getMessage(), e);
            throw new RuntimeException("Database error updating active status", e);
        }
    }

    @Override
    public boolean delete(Long id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error deleting product {}: {}", id, e.getMessage(), e);
            throw new RuntimeException("Database error deleting product", e);
        }
    }

    @Override
    public long countActive() {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = TRUE";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            LOGGER.error("Error counting products: {}", e.getMessage(), e);
            throw new RuntimeException("Database error counting products", e);
        }
        return 0L;
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getLong("id"));
        p.setSellerId(rs.getLong("seller_id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setStockQty(rs.getInt("stock_qty"));
        p.setCategory(rs.getString("category"));
        p.setImageUrl(rs.getString("image_url"));
        p.setIsActive(rs.getBoolean("is_active"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setSellerName(rs.getString("seller_name"));
        p.setAverageRating(Math.round(rs.getDouble("avg_rating") * 10.0) / 10.0);
        p.setReviewCount(rs.getInt("review_count"));
        return p;
    }
}
