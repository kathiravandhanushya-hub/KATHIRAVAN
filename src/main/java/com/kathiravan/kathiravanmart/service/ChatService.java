package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.dto.ChatResponseDTO;

/**
 * Service interface for AI chatbot assistant (Feature O4 / Phase 3).
 */
public interface ChatService {

    /**
     * Processes a chat query with session rate-limiting, length cap, and caching.
     *
     * @param sessionId User session identifier
     * @param message User question
     * @return ChatResponseDTO with reply and metadata
     */
    ChatResponseDTO ask(String sessionId, String message);
}
