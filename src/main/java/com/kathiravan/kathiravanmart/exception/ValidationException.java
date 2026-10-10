package com.kathiravan.kathiravanmart.exception;

import java.util.Collections;
import java.util.Map;

/**
 * Exception thrown when input validation fails (HTTP 400).
 */
public class ValidationException extends AppException {
    private final Map<String, String> fieldErrors;

    public ValidationException(String message) {
        super(message, 400, "VALIDATION_ERROR");
        this.fieldErrors = Collections.emptyMap();
    }

    public ValidationException(String message, Map<String, String> fieldErrors) {
        super(message, 400, "VALIDATION_ERROR");
        this.fieldErrors = fieldErrors != null ? fieldErrors : Collections.emptyMap();
    }

    public ValidationException(String field, String errorMessage) {
        super(errorMessage, 400, "VALIDATION_ERROR");
        this.fieldErrors = Collections.singletonMap(field, errorMessage);
    }

    public Map<String, String> getFieldErrors() {
        return fieldErrors;
    }
}
