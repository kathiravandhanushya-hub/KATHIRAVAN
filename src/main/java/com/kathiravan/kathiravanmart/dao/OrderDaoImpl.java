package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.Order;
import com.kathiravan.kathiravanmart.model.OrderItem;
import com.kathiravan.kathiravanmart.util.DatabaseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * JDBC implementation of OrderDao.
 * Executes parameterized queries using PreparedStatement and try-with-resources.
 */
public class OrderDaoImpl implements OrderDao {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrderDaoImpl.class);
    private final DataSource dataSource;

    public OrderDaoImpl() {
        this.dataSource = null;
    }

    public OrderDaoImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    private Connection getConnection() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        }
        return DatabaseUtil.getConnection();
    }

    @Override
    public Long createOrderWithItems(Order order, List<OrderItem> items) {
        String insertOrderSql = "INSERT INTO orders (buyer_id, status, total_amount, shipping_address, payment_method, payment_status, created_at) " +
                                "VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        String insertItemSql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, created_at) " +
                               "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        String updateStockSql = "UPDATE products SET stock_qty = stock_qty - ? WHERE id = ? AND stock_qty >= ?";

        try (Connection conn = getConnection()) {
            boolean originalAutoCommit = conn.getAutoCommit();
            conn.setAutoCommit(false);
            try {
                long orderId;
                try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                    psOrder.setLong(1, order.getBuyerId());
                    psOrder.setString(2, order.getStatus().name());
                    psOrder.setBigDecimal(3, order.getTotalAmount());
                    psOrder.setString(4, order.getShippingAddress());
                    psOrder.setString(5, order.getPaymentMethod());
                    psOrder.setString(6, order.getPaymentStatus());

                    psOrder.executeUpdate();
                    try (ResultSet rs = psOrder.getGeneratedKeys()) {
                        if (rs.next()) {
                            orderId = rs.getLong(1);
                            order.setId(orderId);
                        } else {
                            throw new SQLException("Creating order failed, no ID obtained.");
                        }
                    }
                }

                try (PreparedStatement psItem = conn.prepareStatement(insertItemSql);
                     PreparedStatement psStock = conn.prepareStatement(updateStockSql)) {

                    for (OrderItem item : items) {
                        // 1. Insert order item
                        psItem.setLong(1, orderId);
                        psItem.setLong(2, item.getProductId());
                        psItem.setInt(3, item.getQuantity());
                        psItem.setBigDecimal(4, item.getUnitPrice());
                        psItem.executeUpdate();

                        // 2. Decrement product stock safely
                        psStock.setInt(1, item.getQuantity());
                        psStock.setLong(2, item.getProductId());
                        psStock.setInt(3, item.getQuantity());
                        int affected = psStock.executeUpdate();
                        if (affected == 0) {
                            throw new SQLException("Insufficient stock for product ID " + item.getProductId());
                        }
                    }
                }

                conn.commit();
                return orderId;
            } catch (Exception e) {
                conn.rollback();
                LOGGER.error("Transaction rolled back for order creation: {}", e.getMessage(), e);
                throw new RuntimeException("Database error placing order: " + e.getMessage(), e);
            } finally {
                conn.setAutoCommit(originalAutoCommit);
            }
        } catch (SQLException e) {
            LOGGER.error("Database connection error placing order: {}", e.getMessage(), e);
            throw new RuntimeException("Database error placing order", e);
        }
    }

    @Override
    public Optional<Order> findById(Long id) {
        String sql = "SELECT o.id, o.buyer_id, o.status, o.total_amount, o.shipping_address, " +
                     "       o.payment_method, o.payment_status, o.created_at, u.name AS buyer_name, u.email AS buyer_email " +
                     "FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.id " +
                     "WHERE o.id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    order.setItems(findItemsByOrderId(conn, order.getId()));
                    return Optional.of(order);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding order {}: {}", id, e.getMessage(), e);
            throw new RuntimeException("Database error finding order", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Order> findByBuyerId(Long buyerId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.id, o.buyer_id, o.status, o.total_amount, o.shipping_address, " +
                     "       o.payment_method, o.payment_status, o.created_at, u.name AS buyer_name, u.email AS buyer_email " +
                     "FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.id " +
                     "WHERE o.buyer_id = ? " +
                     "ORDER BY o.created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, buyerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    order.setItems(findItemsByOrderId(conn, order.getId()));
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding buyer orders {}: {}", buyerId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving buyer orders", e);
        }
        return list;
    }

    @Override
    public List<Order> findBySellerId(Long sellerId) {
        List<Order> list = new ArrayList<>();
        // Distinct orders containing at least one item from this seller
        String sql = "SELECT DISTINCT o.id, o.buyer_id, o.status, o.total_amount, o.shipping_address, " +
                     "       o.payment_method, o.payment_status, o.created_at, u.name AS buyer_name, u.email AS buyer_email " +
                     "FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.id " +
                     "JOIN order_items oi ON o.id = oi.order_id " +
                     "JOIN products p ON oi.product_id = p.id " +
                     "WHERE p.seller_id = ? " +
                     "ORDER BY o.created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    // Filter line items belonging to this seller
                    order.setItems(findItemsByOrderIdAndSeller(conn, order.getId(), sellerId));
                    list.add(order);
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding seller orders {}: {}", sellerId, e.getMessage(), e);
            throw new RuntimeException("Database error retrieving seller orders", e);
        }
        return list;
    }

    @Override
    public List<Order> findAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.id, o.buyer_id, o.status, o.total_amount, o.shipping_address, " +
                     "       o.payment_method, o.payment_status, o.created_at, u.name AS buyer_name, u.email AS buyer_email " +
                     "FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.id " +
                     "ORDER BY o.created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                order.setItems(findItemsByOrderId(conn, order.getId()));
                list.add(order);
            }
        } catch (SQLException e) {
            LOGGER.error("Error finding all orders: {}", e.getMessage(), e);
            throw new RuntimeException("Database error retrieving orders", e);
        }
        return list;
    }

    @Override
    public boolean updateStatus(Long orderId, Order.Status status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.name());
            ps.setLong(2, orderId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.error("Error updating order status {}: {}", orderId, e.getMessage(), e);
            throw new RuntimeException("Database error updating order status", e);
        }
    }

    @Override
    public Map<String, Object> getSellerMetrics(Long sellerId) {
        Map<String, Object> metrics = new HashMap<>();
        String sql = "SELECT COALESCE(SUM(oi.quantity * oi.unit_price), 0.00) AS total_revenue, " +
                     "       COUNT(DISTINCT o.id) AS total_orders " +
                     "FROM order_items oi " +
                     "JOIN orders o ON oi.order_id = o.id " +
                     "JOIN products p ON oi.product_id = p.id " +
                     "WHERE p.seller_id = ? AND o.status != 'CANCELLED'";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    metrics.put("revenue", rs.getBigDecimal("total_revenue"));
                    metrics.put("orderCount", rs.getLong("total_orders"));
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error retrieving seller metrics {}: {}", sellerId, e.getMessage(), e);
        }
        return metrics;
    }

    @Override
    public Map<String, Object> getAdminMetrics() {
        Map<String, Object> metrics = new HashMap<>();
        String sql = "SELECT COALESCE(SUM(total_amount), 0.00) AS total_revenue, " +
                     "       COUNT(id) AS total_orders " +
                     "FROM orders WHERE status != 'CANCELLED'";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                metrics.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                metrics.put("totalOrders", rs.getLong("total_orders"));
            }
        } catch (SQLException e) {
            LOGGER.error("Error retrieving admin metrics: {}", e.getMessage(), e);
        }
        return metrics;
    }

    @Override
    public boolean hasPurchasedAndCompleted(Long buyerId, Long productId) {
        String sql = "SELECT COUNT(*) FROM orders o " +
                     "JOIN order_items oi ON o.id = oi.order_id " +
                     "WHERE o.buyer_id = ? AND oi.product_id = ? AND o.status IN ('DELIVERED', 'CONFIRMED', 'SHIPPED')";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, buyerId);
            ps.setLong(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.error("Error verifying purchase eligibility: {}", e.getMessage(), e);
        }
        return false;
    }

    private List<OrderItem> findItemsByOrderId(Connection conn, Long orderId) throws SQLException {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT oi.id, oi.order_id, oi.product_id, oi.quantity, oi.unit_price, oi.created_at, " +
                     "       p.name AS product_name, p.image_url, p.seller_id, u.name AS seller_name " +
                     "FROM order_items oi " +
                     "JOIN products p ON oi.product_id = p.id " +
                     "JOIN users u ON p.seller_id = u.id " +
                     "WHERE oi.order_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToOrderItem(rs));
                }
            }
        }
        return list;
    }

    private List<OrderItem> findItemsByOrderIdAndSeller(Connection conn, Long orderId, Long sellerId) throws SQLException {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT oi.id, oi.order_id, oi.product_id, oi.quantity, oi.unit_price, oi.created_at, " +
                     "       p.name AS product_name, p.image_url, p.seller_id, u.name AS seller_name " +
                     "FROM order_items oi " +
                     "JOIN products p ON oi.product_id = p.id " +
                     "JOIN users u ON p.seller_id = u.id " +
                     "WHERE oi.order_id = ? AND p.seller_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            ps.setLong(2, sellerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToOrderItem(rs));
                }
            }
        }
        return list;
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getLong("id"));
        o.setBuyerId(rs.getLong("buyer_id"));
        o.setStatus(Order.Status.fromString(rs.getString("status")));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setPaymentStatus(rs.getString("payment_status"));
        o.setCreatedAt(rs.getTimestamp("created_at"));
        o.setBuyerName(rs.getString("buyer_name"));
        o.setBuyerEmail(rs.getString("buyer_email"));
        return o;
    }

    private OrderItem mapResultSetToOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();
        item.setId(rs.getLong("id"));
        item.setOrderId(rs.getLong("order_id"));
        item.setProductId(rs.getLong("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnitPrice(rs.getBigDecimal("unit_price"));
        item.setCreatedAt(rs.getTimestamp("created_at"));
        item.setProductName(rs.getString("product_name"));
        item.setProductImage(rs.getString("image_url"));
        item.setSellerId(rs.getLong("seller_id"));
        item.setSellerName(rs.getString("seller_name"));
        return item;
    }
}
