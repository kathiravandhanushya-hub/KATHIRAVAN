package com.kathiravan.kathiravanmart.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.InputStream;
import java.util.Properties;

/**
 * Configuration manager loading application parameters from system environment,
 * JVM system properties, and config.properties resource file.
 */
public final class ConfigUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger(ConfigUtil.class);
    private static final Properties PROPERTIES = new Properties();

    static {
        try (InputStream in = ConfigUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (in != null) {
                PROPERTIES.load(in);
                LOGGER.info("Loaded configuration properties from classpath: config.properties");
            } else {
                LOGGER.warn("config.properties not found on classpath, relying on environment variables and defaults.");
            }
        } catch (Exception e) {
            LOGGER.error("Failed to load config.properties: {}", e.getMessage());
        }
    }

    private ConfigUtil() {
    }

    /**
     * Resolves a configuration property by checking environment variables first,
     * then system properties, then loaded properties file, and finally a default value.
     */
    public static String get(String key, String defaultValue) {
        // 1. Check environment variable formatted with uppercase and underscores
        String envKey = key.toUpperCase().replace('.', '_').replace('-', '_');
        String val = System.getenv(envKey);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        // 2. Check direct environment variable
        val = System.getenv(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        // 3. Check system property
        val = System.getProperty(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        // 4. Check loaded properties
        val = PROPERTIES.getProperty(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }

        return defaultValue;
    }

    public static String get(String key) {
        return get(key, null);
    }

    public static int getInt(String key, int defaultValue) {
        String val = get(key, null);
        if (val != null) {
            try {
                return Integer.parseInt(val);
            } catch (NumberFormatException e) {
                LOGGER.warn("Invalid integer for key {}: {}, using default {}", key, val, defaultValue);
            }
        }
        return defaultValue;
    }

    public static boolean getBoolean(String key, boolean defaultValue) {
        String val = get(key, null);
        if (val != null) {
            return Boolean.parseBoolean(val);
        }
        return defaultValue;
    }
}
