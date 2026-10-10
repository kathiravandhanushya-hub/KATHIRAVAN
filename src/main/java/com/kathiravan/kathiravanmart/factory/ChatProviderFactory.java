package com.kathiravan.kathiravanmart.factory;

import com.kathiravan.kathiravanmart.ai.ChatProvider;
import com.kathiravan.kathiravanmart.ai.GeminiChatProvider;
import com.kathiravan.kathiravanmart.ai.MockChatProvider;
import com.kathiravan.kathiravanmart.util.ConfigUtil;

/**
 * Factory pattern for instantiating the active ChatProvider based on config flag.
 * Section 17 Requirement 2: ai.chatbot.provider=gemini|mock.
 */
public final class ChatProviderFactory {

    private static final ChatProvider MOCK_PROVIDER = new MockChatProvider();
    private static final ChatProvider GEMINI_PROVIDER = new GeminiChatProvider();

    private ChatProviderFactory() {
    }

    public static ChatProvider getProvider() {
        String provider = ConfigUtil.get("ai.chatbot.provider", "mock");
        if ("gemini".equalsIgnoreCase(provider)) {
            return GEMINI_PROVIDER;
        }
        return MOCK_PROVIDER;
    }
}
