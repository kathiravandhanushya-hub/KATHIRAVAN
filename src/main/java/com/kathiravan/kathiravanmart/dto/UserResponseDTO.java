package com.kathiravan.kathiravanmart.dto;

import com.kathiravan.kathiravanmart.model.Role;
import com.kathiravan.kathiravanmart.model.User;

import java.sql.Timestamp;

/**
 * User DTO representing safe user data returned in API responses.
 * Explicitly excludes passwordHash (Section 13).
 * Uses the Builder pattern (Section 12).
 */
public class UserResponseDTO {
    private final Long id;
    private final String name;
    private final String email;
    private final Role role;
    private final Timestamp createdAt;

    private UserResponseDTO(Builder builder) {
        this.id = builder.id;
        this.name = builder.name;
        this.email = builder.email;
        this.role = builder.role;
        this.createdAt = builder.createdAt;
    }

    public static UserResponseDTO fromEntity(User user) {
        if (user == null) {
            return null;
        }
        return new Builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .role(user.getRole())
                .createdAt(user.getCreatedAt())
                .build();
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public Role getRole() {
        return role;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public static class Builder {
        private Long id;
        private String name;
        private String email;
        private Role role;
        private Timestamp createdAt;

        public Builder id(Long id) {
            this.id = id;
            return this;
        }

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder email(String email) {
            this.email = email;
            return this;
        }

        public Builder role(Role role) {
            this.role = role;
            return this;
        }

        public Builder createdAt(Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public UserResponseDTO build() {
            return new UserResponseDTO(this);
        }
    }
}
