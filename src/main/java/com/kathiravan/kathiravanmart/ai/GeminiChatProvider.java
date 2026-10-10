package com.kathiravan.kathiravanmart.ai;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kathiravan.kathiravanmart.util.ConfigUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/**
 * GeminiChatProvider calling Google Gemini LLM API server-side.
 * Adheres to Section 11 & Section 17:
 * - API key stored server-side only
 * - Guardrail domain prompt template
 * - HTTP timeout on outbound call
 * - Returns degraded response on failure
 */
public class GeminiChatProvider implements ChatProvider {
    private static final Logger LOGGER = LoggerFactory.getLogger(GeminiChatProvider.class);
    private final MockChatProvider fallback = new MockChatProvider();

    private static final String SYSTEM_PROMPT =
            "You are an AI assistant for 'KathiravanMart', a multi-seller e-commerce marketplace. " +
            "Your assistance is strictly restricted to products, categories, orders, carts, checkout, and seller listings. " +
            "Be polite, concise (max 3 sentences), and do not answer off-topic queries. " +
            "Catalog context: ";

    @Override
    public String getReply(String userMessage, String context) {
        String apiKey = ConfigUtil.get("GEMINI_API_KEY", ConfigUtil.get("ai.chatbot.gemini.key", ""));
        if (apiKey == null || apiKey.trim().isEmpty()) {
            LOGGER.debug("Gemini API key not configured, falling back to MockChatProvider.");
            return fallback.getReply(userMessage, context);
        }

        String apiUrl = ConfigUtil.get("GEMINI_API_URL",
                "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent") + "?key=" + apiKey.trim();

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setConnectTimeout(5000); // 5s connection timeout
            conn.setReadTimeout(7000);    // 7s read timeout
            conn.setDoOutput(true);

            // Construct Gemini REST JSON payload
            String promptText = SYSTEM_PROMPT + (context != null ? context : "General Catalog") + "\nUser: " + userMessage;

            JsonObject textPart = new JsonObject();
            textPart.addProperty("text", promptText);

            JsonArray parts = new JsonArray();
            parts.add(textPart);

            JsonObject contentObj = new JsonObject();
            contentObj.add("parts", parts);

            JsonArray contents = new JsonArray();
            contents.add(contentObj);

            JsonObject requestBody = new JsonObject();
            requestBody.add("contents", contents);

            byte[] input = requestBody.toString().getBytes(StandardCharsets.UTF_8);
            try (OutputStream os = conn.getOutputStream()) {
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                StringBuilder response = new StringBuilder();
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        response.append(line);
                    }
                }

                JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
                JsonArray candidates = jsonResponse.getAsJsonArray("candidates");
                if (candidates != null && candidates.size() > 0) {
                    JsonObject firstCandidate = candidates.get(0).getAsJsonObject();
                    JsonObject content = firstCandidate.getAsJsonObject("content");
                    JsonArray resParts = content.getAsJsonArray("parts");
                    if (resParts != null && resParts.size() > 0) {
                        return resParts.get(0).getAsJsonObject().get("text").getAsString().trim();
                    }
                }
            } else {
                LOGGER.warn("Gemini API returned HTTP status {}: falling back to canned response", responseCode);
            }
        } catch (Exception e) {
            LOGGER.error("Gemini API call failed: {}, returning degraded fallback", e.getMessage());
        }

        // Return static degraded response on failure (Section 11 Requirement 3)
        return fallback.getReply(userMessage, context);
    }
}
