package com.kathiravan.kathiravanmart.service;

import com.kathiravan.kathiravanmart.ai.ChatProvider;
import com.kathiravan.kathiravanmart.dao.ProductDao;
import com.kathiravan.kathiravanmart.dto.ChatResponseDTO;
import com.kathiravan.kathiravanmart.exception.ValidationException;
import com.kathiravan.kathiravanmart.factory.ChatProviderFactory;
import com.kathiravan.kathiravanmart.factory.DaoFactory;
import com.kathiravan.kathiravanmart.util.ConfigUtil;
import com.kathiravan.kathiravanmart.util.ValidationUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Implementation of ChatService adhering strictly to Section 11 & Section 17:
 * - Rate limiting (10 requests/minute per session)
 * - Input length cap
 * - In-memory session response caching for repeated questions
 * - ChatProvider interface through factory
 */
public class ChatServiceImpl implements ChatService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ChatServiceImpl.class);

    private final ProductDao productDao;

    // Rate limiting tracking: sessionId -> queue of timestamps (ms)
    private static final Map<String, Deque<Long>> RATE_LIMIT_MAP = new ConcurrentHashMap<>();

    // In-memory repeated question cache per session: sessionId -> (normalizedQuestion -> cachedReply)
    private static final Map<String, Map<String, String>> SESSION_CACHE = new ConcurrentHashMap<>();

    public ChatServiceImpl() {
        this.productDao = DaoFactory.getProductDao();
    }

    public ChatServiceImpl(ProductDao productDao) {
        this.productDao = productDao;
    }

    @Override
    public ChatResponseDTO ask(String sessionId, String message) {
        int maxChars = ConfigUtil.getInt("ai.chatbot.inputMaxChars", 250);
        int rateLimit = ConfigUtil.getInt("ai.chatbot.rateLimitPerMinute", 10);

        // 1. Validate input length cap (Section 17 Guardrails)
        ValidationUtil.validateChatInput(message, maxChars);

        String validSessionId = (sessionId != null && !sessionId.isEmpty()) ? sessionId : "anonymous";
        String normalizedMsg = message.trim().toLowerCase();

        // 2. Check per-session rate limit (10 messages/minute)
        checkRateLimit(validSessionId, rateLimit);

        // 3. Repeated identical questions cached in-memory per session (Section 17 Requirement 4)
        Map<String, String> userCache = SESSION_CACHE.computeIfAbsent(validSessionId, k -> new ConcurrentHashMap<>());
        if (userCache.containsKey(normalizedMsg)) {
            LOGGER.debug("Returning cached reply for session {}", validSessionId);
            return new ChatResponseDTO(userCache.get(normalizedMsg), "cache", true);
        }

        // 4. Retrieve domain context (active categories)
        String domainContext = "";
        try {
            List<String> categories = productDao.findDistinctCategories();
            if (!categories.isEmpty()) {
                domainContext = "Categories: " + String.join(", ", categories);
            }
        } catch (Exception e) {
            LOGGER.warn("Could not load categories for chat context: {}", e.getMessage());
        }

        // 5. Call ChatProvider via Factory
        ChatProvider provider = ChatProviderFactory.getProvider();
        String reply;
        try {
            reply = provider.getReply(message.trim(), domainContext);
        } catch (Exception e) {
            LOGGER.error("ChatProvider error: {}, using static degraded response", e.getMessage());
            reply = "I apologize, but I am temporarily unable to answer. You can browse our product listings or check your order history directly from the navigation bar.";
        }

        // Cache response in session
        userCache.put(normalizedMsg, reply);

        String providerName = ConfigUtil.get("ai.chatbot.provider", "mock");
        return new ChatResponseDTO(reply, providerName, false);
    }

    private void checkRateLimit(String sessionId, int maxRequestsPerMinute) {
        long now = System.currentTimeMillis();
        long windowStart = now - 60000; // 1 minute window

        Deque<Long> timestamps = RATE_LIMIT_MAP.computeIfAbsent(sessionId, k -> new ArrayDeque<>());
        synchronized (timestamps) {
            while (!timestamps.isEmpty() && timestamps.peekFirst() < windowStart) {
                timestamps.pollFirst();
            }

            if (timestamps.size() >= maxRequestsPerMinute) {
                LOGGER.warn("Rate limit exceeded for session: {}", sessionId);
                throw new ValidationException("rate_limit", "Rate limit exceeded. Maximum 10 messages per minute allowed.");
            }

            timestamps.addLast(now);
        }
    }
}
