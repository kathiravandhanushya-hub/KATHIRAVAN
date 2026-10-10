package com.kathiravan.kathiravanmart.dao;

import com.kathiravan.kathiravanmart.model.Product;
import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Statement;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Integration tests for ProductDao executed against embedded H2 in-memory instance.
 */
public class ProductDaoTest {

    private static HikariDataSource testDataSource;
    private ProductDao productDao;
    private UserDao userDao;
    private Long testSellerId;

    @BeforeAll
    static void setUpAll() {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:h2:mem:test;DB_CLOSE_DELAY=-1;MODE=REGULAR");
        config.setDriverClassName("org.h2.Driver");
        config.setUsername("sa");
        config.setPassword("");
        config.setMaximumPoolSize(5);
        testDataSource = new HikariDataSource(config);
    }

    @AfterAll
    static void tearDownAll() {
        if (testDataSource != null) {
            testDataSource.close();
        }
    }

    @BeforeEach
    void setUp() throws Exception {
        productDao = new ProductDaoImpl(testDataSource);
        userDao = new UserDaoImpl(testDataSource);

        try (Connection conn = testDataSource.getConnection();
             Statement stmt = conn.createStatement();
             InputStream in = getClass().getClassLoader().getResourceAsStream("test-schema.sql")) {

            assertNotNull(in);
            java.util.Scanner s = new java.util.Scanner(new InputStreamReader(in, StandardCharsets.UTF_8)).useDelimiter(";");
            while (s.hasNext()) {
                String line = s.next().trim();
                if (!line.isEmpty()) {
                    stmt.execute(line);
                }
            }
            stmt.execute("DELETE FROM products");
            stmt.execute("DELETE FROM users");
        }

        // Create test seller
        User seller = new User();
        seller.setName("Seller One");
        seller.setEmail("seller@test.com");
        seller.setPasswordHash("hash123");
        seller.setRole(Role.SELLER);
        testSellerId = userDao.create(seller);
    }

    @Test
    @DisplayName("Should create product and retrieve by ID")
    void testCreateAndFindProduct() {
        Product p = new Product();
        p.setSellerId(testSellerId);
        p.setName("Wireless Noise Canceling Headphones");
        p.setDescription("High quality audio experience");
        p.setPrice(new BigDecimal("3999.00"));
        p.setStockQty(20);
        p.setCategory("Electronics");
        p.setImageUrl("https://example.com/img.jpg");
        p.setIsActive(true);

        Long id = productDao.create(p);
        assertNotNull(id);

        Optional<Product> found = productDao.findById(id);
        assertTrue(found.isPresent());
        assertEquals("Wireless Noise Canceling Headphones", found.get().getName());
        assertEquals(new BigDecimal("3999.00"), found.get().getPrice());
        assertEquals("Electronics", found.get().getCategory());
        assertEquals("Seller One", found.get().getSellerName());
    }

    @Test
    @DisplayName("Should search and filter products by keyword and category")
    void testSearchAndFilter() {
        Product p1 = new Product(null, testSellerId, "Gaming Laptop 16GB", "Powerful laptop for gaming",
                new BigDecimal("65000.00"), 5, "Electronics", null, true, null);
        Product p2 = new Product(null, testSellerId, "Cotton Casual Shirt", "Formal and casual cotton wear",
                new BigDecimal("1200.00"), 30, "Fashion", null, true, null);

        productDao.create(p1);
        productDao.create(p2);

        // Search by keyword "laptop"
        List<Product> search1 = productDao.searchAndFilter("laptop", null);
        assertEquals(1, search1.size());
        assertEquals("Gaming Laptop 16GB", search1.get(0).getName());

        // Filter by category "Fashion"
        List<Product> search2 = productDao.searchAndFilter(null, "Fashion");
        assertEquals(1, search2.size());
        assertEquals("Cotton Casual Shirt", search2.get(0).getName());
    }
}
