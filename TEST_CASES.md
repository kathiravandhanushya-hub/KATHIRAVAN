# KathiravanMart - Quality Assurance & Manual Test Cases (TEST_CASES.md)

This document provides the test cases and validation report required by Section 9 (Testing & Validation Requirements) and the Security Checklist.

---

## 1. End-to-End User Journey Test Sheet

| TC ID | Test Scenario | Steps | Expected Result | Status |
|---|---|---|---|---|
| **TC-01** | User Registration (Buyer) | 1. Go to `/register`<br>2. Enter Name, Email, Password, Role=BUYER<br>3. Submit form | User created in DB with BCrypt password hash. Redirected to `/login` with success alert. | **PASS** |
| **TC-02** | User Registration (Seller) | 1. Go to `/register`<br>2. Enter details, Role=SELLER<br>3. Submit form | Seller account registered successfully. | **PASS** |
| **TC-03** | User Authentication & Session | 1. Go to `/login`<br>2. Enter valid credentials<br>3. Submit | Session created, Session ID regenerated, redirected to dashboard/catalog based on role. | **PASS** |
| **TC-04** | Catalog Browse & Search | 1. Go to `/products`<br>2. Filter by category "Electronics"<br>3. Search for "Headphones" | Displays filtered listings matching criteria with active status. | **PASS** |
| **TC-05** | Add to Shopping Cart | 1. From `/products`, click 'Add to Cart'<br>2. Navigate to `/cart` | Product appears in cart. Subtotal and running total computed dynamically. | **PASS** |
| **TC-06** | Update Cart & Remove Item | 1. Change quantity from 1 to 2<br>2. Click update checkmark<br>3. Click remove on another item | Quantity and subtotal update. Removed item deleted from cart. | **PASS** |
| **TC-07** | Checkout & Mock Payment | 1. From `/cart`, click 'Proceed to Checkout'<br>2. Enter shipping address<br>3. Submit mock payment confirmation | Order placed in single transaction. Stock decremented. Cart cleared. Redirected to `/orders`. | **PASS** |
| **TC-08** | Seller Inventory Management | 1. Login as Seller<br>2. Go to `/seller/dashboard`<br>3. Add new product listing | Product saved and immediately visible in marketplace catalog. | **PASS** |
| **TC-09** | Order Status Workflow (O2) | 1. As Seller/Admin, view incoming orders<br>2. Update status from PENDING to SHIPPED | Status updated to SHIPPED. Reflected in buyer order history. | **PASS** |
| **TC-10** | Verified Review & Rating (F8) | 1. Buyer views purchased product on `/products/{id}`<br>2. Fill rating (5 stars) & review comment<br>3. Submit form | Review accepted and average rating updated. Non-purchasers cannot review. | **PASS** |
| **TC-11** | Wishlist / Save-for-Later (O1) | 1. Click 'Save to Wishlist' on product<br>2. Open `/wishlist` | Product visible in wishlist. Can move item directly into shopping cart. | **PASS** |
| **TC-12** | AI Chatbot Interaction (O4) | 1. Click floating chat widget icon<br>2. Ask "How do I place an order?" | Instant conversational domain answer rendered in chat bubble. | **PASS** |
---
## 2. Security Checklist Verification (Section 9 & Section 11)

| Requirement | Implementation Verification | Status |
|---|---|---|
| **SQL Injection Defense** | All SQL statements in DAO implementations exclusively use `PreparedStatement` with parameterized placeholders (`?`). String concatenation is strictly prohibited. Verified via static code search. | **PASS** |
| **Password Hashing** | Passwords are never stored in plaintext and never logged. Hashed using `jBCrypt` with cost factor 10. | **PASS** |
| **Session Fixation Defense** | `request.getSession().invalidate()` followed by `request.getSession(true)` regenerates session ID upon login. 30-minute explicit timeout configured. | **PASS** |
| **XSS Defense** | All dynamic user output rendered across JSP views is escaped using JSTL `<c:out value="..."/>` and JSON serialization via Gson. | **PASS** |
| **Protected Route Enforcement** | `AuthFilter` intercepts protected web routes and `/api/v1/*` endpoints, returning HTTP 401/403 or redirecting unauthenticated users. | **PASS** |
| **Custom Error Pages** | Custom error pages (`400.jsp`, `403.jsp`, `404.jsp`, `500.jsp`) prevent stack trace exposure. | **PASS** |
| **Database Credentials Secrecy** | Database passwords and API keys are stored in `config.properties` / `.env` and excluded from version control via `.gitignore`. | **PASS** |
| **Chatbot Guardrails** | Per-session rate limit (10 req/min), input length cap (250 chars), timeout on outbound calls, and domain prompt restrictions enforced. | **PASS** |
