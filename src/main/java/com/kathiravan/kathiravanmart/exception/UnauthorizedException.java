package com.kathiravan.kathiravanmart.exception;

/**
 * Exception thrown when authenticated user lacks permissions (HTTP 403).
 */
public class UnauthorizedException extends AppException {
    public UnauthorizedException(String message) {
        super(message, 403, "FORBIDDEN");
    }
}
