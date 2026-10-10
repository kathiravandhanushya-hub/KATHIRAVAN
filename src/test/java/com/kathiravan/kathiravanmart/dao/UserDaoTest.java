package com.kathiravan.kathiravanmart.dao;

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
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Integration tests for UserDao executed against embedded H2 in-memory instance
 * (Section 5 & Section 9: jdbc:h2:mem:test;DB_CLOSE_DELAY=-1).
 */
public class UserDaoTest {

    private static HikariDataSource testDataSource;
    private UserDao userDao;

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
        userDao = new UserDaoImpl(testDataSource);

        // Execute test-schema.sql
        try (Connection conn = testDataSource.getConnection();
             Statement stmt = conn.createStatement();
             InputStream in = getClass().getClassLoader().getResourceAsStream("test-schema.sql")) {

            assertNotNull(in, "test-schema.sql must be present on classpath");
            java.util.Scanner s = new java.util.Scanner(new InputStreamReader(in, StandardCharsets.UTF_8)).useDelimiter(";");
            while (s.hasNext()) {
                String line = s.next().trim();
                if (!line.isEmpty()) {
                    stmt.execute(line);
                }
            }
            // Clear users table for clean test state
            stmt.execute("DELETE FROM users");
        }
    }

    @Test
    @DisplayName("Should create user and retrieve by ID and Email")
    void testCreateAndFindUser() {
        User user = new User();
        user.setName("Kathiravan Solo");
        user.setEmail("kathir@test.com");
        user.setPasswordHash("$2a$10$abcdefghijklmnopqrstuvwxyz1234567890");
        user.setRole(Role.BUYER);

        Long id = userDao.create(user);
        assertNotNull(id);
        assertTrue(id > 0);

        Optional<User> byId = userDao.findById(id);
        assertTrue(byId.isPresent());
        assertEquals("Kathiravan Solo", byId.get().getName());
        assertEquals("kathir@test.com", byId.get().getEmail());
        assertEquals(Role.BUYER, byId.get().getRole());

        Optional<User> byEmail = userDao.findByEmail("kathir@test.com");
        assertTrue(byEmail.isPresent());
        assertEquals(id, byEmail.get().getId());
    }

    @Test
    @DisplayName("Should update user details successfully")
    void testUpdateUser() {
        User user = new User();
        user.setName("Original Name");
        user.setEmail("update@test.com");
        user.setPasswordHash("hash123");
        user.setRole(Role.SELLER);

        Long id = userDao.create(user);
        user.setId(id);
        user.setName("Updated Name");

        boolean updated = userDao.update(user);
        assertTrue(updated);

        User found = userDao.findById(id).orElseThrow();
        assertEquals("Updated Name", found.getName());
    }

    @Test
    @DisplayName("Should delete user successfully")
    void testDeleteUser() {
        User user = new User();
        user.setName("To Delete");
        user.setEmail("delete@test.com");
        user.setPasswordHash("hash123");
        user.setRole(Role.BUYER);

        Long id = userDao.create(user);
        assertTrue(userDao.findById(id).isPresent());

        boolean deleted = userDao.delete(id);
        assertTrue(deleted);
        assertFalse(userDao.findById(id).isPresent());
    }
}
