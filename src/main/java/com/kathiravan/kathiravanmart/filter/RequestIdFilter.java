package com.kathiravan.kathiravanmart.filter;

import org.slf4j.MDC;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

/**
 * Filter that attaches a unique Request ID to SLF4J MDC and response headers.
 * Implements Section 18: Structured logging via Logback with MDC.
 */
public class RequestIdFilter implements Filter {

    private static final String MDC_KEY = "reqId";
    private static final String HEADER_NAME = "X-Request-Id";

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        try {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            String requestId = httpRequest.getHeader(HEADER_NAME);
            if (requestId == null || requestId.trim().isEmpty()) {
                requestId = UUID.randomUUID().toString();
            }

            MDC.put(MDC_KEY, requestId);
            httpResponse.setHeader(HEADER_NAME, requestId);

            chain.doFilter(request, response);
        } finally {
            MDC.remove(MDC_KEY);
        }
    }

    @Override
    public void destroy() {
    }
}
