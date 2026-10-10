package com.kathiravan.kathiravanmart.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests verifying BCrypt password hashing and verification (Section 4 Rule 2 & Section 9).
 */
public class PasswordUtilTest {

    @Test
    @DisplayName("Should generate valid BCrypt hash starting with $2a$")
    void testHashPasswordValidFormat() {
        String plain = "SecureSecret@123";
        String hashed = PasswordUtil.hashPassword(plain);

        assertNotNull(hashed);
        assertTrue(hashed.startsWith("$2a$10$") || hashed.startsWith("$2a$"));
        assertEquals(60, hashed.length());
    }

    @Test
    @DisplayName("Should successfully match plain password against hash")
    void testCheckPasswordSuccess() {
        String plain = "Password@123";
        String hashed = PasswordUtil.hashPassword(plain);

        assertTrue(PasswordUtil.checkPassword(plain, hashed));
    }

    @Test
    @DisplayName("Should fail when checking incorrect password")
    void testCheckPasswordFailure() {
        String plain = "Password@123";
        String hashed = PasswordUtil.hashPassword(plain);

        assertFalse(PasswordUtil.checkPassword("WrongPassword@999", hashed));
        assertFalse(PasswordUtil.checkPassword(null, hashed));
        assertFalse(PasswordUtil.checkPassword(plain, null));
    }

    @Test
    @DisplayName("Should throw exception when hashing null or empty password")
    void testHashNullOrEmpty() {
        assertThrows(IllegalArgumentException.class, () -> PasswordUtil.hashPassword(null));
        assertThrows(IllegalArgumentException.class, () -> PasswordUtil.hashPassword(""));
    }
}
