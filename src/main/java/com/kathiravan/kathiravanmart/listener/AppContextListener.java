package com.kathiravan.kathiravanmart.listener;

import com.kathiravan.kathiravanmart.util.DatabaseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * ServletContextListener responsible for initializing and closing
 * the application-wide HikariCP connection pool and database resources.
 * Strictly implements Section 4 Rule 5.
 */
@WebListener
public class AppContextListener implements ServletContextListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(AppContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("Starting KathiravanMart Application Context...");
        try {
            DatabaseUtil.initialize();
            LOGGER.info("KathiravanMart Application Context initialized successfully.");
        } catch (Exception e) {
            LOGGER.error("CRITICAL: Failed to initialize application context: {}", e.getMessage(), e);
            throw new RuntimeException("Application startup aborted due to DB init failure", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.info("Destroying KathiravanMart Application Context...");
        try {
            DatabaseUtil.shutdown();
            LOGGER.info("HikariCP connection pool shut down cleanly.");
        } catch (Exception e) {
            LOGGER.error("Error shutting down connection pool: {}", e.getMessage(), e);
        }
    }
}
