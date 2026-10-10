package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.UserDao;
import com.kathiravan.kathiravanmart.dto.UserResponseDTO;
import com.kathiravan.kathiravanmart.exception.AppException;
import com.kathiravan.kathiravanmart.exception.AuthenticationException;
import com.kathiravan.kathiravanmart.exception.ValidationException;
import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.util.PasswordUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for AuthService using JUnit 5 + Mockito (Section 9).
 */
@ExtendWith(MockitoExtension.class)
public class AuthServiceTest {

    @Mock
    private UserDao userDao;

    private AuthService authService;

    @BeforeEach
    void setUp() {
        authService = new AuthServiceImpl(userDao);
    }

    @Test
    @DisplayName("Should register new user successfully with hashed password")
    void testRegisterSuccess() {
        when(userDao.findByEmail("newbuyer@example.com")).thenReturn(Optional.empty());
        when(userDao.create(any(User.class))).thenReturn(101L);

        UserResponseDTO result = authService.register("New Buyer", "newbuyer@example.com", "Secret@123", "BUYER");

        assertNotNull(result);
        assertEquals("New Buyer", result.getName());
        assertEquals("newbuyer@example.com", result.getEmail());
        assertEquals(Role.BUYER, result.getRole());

        verify(userDao, times(1)).create(any(User.class));
    }

    @Test
    @DisplayName("Should throw 409 conflict when registering already existing email")
    void testRegisterDuplicateEmail() {
        User existing = new User();
        existing.setEmail("existing@example.com");
        when(userDao.findByEmail("existing@example.com")).thenReturn(Optional.of(existing));

        AppException ex = assertThrows(AppException.class, () ->
                authService.register("Existing User", "existing@example.com", "Password@123", "BUYER"));

        assertEquals(409, ex.getStatusCode());
        verify(userDao, never()).create(any(User.class));
    }

    @Test
    @DisplayName("Should throw ValidationException when password is too short")
    void testRegisterInvalidPassword() {
        assertThrows(ValidationException.class, () ->
                authService.register("User", "user@test.com", "123", "BUYER"));

        verify(userDao, never()).findByEmail(anyString());
    }

    @Test
    @DisplayName("Should successfully authenticate valid credentials")
    void testLoginSuccess() {
        String rawPassword = "CorrectPassword@123";
        String hashedPassword = PasswordUtil.hashPassword(rawPassword);

        User user = new User(1L, "Alice", "alice@example.com", hashedPassword, Role.BUYER, null);
        when(userDao.findByEmail("alice@example.com")).thenReturn(Optional.of(user));

        User loggedIn = authService.login("alice@example.com", rawPassword);
        assertNotNull(loggedIn);
        assertEquals("alice@example.com", loggedIn.getEmail());
    }

    @Test
    @DisplayName("Should throw AuthenticationException on invalid password")
    void testLoginInvalidPassword() {
        User user = new User(1L, "Alice", "alice@example.com", PasswordUtil.hashPassword("RightPass"), Role.BUYER, null);
        when(userDao.findByEmail("alice@example.com")).thenReturn(Optional.of(user));

        assertThrows(AuthenticationException.class, () ->
                authService.login("alice@example.com", "WrongPass"));
    }
}
