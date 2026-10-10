package com.kathiravan.kathiravanmart.ai;

/**
 * AI Chat provider interface as specified by Section 17.
 */
public interface ChatProvider {

    /**
     * Generates a conversational assistant reply for user input.
     *
     * @param userMessage Message entered by user
     * @param context Domain context such as active categories, top products, or catalog summary
     * @return Formatted response string
     */
    String getReply(String userMessage, String context);
}
