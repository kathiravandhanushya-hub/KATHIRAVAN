// ====================================================================
// KathiravanMart - AI Assistant Chat Widget (Section 11 & Section 17)
// Vanilla JS with fetch() POST calls to /api/v1/chat
// ====================================================================

document.addEventListener('DOMContentLoaded', () => {
    const chatBtn = document.getElementById('chatWidgetBtn');
    const chatPanel = document.getElementById('chatPanel');
    const closeBtn = document.getElementById('chatCloseBtn');
    const chatForm = document.getElementById('chatForm');
    const chatInput = document.getElementById('chatInput');
    const messagesContainer = document.getElementById('chatMessages');

    if (!chatBtn || !chatPanel) return;

    // Toggle chat panel visibility
    chatBtn.addEventListener('click', () => {
        chatPanel.classList.toggle('active');
        if (chatPanel.classList.contains('active')) {
            chatInput.focus();
        }
    });

    closeBtn.addEventListener('click', () => {
        chatPanel.classList.remove('active');
    });

    // Handle user query submission
    chatForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const message = chatInput.value.trim();
        if (!message) return;

        // Render user message bubble
        appendBubble('user', message);
        chatInput.value = '';

        // Render loading bubble
        const loadingBubble = appendBubble('bot', 'Typing...');

        try {
            const contextPath = window.APP_CONTEXT_PATH || '';
            const response = await fetch(`${contextPath}/api/v1/chat`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({ message: message })
            });

            const data = await response.json();

            if (data.success && data.data && data.data.reply) {
                loadingBubble.textContent = data.data.reply;
            } else if (data.error && data.error.message) {
                loadingBubble.textContent = `Notice: ${data.error.message}`;
            } else {
                loadingBubble.textContent = 'I am currently unable to assist. Please try again shortly.';
            }
        } catch (error) {
            console.error('Chat request error:', error);
            loadingBubble.textContent = 'Connection error. Please check your internet connection.';
        }

        messagesContainer.scrollTop = messagesContainer.scrollHeight;
    });

    function appendBubble(sender, text) {
        const bubble = document.createElement('div');
        bubble.className = `chat-bubble ${sender}`;
        bubble.textContent = text;
        messagesContainer.appendChild(bubble);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
        return bubble;
    }
});
