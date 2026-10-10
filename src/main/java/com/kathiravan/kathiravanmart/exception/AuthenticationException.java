package com.kathiravan.kathiravanmart.exception;

/**
 * Exception thrown when user authentication fails or is missing (HTTP 401).
 */
public class AuthenticationException extends AppException {
    public AuthenticationException(String message) {
        super(message, 401, "UNAUTHENTICATED");
    }
}
