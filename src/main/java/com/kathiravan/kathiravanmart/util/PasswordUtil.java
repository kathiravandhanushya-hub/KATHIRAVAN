package com.kathiravan.kathiravanmart.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility for hashing and verifying passwords using jBCrypt.
 * Strictly adheres to Section 4 Rule 2 and Section 9 Security Checklist.
 */
public final class PasswordUtil {

    private static final int BCRYPT_LOG_ROUNDS = 10;

    private PasswordUtil() {
        // Private constructor to prevent instantiation
    }

    /**
     * Hashes a plaintext password using BCrypt with salt rounds = 10.
     *
     * @param plainPassword Plaintext password
     * @return 60-character bcrypt hash string
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_LOG_ROUNDS));
    }

    /**
     * Checks whether a plaintext password matches a stored bcrypt hash.
     *
     * @param plainPassword Plaintext password
     * @param hashedPassword Stored BCrypt hash
     * @return true if matches, false otherwise
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null || hashedPassword.isEmpty()) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            // Malformed hash
            return false;
        }
    }
}
