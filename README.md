# KathiravanMart — Multi-Seller E-Commerce Marketplace

[![build-and-test](https://github.com/kathiravan/kathiravanmart/actions/workflows/build.yml/badge.svg)](https://github.com/kathiravan/kathiravanmart/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Java 17](https://img.shields.io/badge/JDK-17%20(LTS)-blue.svg)](https://adoptium.net)
[![Servlet 4.0](https://img.shields.io/badge/Tomcat-9.0.x-orange.svg)](https://tomcat.apache.org)

**Course**: Anna University R2025, Semester 3 Capstone Project  
**Author**: Kathiravan (Solo Builder)  
**Package Base**: `com.kathiravan.kathiravanmart`  
**Deployed URL**: [http://localhost:8080/kathiravanmart](http://localhost:8080/kathiravanmart) *(Cloud Deployment link in Section 8)*

---

## 📌 Project Overview & Problem Statement

Modern e-commerce requires multi-vendor capabilities where independent sellers manage individual inventories, buyers discover and purchase diverse goods in an aggregated cart, and administrators maintain marketplace trust and security.

**KathiravanMart** is a full-featured, multi-seller e-commerce marketplace web application designed and built from scratch following the **Layered MVC pattern over Java Servlets (javax.servlet.*), JDBC, HikariCP, and Apache Tomcat 9.0.x**. The system eliminates complex external frameworks in favor of clean design patterns, parameterized SQL security, and robust server-side architecture.

---

## ✨ Features Implemented

### Mandatory Core Features (F1 – F8)
- **F1: User Authentication & Role Management**: Multi-role registration (Buyer, Seller). Administrative privileges seeded securely; BCrypt password hashing; session fixation defense via session regeneration on login; explicit 30-minute session timeout.
- **F2: Seller Inventory Management**: Full CRUD operations for product listings (title, category, price in `DECIMAL(10,2)`, stock quantity, image URL, description).
- **F3: Catalog Browsing & Search Engine**: Real-time product search by keyword and category filtering with pagination-ready architecture.
- **F4: Shopping Cart & Dynamic Total**: Add, update quantities, remove items, with automated live subtotal and running total computation.
- **F5: Checkout & Mock Payment Confirmation**: Single-transaction atomic order creation, automated stock decrementing, and mock payment confirmation via the Strategy pattern.
- **F6: Dual-Role Order History**: Buyer order lifecycle tracking; Seller portal showing incoming orders containing their vendor products.
- **F7: Administrator Governance Panel**: Global user directory oversight, order monitoring, marketplace GMV analytics, and listing moderation/toggling.
- **F8: Verified Product Reviews & Star Ratings**: 1 to 5-star customer ratings and qualitative reviews strictly restricted to buyers with completed orders.

### Optional & Advanced Features (O1 – O5)
- **O1: Wishlist / Save-For-Later**: Save products to personal wishlist and transfer directly into the shopping cart.
- **O2: Order Status Workflow**: Comprehensive state transitions (`PENDING` &rarr; `CONFIRMED` &rarr; `SHIPPED` &rarr; `DELIVERED`).
- **O3: Seller Analytics Dashboard**: Total revenue metrics and order volume tracking.
- **O4: AI Shopping Assistant**: Embedded conversational assistant widget utilizing a server-side proxy servlet, rate limiting (10 req/min), in-memory question caching, and swappable LLM provider (`GeminiChatProvider` and resilient `MockChatProvider`).
- **O5: 525+ Multi-Category Mega Catalog**: Massive pre-seeded marketplace featuring 525+ products across 15 categories: Flipkart Bestsellers (boAt, Noise, SanDisk, Zebronics, Milton, Pigeon, Wildcraft, Sparx), Medicines & Pharmacy (Dolo 650, Crocin, Paracetamol, Dettol, Volini, Digene, Vicks, Electral ORS), 5G Smartphones & Tablets (iPhone 15 Pro Max, Galaxy S24 Ultra, OnePlus 12, Pixel 8 Pro, iPad, Redmi, Realme), Industrial & Mechanical Tools (Bosch Impact Drills, Angle Grinders, Taparia Wrenches & Pliers, Fluke Multimeters, Welding Gear), Daily Groceries & Pantry (India Gate, Fortune, Tata Tea, Ghee, Spices), Home & Kitchen, Fashion & Footwear (Bata, Woodland, Nike, Puma, Levi's), Sports & Fitness (Cricket, Football, Basketball, Gym weights), Automotive & Biking, and Personal Care with frictionless 1-Click login.

---

## 🛠️ Technology Stack Specification

| Component | Specification / Technology | Justification |
|---|---|---|
| **JDK** | Java SE 17 (LTS) | Modern LTS platform, strong typing |
| **Servlet Container** | Apache Tomcat 9.0.x | Native Servlet 4.0 (`javax.servlet.*`) runtime |
| **Build Tool** | Apache Maven 3.8+ | Dependency management, Surefire, CI build lifecycle |
| **Database** | H2 Database (Server / Auto-Server) | Zero-configuration persistence, in-memory testing |
| **Connection Pool** | HikariCP 5.1.0 | High-performance pooled connections managed by `ServletContextListener` |
| **View Layer** | JSP 2.3 + JSTL 1.2 + Vanilla JS | Server-side rendering with AJAX `fetch()` endpoints |
| **JSON Serialization** | Google Gson 2.10.1 | Clean DTO serialization conforming to fixed API envelope |
| **Password Hashing** | jBCrypt 0.4 | Industry standard salted BCrypt hashing (cost 10) |
| **Logging** | SLF4J 2.0 + Logback 1.4 | Structured logging with MDC Request ID correlation |
| **Testing** | JUnit 5 + Mockito 5.11 | DAO tests against `jdbc:h2:mem:test;DB_CLOSE_DELAY=-1` |
| **CI / CD** | GitHub Actions | Automated build & test on every push/PR |

---

## 🏛️ System Architecture

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

### Design Diagrams
Detailed architectural diagrams are documented in [`FINAL_REPORT.md`](file:///c:/Users/ELCOT/Desktop/kathiravan/FINAL_REPORT.md):
- **Diagram D1 (ERD)**: Complete relational schema, foreign key relations, and indexes.
- **Diagram D2 (Use Case)**: Actor interactions for Buyers, Sellers, and Admin.
- **Diagram D3 (Sequence Diagram)**: End-to-end checkout and atomic payment workflow.

---

## 📂 Project Structure

```
kathiravanmart/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── workflows/
│       └── build.yml
├── db/
│   ├── migrations/
│   │   ├── V1__init_schema.sql
│   │   ├── V2__add_reviews_table.sql
│   │   └── V3__add_index_orders_status.sql
│   └── seed.sql
├── src/
│   ├── main/
│   │   ├── java/com/kathiravan/kathiravanmart/
│   │   │   ├── ai/            # ChatProvider, GeminiChatProvider, MockChatProvider
│   │   │   ├── controller/    # Thin HTTP Servlets
│   │   │   ├── dao/           # DAO Interfaces and JDBC implementations
│   │   │   ├── dto/           # Request/Response DTOs & Builder patterns
│   │   │   ├── exception/     # Custom checked/runtime HTTP exceptions
│   │   │   ├── factory/       # DaoFactory and ChatProviderFactory
│   │   │   ├── filter/        # Auth, Logging MDC, Encoding, CORS filters
│   │   │   ├── listener/      # AppContextListener (HikariCP lifecycle)
│   │   │   ├── model/         # Domain POJOs
│   │   │   ├── service/       # Business logic & validations
│   │   │   ├── strategy/      # PaymentStrategy & MockPaymentStrategy
│   │   │   └── util/          # BCrypt, Validation, JSON, and DB utilities
│   │   ├── resources/
│   │   │   ├── config.properties.example
│   │   │   └── logback.xml
│   │   └── webapp/
│   │       ├── css/style.css
│   │       ├── js/            # app.js and chatbot.js
│   │       ├── WEB-INF/
│   │       │   ├── error/     # Custom error pages (400, 403, 404, 500)
│   │       │   ├── fragments/ # Header, nav, and footer JSPF
│   │       │   ├── views/     # JSP server-rendered views
│   │       │   └── web.xml    # Deployment descriptor
│   │       └── index.jsp
│   └── test/
│       ├── java/com/kathiravan/kathiravanmart/  # JUnit 5 & Mockito test suite
│       └── resources/test-schema.sql
├── .env.example
├── .gitignore
├── CHANGELOG.md
├── CONTRIBUTING.md
├── FINAL_REPORT.md
├── pom.xml
├── README.md
├── RETRO.md
├── schema.sql
├── seed.sql
├── SLIDE_DECK.md
└── TEST_CASES.md
```

---

## 🚀 Getting Started & Local Setup

### 1. Prerequisites
- Java SE 17 installed
- Apache Maven 3.8+ installed
- Apache Tomcat 9.0.x installed

### 2. Clone and Configure
```bash
git clone https://github.com/YOUR_USERNAME/kathiravanmart.git
cd kathiravanmart

# Setup configuration
cp .env.example .env
cp src/main/resources/config.properties.example src/main/resources/config.properties
```

### 3. Run Automated Tests
```bash
mvn clean test
```

### 4. Build and Package
```bash
mvn clean package
```
Generates `target/kathiravanmart.war`.

### 5. Deploy to Tomcat
Deploy `kathiravanmart.war` to Tomcat's `webapps/` folder and start Tomcat.

Navigate to:
```
http://localhost:8080/kathiravanmart/
```

---

## 🔑 Pre-Configured Seed Demo Accounts

The database is pre-seeded with sample users for instant evaluation:

| Role | Email | Password | Permissions |
|---|---|---|---|
| **Administrator** | `admin@kathiravanmart.com` | `Admin@123` | Full access: user directory, listing moderation, orders |
| **Seller** | `technova@seller.com` | `Password@123` | Seller hub: add/edit/delete products, incoming orders |
| **Seller** | `urbanstyle@seller.com` | `Password@123` | Apparel catalog seller |
| **Buyer** | `aditya@buyer.com` | `Password@123` | Browse, cart, checkout, order history, verified reviews |
| **Buyer** | `priya@buyer.com` | `Password@123` | Active shopping cart items |

---

## 🔒 Security Compliance Checklist

- [x] **Zero SQL Injection**: 100% of queries use `PreparedStatement` with parameterized placeholders.
- [x] **Salted Password Hashing**: Passwords hashed with `jBCrypt` (cost factor 10); passwords never logged.
- [x] **Session Fixation Defense**: Session invalidated and regenerated upon successful authentication; explicit 30-minute timeout.
- [x] **XSS Mitigation**: Strict escaping on dynamic outputs via JSTL `<c:out>` and JSON serialization.
- [x] **No Stack Trace Leaks**: Custom error handling in `web.xml` for 400, 403, 404, and 500 status codes.
- [x] **Credential Isolation**: `.env` and `config.properties` excluded from Git via `.gitignore`.
- [x] **Chatbot Guardrails**: Session rate limits (10 req/min), prompt injection boundaries, and input length caps.

---

## 👤 Author Information

- **Name**: Kathiravan
- **Degree**: B.E. / B.Tech, Computer Science and Engineering
- **Institution**: Anna University (R2025 Regulation, Semester 3)
- **Role**: Solo Builder
#   K A T H I R A V A N  
 #   K A T H I R A V A N  
 