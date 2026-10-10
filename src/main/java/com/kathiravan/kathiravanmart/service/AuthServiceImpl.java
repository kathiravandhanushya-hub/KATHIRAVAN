package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dao.UserDao;
import com.kathiravan.kathiravanmart.dto.UserResponseDTO;
import com.kathiravan.kathiravanmart.exception.AppException;
import com.kathiravan.kathiravanmart.exception.AuthenticationException;
import com.kathiravan.kathiravanmart.exception.ResourceNotFoundException;
import com.kathiravan.kathiravanmart.factory.DaoFactory;
import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;
import com.kathiravan.kathiravanmart.util.PasswordUtil;
import com.kathiravan.kathiravanmart.util.ValidationUtil;

import java.util.Optional;

/**
 * Implementation of AuthService.
 * Business rules and validation are handled here; depends strictly on UserDao interface.
 */
public class AuthServiceImpl implements AuthService {

    private final UserDao userDao;

    public AuthServiceImpl() {
        this.userDao = DaoFactory.getUserDao();
    }

    public AuthServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public UserResponseDTO register(String name, String email, String password, String role) {
        // 1. Validation at top of service method (Section 13 Rule 5)
        ValidationUtil.validateRegistration(name, email, password, role);

        // 2. Check duplicate email
        Optional<User> existing = userDao.findByEmail(email);
        if (existing.isPresent()) {
            throw new AppException("An account with email " + email + " already exists", 409, "CONFLICT");
        }

        // 3. Hash password using jBCrypt (Section 4 Rule 2)
        String hashedPassword = PasswordUtil.hashPassword(password);

        Role userRole = Role.fromString(role);
        if (userRole == Role.ADMIN) {
            // Admin role is assigned via seed account only (F1)
            userRole = Role.BUYER;
        }

        User newUser = new User();
        newUser.setName(name.trim());
        newUser.setEmail(email.trim().toLowerCase());
        newUser.setPasswordHash(hashedPassword);
        newUser.setRole(userRole);

        userDao.create(newUser);
        return UserResponseDTO.fromEntity(newUser);
    }

    @Override
    public User login(String email, String password) {
        // 1. Validate login inputs
        ValidationUtil.validateLogin(email, password);

        // 2. Lookup user by email
        User user = userDao.findByEmail(email)
                .orElseThrow(() -> new AuthenticationException("Invalid email or password"));

        // 3. Verify bcrypt hash
        if (!PasswordUtil.checkPassword(password, user.getPasswordHash())) {
            throw new AuthenticationException("Invalid email or password");
        }

        return user;
    }

    @Override
    public UserResponseDTO getProfile(Long userId) {
        if (userId == null) {
            throw new ResourceNotFoundException("User ID must not be null");
        }
        User user = userDao.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with ID " + userId));
        return UserResponseDTO.fromEntity(user);
    }
}
