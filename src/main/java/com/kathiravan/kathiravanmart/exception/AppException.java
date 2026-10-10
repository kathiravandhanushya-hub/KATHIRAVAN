package com.kathiravan.kathiravanmart.exception;

/**
 * Base custom application exception.
 */
public class AppException extends RuntimeException {
    private final int statusCode;
    private final String errorCode;

    public AppException(String message) {
        this(message, 500, "INTERNAL_ERROR");
    }

    public AppException(String message, Throwable cause) {
        super(message, cause);
        this.statusCode = 500;
        this.errorCode = "INTERNAL_ERROR";
    }

    public AppException(String message, int statusCode, String errorCode) {
        super(message);
        this.statusCode = statusCode;
        this.errorCode = errorCode;
    }

    public AppException(String message, int statusCode, String errorCode, Throwable cause) {
        super(message, cause);
        this.statusCode = statusCode;
        this.errorCode = errorCode;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public String getErrorCode() {
        return errorCode;
    }
}
