package com.kathiravan.kathiravanmart.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kathiravan.kathiravanmart.dto.ApiResponse;
import com.kathiravan.kathiravanmart.dto.ChatResponseDTO;
import com.kathiravan.kathiravanmart.service.ChatService;
import com.kathiravan.kathiravanmart.service.ChatServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;

/**
 * Controller for AI Shopping Assistant chatbot (Feature O4 / Section 11 & 17).
 * Receives POST /api/v1/chat, validates payload, enforces session rate limit, and returns response.
 */
@WebServlet(name = "ChatServlet", urlPatterns = {"/api/v1/chat/*"})
public class ChatServlet extends BaseServlet {

    private final ChatService chatService;

    public ChatServlet() {
        this.chatService = new ChatServiceImpl();
    }

    public ChatServlet(ChatService chatService) {
        this.chatService = chatService;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(true);
            String sessionId = session.getId();

            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            String message = "";
            if (sb.length() > 0) {
                try {
                    JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
                    if (json.has("message")) {
                        message = json.get("message").getAsString();
                    }
                } catch (Exception e) {
                    message = request.getParameter("message");
                }
            } else {
                message = request.getParameter("message");
            }

            ChatResponseDTO reply = chatService.ask(sessionId, message);
            sendJsonResponse(response, HttpServletResponse.SC_OK, ApiResponse.success(reply));

        } catch (Exception e) {
            handleException(request, response, e);
        }
    }
}
