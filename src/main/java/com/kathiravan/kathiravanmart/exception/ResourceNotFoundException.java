package com.kathiravan.kathiravanmart.exception;

/**
 * Exception thrown when requested resource does not exist (HTTP 404).
 */
public class ResourceNotFoundException extends AppException {
    public ResourceNotFoundException(String message) {
        super(message, 404, "NOT_FOUND");
    }
}
