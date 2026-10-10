package com.kathiravan.kathiravanmart.dto;

import java.util.Map;

/**
 * Standard API response envelope as required by Section 13.
 * Format:
 * { "success": true, "data": { ... }, "error": null }
 * { "success": false, "data": null, "error": { "code": "...", "message": "...", "fields": { ... } } }
 */
public class ApiResponse<T> {
    private final boolean success;
    private final T data;
    private final ApiError error;

    private ApiResponse(boolean success, T data, ApiError error) {
        this.success = success;
        this.data = data;
        this.error = error;
    }

    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>(true, data, null);
    }

    public static <T> ApiResponse<T> error(String code, String message) {
        return new ApiResponse<>(false, null, new ApiError(code, message, null));
    }

    public static <T> ApiResponse<T> error(String code, String message, Map<String, String> fieldErrors) {
        return new ApiResponse<>(false, null, new ApiError(code, message, fieldErrors));
    }

    public boolean isSuccess() {
        return success;
    }

    public T getData() {
        return data;
    }

    public ApiError getError() {
        return error;
    }

    public static class ApiError {
        private final String code;
        private final String message;
        private final Map<String, String> fields;

        public ApiError(String code, String message, Map<String, String> fields) {
            this.code = code;
            this.message = message;
            this.fields = fields;
        }

        public String getCode() {
            return code;
        }

        public String getMessage() {
            return message;
        }

        public Map<String, String> getFields() {
            return fields;
        }
    }
}
