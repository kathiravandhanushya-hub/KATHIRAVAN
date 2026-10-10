package com.kathiravan.kathiravanmart.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Database utility managing HikariCP connection pool and schema migrations.
 * Complies with Section 4 Rule 5: Connection pool lifecycle owned by ServletContextListener.
 * Complies with Section 4 Rule 6: Try-with-resources for every Connection, PreparedStatement, ResultSet.
 */
public final class DatabaseUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(DatabaseUtil.class);
    private static volatile HikariDataSource dataSource;

    private DatabaseUtil() {
    }

    /**
     * Initializes the HikariCP DataSource.
     * Called exclusively by AppContextListener during application startup.
     */
    public static synchronized void initialize() {
        if (dataSource != null && !dataSource.isClosed()) {
            return;
        }

        String driver = ConfigUtil.get("db.driver", "org.h2.Driver");
        String url = ConfigUtil.get("db.url", "jdbc:h2:./data/kathiravanmart;DB_CLOSE_DELAY=-1;AUTO_SERVER=TRUE");
        String user = ConfigUtil.get("db.user", "sa");
        String password = ConfigUtil.get("db.password", "");
        int maxPoolSize = ConfigUtil.getInt("db.pool.maxSize", 10);
        int minIdle = ConfigUtil.getInt("db.pool.minIdle", 2);
        int timeout = ConfigUtil.getInt("db.pool.timeout", 30000);

        LOGGER.info("Initializing HikariCP pool with URL: {}", url);

        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            LOGGER.error("Failed to load JDBC driver {}: {}", driver, e.getMessage());
            throw new RuntimeException("JDBC Driver not found: " + driver, e);
        }

        HikariConfig config = new HikariConfig();
        config.setPoolName("KathiravanMartHikariPool");
        config.setDriverClassName(driver);
        config.setJdbcUrl(url);
        config.setUsername(user);
        config.setPassword(password);
        config.setMaximumPoolSize(maxPoolSize);
        config.setMinimumIdle(minIdle);
        config.setConnectionTimeout(timeout);
        config.setIdleTimeout(600000);
        config.setMaxLifetime(1800000);

        dataSource = new HikariDataSource(config);
        LOGGER.info("HikariCP connection pool successfully initialized.");

        // Auto-run schema migrations and ensure seed data
        runMigrations();
        ensureSeedData();
    }

    /**
     * Shuts down the HikariCP DataSource.
     * Called exclusively by AppContextListener during application shutdown.
     */
    public static synchronized void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            LOGGER.info("Shutting down HikariCP connection pool...");
            dataSource.close();
            dataSource = null;
            LOGGER.info("HikariCP connection pool shut down cleanly.");
        }
    }

    /**
     * Retrieves a connection from the HikariCP connection pool.
     *
     * @return Connection from pool
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null || dataSource.isClosed()) {
            throw new SQLException("HikariDataSource is not initialized or has been closed.");
        }
        return dataSource.getConnection();
    }

    /**
     * Returns the underlying DataSource.
     */
    public static DataSource getDataSource() {
        return dataSource;
    }

    /**
     * Executes SQL migration files V1, V2, V3 in order.
     */
    private static void runMigrations() {
        String[] migrations = {
                "db/migrations/V1__init_schema.sql",
                "db/migrations/V2__add_reviews_table.sql",
                "db/migrations/V3__add_index_orders_status.sql"
        };

        for (String migration : migrations) {
            LOGGER.info("Applying migration: {}", migration);
            executeSqlScript(migration, true);
        }
    }

    /**
     * Checks if default admin account exists, if not executes seed.sql.
     */
    private static void ensureSeedData() {
        String checkSql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(checkSql)) {
            ps.setString(1, "admin@kathiravanmart.com");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) == 0) {
                    LOGGER.info("No admin user found. Executing seed data script: seed.sql");
                    executeSqlScript("seed.sql", false);
                } else {
                    LOGGER.info("Database already initialized with seed data.");
                }
            }
        } catch (SQLException e) {
            LOGGER.warn("Could not check users table, attempting seed execution: {}", e.getMessage());
            executeSqlScript("seed.sql", false);
        }
    }

    /**
     * Executes a SQL script file from the classpath or filesystem.
     */
    public static void executeSqlScript(String resourcePath, boolean ignoreErrors) {
        InputStream in = DatabaseUtil.class.getClassLoader().getResourceAsStream(resourcePath);
        if (in == null) {
            // Try with leading slash
            in = DatabaseUtil.class.getClassLoader().getResourceAsStream("/" + resourcePath);
        }
        if (in == null) {
            // Check filesystem path directly
            java.io.File file = new java.io.File(resourcePath);
            if (file.exists()) {
                try {
                    in = new java.io.FileInputStream(file);
                } catch (Exception e) {
                    LOGGER.error("Failed to read script file {}: {}", resourcePath, e.getMessage());
                }
            }
        }

        if (in == null) {
            LOGGER.warn("SQL script not found: {}", resourcePath);
            return;
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(in, StandardCharsets.UTF_8));
             Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.startsWith("--") || line.startsWith("//") || line.isEmpty()) {
                    continue;
                }
                sb.append(line).append(" ");
                if (line.endsWith(";")) {
                    String sql = sb.toString().replace(";", "").trim();
                    if (!sql.isEmpty()) {
                        try {
                            stmt.execute(sql);
                        } catch (SQLException ex) {
                            if (!ignoreErrors) {
                                LOGGER.error("Error executing SQL '{}': {}", sql, ex.getMessage());
                            } else {
                                LOGGER.debug("Ignored SQL error during migration: {}", ex.getMessage());
                            }
                        }
                    }
                    sb.setLength(0);
                }
            }
        } catch (Exception e) {
            LOGGER.error("Failed executing SQL script {}: {}", resourcePath, e.getMessage());
        }
    }
}
