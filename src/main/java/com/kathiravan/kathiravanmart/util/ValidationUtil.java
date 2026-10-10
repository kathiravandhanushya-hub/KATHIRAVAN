package com.kathiravan.kathiravanmart.util;

import com.kathiravan.kathiravanmart.exception.ValidationException;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * Validation utility providing centralized input assertions and rules.
 */
public final class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private ValidationUtil() {
    }

    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static void validateRegistration(String name, String email, String password, String role) {
        Map<String, String> errors = new HashMap<>();

        if (name == null || name.trim().length() < 2) {
            errors.put("name", "Name must be at least 2 characters long");
        } else if (name.trim().length() > 100) {
            errors.put("name", "Name cannot exceed 100 characters");
        }

        if (!isValidEmail(email)) {
            errors.put("email", "A valid email address is required");
        }

        if (password == null || password.length() < 6) {
            errors.put("password", "Password must be at least 6 characters long");
        }

        if (role == null || (!role.equalsIgnoreCase("BUYER") && !role.equalsIgnoreCase("SELLER"))) {
            errors.put("role", "Role must be either BUYER or SELLER");
        }

        if (!errors.isEmpty()) {
            throw new ValidationException("Registration validation failed", errors);
        }
    }

    public static void validateLogin(String email, String password) {
        Map<String, String> errors = new HashMap<>();

        if (!isValidEmail(email)) {
            errors.put("email", "A valid email address is required");
        }
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Password cannot be empty");
        }

        if (!errors.isEmpty()) {
            throw new ValidationException("Login validation failed", errors);
        }
    }

    public static void validateProduct(String name, String description, BigDecimal price, Integer stockQty, String category) {
        Map<String, String> errors = new HashMap<>();

        if (name == null || name.trim().length() < 3) {
            errors.put("name", "Product name must be at least 3 characters long");
        }
        if (price == null || price.compareTo(BigDecimal.ZERO) <= 0) {
            errors.put("price", "Price must be greater than zero");
        } else if (price.scale() > 2) {
            errors.put("price", "Price cannot have more than 2 decimal places");
        }
        if (stockQty == null || stockQty < 0) {
            errors.put("stockQty", "Stock quantity must be zero or greater");
        }
        if (category == null || category.trim().isEmpty()) {
            errors.put("category", "Category is required");
        }

        if (!errors.isEmpty()) {
            throw new ValidationException("Product validation failed", errors);
        }
    }

    public static void validateReview(int rating, String comment) {
        Map<String, String> errors = new HashMap<>();
        if (rating < 1 || rating > 5) {
            errors.put("rating", "Rating must be between 1 and 5 stars");
        }
        if (comment != null && comment.trim().length() > 2000) {
            errors.put("comment", "Comment cannot exceed 2000 characters");
        }
        if (!errors.isEmpty()) {
            throw new ValidationException("Review validation failed", errors);
        }
    }

    public static void validateChatInput(String message, int maxChars) {
        if (message == null || message.trim().isEmpty()) {
            throw new ValidationException("message", "Message cannot be empty");
        }
        if (message.trim().length() > maxChars) {
            throw new ValidationException("message", "Message length exceeds maximum limit of " + maxChars + " characters");
        }
    }
}
