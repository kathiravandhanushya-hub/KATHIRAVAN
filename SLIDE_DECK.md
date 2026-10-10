# KathiravanMart — Presentation Slide Deck (SLIDE_DECK.md)

---

## Slide 1: Problem Statement & Value Proposition

### 🛒 KathiravanMart: Multi-Seller E-Commerce Marketplace
**Course / Curriculum**: Anna University R2025, Semester 3 Capstone Project  
**Author**: Kathiravan (Solo Builder)  
**Core Technologies**: Java Servlets (javax.servlet.*), JDBC, Apache Tomcat 9.0.x, HikariCP, H2 Database  

### The Challenge
- Traditional single-vendor platforms do not support independent seller inventory management, aggregated shopping carts, or decentralized fulfillment.
- College capstone projects often suffer from monolithic architectures, SQL concatenation risks, and hardcoded external dependencies.

### The Solution: KathiravanMart
- **Multi-Tenant Roles**: Seamless dual role onboarding for Buyers, Sellers, and Platform Administrators.
- **Enterprise Engineering**: Layered MVC over Servlets with strict Front Controller and DAO design patterns.
- **Enterprise Data Integrity**: Atomic order placement, stock management, and BCrypt-hashed credentials.
- **AI-Powered Customer Assistance**: Embedded conversational assistant guiding users through catalog and checkout.

---

## Slide 2: Architecture Sketch & Work Completion

### Architecture Flowchart
```
[Browser / Client (JSP + Vanilla JS + AJAX Fetch)]
                 │ HTTP Request
                 ▼
[Filter Pipeline: RequestIdFilter (MDC) ➔ EncodingFilter ➔ CorsFilter ➔ AuthFilter]
                 │ Filtered Request
                 ▼
[Controller Layer: Thin Servlets (ProductServlet, OrderServlet, ChatServlet)]
                 │ DTOs / Service Invocations
                 ▼
[Service Layer: Business Logic, Input Validation, Payment Strategy, AI Guardrails]
                 │ DAO Interfaces
                 ▼
[DAO Layer: PreparedStatements Only (UserDao, ProductDao, OrderDao, ReviewDao)]
                 │ Try-with-resources
                 ▼
[Connection Pool: HikariCP (ServletContextListener Lifecycle)]
                 │ JDBC Connection
                 ▼
[Database: H2 Relational Database (Server Mode / Embedded Mode)]
```

### Work Status Matrix (100% Completed)
| Module | Deliverable | Status |
|---|---|---|
| **F1** | Authentication (Buyer, Seller, Seed Admin, BCrypt, Session Regeneration) | **100% COMPLETED** |
| **F2** | Seller Dashboard & Product Listing CRUD | **100% COMPLETED** |
| **F3** | Catalog Browsing & Search/Category Filter | **100% COMPLETED** |
| **F4** | Shopping Cart with Live Running Total | **100% COMPLETED** |
| **F5** | Atomic Checkout with Mock Payment Confirmation Strategy | **100% COMPLETED** |
| **F6** | Multi-View Order History (Buyer & Seller specific) | **100% COMPLETED** |
| **F7** | Administrator Panel (User directory, Listing moderation, Metrics) | **100% COMPLETED** |
| **F8** | Verified Product Reviews and Star Ratings on Completed Orders | **100% COMPLETED** |
| **O1–O3**| Wishlist, Order Status Workflow, Seller Revenue Dashboard | **100% COMPLETED** |
| **O4** | AI Chatbot (Gemini LLM Provider + Mock Provider + Rate Limiting) | **100% COMPLETED** |
| **DevOps**| Database Migrations (V1, V2, V3), CI GitHub Actions, Full Test Suite | **100% COMPLETED** |
