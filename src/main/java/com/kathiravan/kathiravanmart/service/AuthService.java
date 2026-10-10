package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dto.UserResponseDTO;
import com.kathiravan.kathiravanmart.model.User;

/**
 * Service interface for user authentication, registration, and credential verification.
 */
public interface AuthService {

    /**
     * Registers a new buyer or seller account.
     * Validates input parameters before interacting with data access layer.
     *
     * @param name Full name of user
     * @param email Unique email address
     * @param password Plaintext password
     * @param role User role ("BUYER" or "SELLER")
     * @return UserResponseDTO representing registered user
     */
    UserResponseDTO register(String name, String email, String password, String role);

    /**
     * Authenticates a user with email and password.
     *
     * @param email Email address
     * @param password Plaintext password
     * @return User domain entity for session establishment
     */
    User login(String email, String password);

    /**
     * Retrieves user profile details.
     *
     * @param userId User identifier
     * @return UserResponseDTO
     */
    UserResponseDTO getProfile(Long userId);
}
